//
//  LoginViewModel.h
//  MYChat
//
//  Created by ycd15 on 16/11/3.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString * naviTitle;
//密码输入框的内容
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * passWord;

//信号
@property (nonatomic, strong) RACSignal *userSignal;
@property (nonatomic, strong) RACSignal *passWordSignal;

@property (nonatomic, assign) BOOL canClickBtn;

@property (nonatomic, strong) RACSignal * validSignal;

//按钮的响应
@property (nonatomic, strong) RACCommand * excuteSignal;



@end
