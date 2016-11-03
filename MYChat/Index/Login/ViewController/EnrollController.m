//
//  EnrollController.m
//  MYChat
//
//  Created by ycd15 on 16/11/3.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "EnrollController.h"
#import "TextFieldView.h"

@interface EnrollController ()

@property (nonatomic, strong) LoginViewModel * viewModel;

@property (nonatomic, strong) TextFieldView * userName;
@property (nonatomic, strong) TextFieldView * passWord;

@property (nonatomic, strong) UIButton * enrollBtn;

@end

@implementation EnrollController

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"注册";
    
    [self addSubView];
    [self setLocation];
    [self setDisplay];
    
    [self bindViewModel];
}


- (void)enrollAction {
    __weak typeof(self) wSelf = self;
    self.enrollBtn.enabled = NO;
    
    NSString * username = self.userName.textField.text;
    NSString * password = self.passWord.textField.text;
    [EM_Share registerWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            //成功
            [NotiCenter postNotificationName:@"ENROLL_USERNAME" object:nil userInfo:@{@"username":aUsername, @"password":password}];
            [wSelf.navigationController popViewControllerAnimated:YES];
        }else {
            DLog(@"aError:%@",aError);
        }
        
        self.enrollBtn.enabled = YES;
    }];
}

- (void)bindViewModel {
    __weak typeof(self) wSelf = self;
    RAC(self.viewModel, userName) = self.userName.textField.rac_textSignal;
    RAC(self.viewModel, passWord) = self.passWord.textField.rac_textSignal;
    
    RAC(self.enrollBtn, enabled) = self.viewModel.validSignal;
    [[self.enrollBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [wSelf endEditing];
        NSLog(@"enroll:%@",x);
        [wSelf enrollAction];
    }];
}

- (void)setDisplay {
    [self.userName setLineHiden:NO mid:YES lineDir:Line_Bottom];
    [self.passWord setLineHiden:YES mid:NO lineDir:Line_Top];
}

- (void)setLocation {
    __weak typeof(self) wSelf = self;
    __weak typeof(UIView*) weakView = self.view;
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakView);
        make.top.equalTo(weakView).offset(8);
        make.height.mas_equalTo(@45);
    }];
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.userName);
        make.top.equalTo(wSelf.userName.mas_bottom);
        make.height.equalTo(wSelf.userName);
    }];
    
    [self.enrollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakView).offset(20);
        make.right.equalTo(weakView).offset(-20);
        make.top.equalTo(wSelf.passWord.mas_bottom).offset(15);
        make.height.mas_equalTo(@50);
    }];
}

- (void)addSubView {
    [self.view addSubview:self.userName];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.enrollBtn];
}

- (UIButton *)enrollBtn {
    if (!_enrollBtn) {
        _enrollBtn = [Factory createBtn:CGRectZero title:@"注册" type:UIButtonTypeCustom target:nil action:nil];
        
        [Factory setBackgroundBtn:_enrollBtn
                           normal:[UIImage imageWithColor:[UIColor orangeColor]]
                        highlight:[UIImage imageWithColor:[UIColor grayColor]]
                         selected:[UIImage imageWithColor:[UIColor grayColor]]
                           enable:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        
        _enrollBtn.layer.cornerRadius = 8.f;
        _enrollBtn.clipsToBounds = YES;
    }
    return _enrollBtn;
}

- (TextFieldView *)userName {
    if (!_userName) {
        _userName = [TextFieldView.alloc initWithFrame:CGRectZero placeholder:@"注册账号"];
    }
    return _userName;
}

- (TextFieldView *)passWord {
    if (!_passWord) {
        _passWord = [TextFieldView.alloc initWithFrame:CGRectZero placeholder:@"注册密码"];
        
        _passWord.isSecret = YES;
    }
    return _passWord;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self endEditing];
}

- (void)endEditing {
    [self.userName endEditing];
    [self.passWord endEditing];
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
