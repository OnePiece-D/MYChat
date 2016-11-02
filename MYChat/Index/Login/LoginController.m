//
//  LoginController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "LoginController.h"
#import "myProtocol.h"
@interface LoginController ()<myProtocol>

@property (nonatomic, strong) UITextField * username;
@property (nonatomic, strong) UITextField * passWord;


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


#pragma mark -控件位置-
- (void)setLocation {
    __weak typeof(self) wSelf =self;
    __weak typeof(UIView*) wView = self.view;
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wView).offset(100);
        make.right.equalTo(wView).offset(-100);
        
        make.top.equalTo(wView).offset(100);
        make.height.mas_equalTo(@44);
    }];
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wView).offset(100);
        make.right.equalTo(wView).offset(-100);
        
        make.top.equalTo(wSelf.loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
    }];
}

#pragma mark -添加视图-
- (void)addSubView {
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registBtn];
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
- (UITextField *)username {
    if (!_username) {
        _username = [UITextField.alloc initWithFrame:CGRectMake(100, 100, 100, 30)];
        
        _username.layer.borderColor = RGBCOLOR(255, 0, 0).CGColor;
        _username.layer.borderWidth = 1.f;
    }
    return _username;
}

- (UITextField *)passWord {
    if (!_passWord) {
        _passWord = [UITextField.alloc initWithFrame:CGRectMake(100, 150, 100, 30)];
        
        _passWord.layer.borderColor = RGBCOLOR(255, 0, 0).CGColor;
        _passWord.layer.borderWidth = 1.f;
    }
    return _passWord;
}

- (UIButton *)pushBtn {
    if (!_pushBtn) {
        _pushBtn = [UIButton.alloc initWithFrame:CGRectMake(100, 200, 100, 30)];
        
        
        [_pushBtn setTitle:@"Sign" forState:UIControlStateNormal];
        [_pushBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        
        [_pushBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
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
