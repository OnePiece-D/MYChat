//
//  EMContactManager.m
//  MYChat
//
//  Created by ycd15 on 16/11/4.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "EMContactManager.h"

@implementation EMContactManager

+ (instancetype)manager {
    static EMContactManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EMContactManager.alloc init];
    });
    return manager;
}



@end
