//
//  ChatConfig.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "ChatConfig.h"

@implementation ChatConfig

+ (instancetype)shareConfig {
    static ChatConfig * handleObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handleObj = [ChatConfig.alloc init];
    });
    return handleObj;
}

- (void)setEMAppKey:(NSString *)appKey apnsName:(NSString *)apsName {
    EMOptions * options = [EMOptions optionsWithAppkey:appKey];
    options.apnsCertName = apsName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

@end
