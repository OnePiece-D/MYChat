//
//  UserDefaultUtil.h
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultUtil : NSObject

/**
 *  用于快速存储
 */
+ (void)setObject:(nullable id)data forKey:(nonnull NSString*)key;
+ (void)removeObject:(nullable id)data forKey:(nonnull NSString*)key;
+ (nullable id)getObjectForKey:(nullable NSString*)key;

@end
