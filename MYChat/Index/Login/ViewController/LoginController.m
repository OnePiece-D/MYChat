//
//  LoginController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "LoginController.h"

#import "TextFieldTwoLineView.h"

@interface LoginController ()

@property (nonatomic, strong) TextFieldTwoLineView * textInputView;


@property (nonatomic, strong) UIButton * pushBtn;

//登录和注册按钮
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton * registBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    [self addLeftBarItem:@"返回" action:nil];
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.pushBtn];
    
    [self.pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [self.pushBtn setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateNormal];
    
    RACSignal * validUsernameSignal = [self.username.rac_textSignal map:^id(id value) {
        return @([(NSString*)value isEqualToString:@"123123"]);
    }];
    RACSignal * validPasswordSignal = [self.passWord.rac_textSignal map:^id(id value) {
        return @([(NSString *)value isEqualToString:@"123123"]);
    }];
    
    RACSignal * signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal,validPasswordSignal] reduce:^id(NSNumber * usernameValid, NSNumber * passwordValid){
        return [usernameValid boolValue] && [passwordValid boolValue] ? @YES : @NO;
    }];
    RAC(self.pushBtn, enabled) = signUpActiveSignal;
    
    @weakify(self);
    [[self.pushBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self requestNetResult];
    }];
     */
    
    [self addSubView];
    [self setLocation];
}

#pragma mark -Action-
- (void)clickAction:(id)sender {
    __weak typeof(self) wSelf = self;
    if (sender == _loginBtn) {
        [self alert:nil message:@"选择登录" sure:^(UIAlertAction * actionSure) {
            //One用户
            [wSelf loginUser:USER_ONE passWord:USER_ONE_PASSWORD];
        } cancel:^(UIAlertAction * actionCancel) {
            //two用户
            [wSelf loginUser:USER_TWO passWord:USER_TWO_PASSWORD];
        } singleCancel:NO];
        
        
    }else if(sender == _registBtn) {
        [self alert:nil message:@"选择注册" sure:^(UIAlertAction * actionSure) {
            //One用户
            [wSelf registUser:USER_ONE passWord:USER_TWO_PASSWORD];
        } cancel:^(UIAlertAction * actionCancel) {
            //two用户
            [wSelf registUser:USER_TWO passWord:USER_TWO_PASSWORD];
            
        } singleCancel:NO];
    }else {
        [self alert:nil message:@"没有对应信息" sure:nil cancel:nil singleCancel:YES];
    }
}

//RAC控制两个按钮的状态


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

#pragma mark -其他的没啥用的-

- (void)setMyName:(NSString *)name {
    NSLog(@"%@",name);
}

- (void)requestNetResult {
    self.pushBtn.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pushBtn.enabled = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    });
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
        _textInputView = [TextFieldTwoLineView.alloc initWithFrame:CGRectZero placeholder:@[
                                                                                            @"请输入账号",@"请输入密码"
                                                                                            ] response:@"获取验证码"];
    }
    return _textInputView;
}

- (UIButton *)pushBtn {
    if (!_pushBtn) {
        _pushBtn = [Factory createBtn:CGRectZero title:@"登录" type:UIButtonTypeCustom target:self action:@selector(clickAction:)];
        
    }
    return _pushBtn;
}


#pragma ###############################################################################
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [Factory createBtn:CGRectZero title:@"登录" type:UIButtonTypeSystem target:self action:@selector(clickAction:)];
    }
    return _loginBtn;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [Factory createBtn:CGRectZero title:@"注册" type:UIButtonTypeSystem target:self action:@selector(clickAction:)];
    }
    return _registBtn;
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
