//
//  ChatConfig.h
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EMSDK.h"


#define EM_Share [EMClient sharedClient]

@interface ChatConfig : NSObject

+ (instancetype)shareConfig;

- (void)setEMAppKey:(NSString *)appKey apnsName:(NSString *)apsName;

@end
