//
//  NaviConfig.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "NaviConfig.h"

@implementation NaviConfig

+ (instancetype)config {
    static NaviConfig * config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [NaviConfig.alloc init];
    });
    return config;
}

- (void)defaultConfig {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
}


@end
