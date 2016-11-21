//
//  LoginController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "LoginController.h"

#import "TextFieldTwoLineView.h"
#import "EnrollController.h"

@interface LoginController ()

@property (nonatomic, strong) LoginViewModel * viewModel;

//注册等文本输入框
@property (nonatomic, strong) TextFieldTwoLineView * textInputView;
//登录按钮
@property (nonatomic, strong) UIButton * pushBtn;

@end

@implementation LoginController

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBarItem:@"注册" action:@selector(registAction)];
    
    [self addSubView];
    [self setLocation];
    
    [self bindViewModel];
    
    [NotiCenter addObserver:self selector:@selector(notiUserDic:) name:@"ENROLL_USERNAME" object:nil];
    
}


//RAC控制两个按钮的状态
- (void)bindViewModel {
    __weak typeof(self) wSelf = self;
    self.naviTitle = self.viewModel.naviTitle;
    
    RAC(self.viewModel, userName) = self.textInputView.oneLineTextField.textField.rac_textSignal;
    RAC(self.viewModel, passWord) = self.textInputView.twoLineTextField.textField.rac_textSignal;
    
    RAC(self.textInputView.rightView.rightClickBtn, enabled) = self.viewModel.userSignal;
    RAC(self.pushBtn, enabled) = self.viewModel.validSignal;
    [[self.pushBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //点击响应
        [wSelf loginAction];
    }];
    
    self.textInputView.rightViewClickBlock = ^(UIButton* button) {
        wSelf.viewModel.canClickBtn = NO;
        button.enabled = NO;
        
        NSString * originBtnStr = button.titleLabel.text;
        [TimeManager startTime:1 countTime:^(NSInteger count) {
            
            if (10-count > 0) {
                [button setTitle:[NSString stringWithFormat:@"%lds",10-count] forState:UIControlStateNormal];
            }else {
                [button setTitle:originBtnStr forState:UIControlStateNormal];
                wSelf.viewModel.canClickBtn = YES;
                button.enabled = YES;
            }
        }];
    };
}


- (void)loginAction {
    [self.textInputView endEditing];
    __weak typeof(self) wSelf = self;
    self.pushBtn.enabled = NO;
    
    NSString * username = self.textInputView.oneLineTextField.textField.text;
    NSString * password = self.textInputView.twoLineTextField.textField.text;
    [EM_Share loginWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            UserDefaultSetObjectForKey(aUsername, @"username");
            [EM_Share.options setIsAutoLogin:YES];
            [wSelf dismissViewControllerAnimated:YES completion:nil];
        }else {
            [self showHint:@"登录失败" yOffset:36.f];
        }
        self.pushBtn.enabled = YES;
    }];
}

- (void)registAction {
    EnrollController * enrollVC = [EnrollController.alloc initWithViewModel:[LoginViewModel.alloc init]];
    [self.navigationController pushViewController:enrollVC animated:YES];
}

#pragma mark -控件位置-
- (void)setLocation {
    __weak typeof(self) wSelf =self;
    __weak typeof(UIView*) weakView = self.view;
    [self.textInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakView);
        make.top.equalTo(weakView).offset(15);
        make.height.mas_equalTo(@90);
    }];
    [self.pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakView).offset(20);
        make.right.equalTo(weakView).offset(-20);
        make.top.equalTo(wSelf.textInputView.mas_bottom).offset(20);
        make.height.mas_offset(@50);
    }];
}

#pragma mark -添加视图-
- (void)addSubView {
    [self.view addSubview:self.textInputView];
    [self.view addSubview:self.pushBtn];
}

#pragma mark -其他的处理-
//通知的账户名
- (void)notiUserDic:(NSNotification*)noti {
    NSDictionary * info = noti.userInfo;
    //key: username password
    [self.textInputView setOneLine:info[@"username"] twoLine:info[@"password"]];
    self.pushBtn.enabled = YES;
}

//登录处理
- (void)loginUser:(NSString *)user passWord:(NSString *)passWord {
    //登录处理
    EMError *error = [EM_Share loginWithUsername:user password:passWord];
    if (!error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else {
        DLog(@"%@",error);
    }
}

//注册处理
- (void)registUser:(NSString *)user passWord:(NSString *)passWord {
    //注册处理
    EMError *error =  [EM_Share registerWithUsername:user password:passWord];
    if (!error) {
        [self alert:nil message:@"注册成功！" sure:nil cancel:nil singleCancel:YES];
    }else {
        DLog(@"%@",error);
    }
}

#pragma mark -各种加载-
- (TextFieldTwoLineView *)textInputView {
    if (!_textInputView) {
        _textInputView = [TextFieldTwoLineView.alloc initWithFrame:CGRectZero placeholder:@[@"请输入账号",@"请输入密码"] response:@"获取验证码"];
        
    }
    return _textInputView;
}

- (UIButton *)pushBtn {
    if (!_pushBtn) {
        _pushBtn = [Factory createBtn:CGRectZero title:@"登录" type:UIButtonTypeCustom target:nil action:nil];
        
        [Factory setBackgroundBtn:_pushBtn
                           normal:[UIImage imageWithColor:[UIColor orangeColor]]
                        highlight:[UIImage imageWithColor:[UIColor grayColor]]
                         selected:[UIImage imageWithColor:[UIColor grayColor]]
                           enable:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        
        _pushBtn.layer.cornerRadius = 8.f;
        _pushBtn.clipsToBounds = YES;
    }
    return _pushBtn;
}

#pragma mark -touch-
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.textInputView endEditing];
}

#pragma mark -view_detail-
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [TimeManager cancelTimer];
    
    [self.textInputView endEditing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
