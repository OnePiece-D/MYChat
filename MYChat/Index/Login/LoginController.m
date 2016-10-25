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

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}


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
