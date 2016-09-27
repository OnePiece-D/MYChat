//
//  HomeViewController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@property (nonatomic, strong) UITextField * username;
@property (nonatomic, strong) UITextField * passWord;


@property (nonatomic, strong) UIButton * pushBtn;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"开始";
    
    
    [self.view addSubview:self.username];
    [self.view addSubview:self.passWord];
    [self.view addSubview:self.pushBtn];
    
    [self.pushBtn setTitle:@"PUSH" forState:UIControlStateNormal];
    [self.pushBtn setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateNormal];
    
    /*
    RACSignal * usernameSourceSignal = self.textField.rac_textSignal;
    RACSignal * filteredUsername = [usernameSourceSignal filter:^BOOL(id value) {
        NSString * text = value;
        return text.length > 3;
    }];
    [filteredUsername subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [[[_textField.rac_textSignal filter:^BOOL(id value) {
        NSString * text = value;
        return text.length > 3;
    }] map:^id(id value) {
        NSString * text = value;
        return text.length % 2 == 0 ? [UIColor clearColor] : [UIColor orangeColor];
    }] subscribeNext:^(id x) {
        _textField.backgroundColor = (UIColor*)x;
    }];
     */
    
//    RACSignal * usernameSignal = [self.textField.rac_textSignal map:^id(id value) {
//        return @([(NSString *)value isEqualToString:@"123123"]);
//    }];
//    [[usernameSignal map:^id(id value) {
//        return [value boolValue] == YES ? [UIColor clearColor] : [UIColor orangeColor];
//    }] subscribeNext:^(id x) {
//        self.textField.backgroundColor = (UIColor*)x;
//    }];
    
    
//    RAC(self.textField, backgroundColor) = [usernameSignal map:^id(id value) {
//        return [value boolValue] == YES ? [UIColor clearColor] : [UIColor orangeColor];
//    }];

//    RAC(self.pushBtn, titleLabel.textColor) = [[self.textField.rac_textSignal map:^id(id value) {
//        return @([(NSString *)value isEqualToString:@"123123"]);
//    }] map:^id(id value) {
//        return [value boolValue]==YES ? [UIColor blueColor] : [UIColor redColor];
//    }];
    RACSignal * validUsernameSignal = [self.username.rac_textSignal map:^id(id value) {
        return @([(NSString*)value isEqualToString:@"123123"]);
    }];
    RACSignal * validPasswordSignal = [self.passWord.rac_textSignal map:^id(id value) {
        return @([(NSString *)value isEqualToString:@"123123"]);
    }];
    
    RACSignal * signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal,validPasswordSignal] reduce:^id(NSNumber * usernameValid, NSNumber * passwordValid){
        return [usernameValid boolValue] && [passwordValid boolValue] ? @"Sign" : @"Pus";
    }];
    RAC(self.pushBtn, titleLabel.text) = signUpActiveSignal;
    
    
    [[self.pushBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"click");
    }];
}

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
