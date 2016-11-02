//
//  RegularExpression.h
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpressionTool : NSObject

+ (BOOL)isPhoneNum:(NSString*)phone;

+ (BOOL)isPassWordNum:(NSString*)num;

@end
