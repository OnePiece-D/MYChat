//
//  LoginViewModel.m
//  MYChat
//
//  Created by ycd15 on 16/11/3.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _canClickBtn = YES;
        
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.naviTitle = @"登录";
    self.userSignal = [RACObserve(self, userName) map:^id(id value) {
        NSString * userName =(NSString*)value;
        return @(userName.length >= 6 && _canClickBtn ? YES : NO);
    }];
    self.passWordSignal = [RACObserve(self, passWord) map:^id(id value) {
        NSString* passWord = (NSString*)value;
        return @(passWord.length >= 6 ? YES : NO);
    }];
    
    self.validSignal = [RACSignal combineLatest:@[self.userSignal,self.passWordSignal] reduce:^id(NSNumber* userName,NSNumber*passWord){
        return @([userName intValue] && [passWord integerValue]);
    }];
    
    self.excuteSignal = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self excuteSignal];
    }];
    
}

- (RACSignal*)excuteSignal {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:nil];
        [subscriber sendCompleted];
        return nil;
    }] map:^id(id value) {
        return value;
    }];
}

@end
