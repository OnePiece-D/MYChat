//
//  UserDefaultUtil.m
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "UserDefaultUtil.h"

@implementation UserDefaultUtil

+ (void)setObject:(nullable id)data forKey:(nonnull NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeObject:(nullable id)data forKey:(nonnull NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (nullable id)getObjectForKey:(nullable NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
