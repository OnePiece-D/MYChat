//
//  RegularExpression.m
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "RegularExpressionTool.h"

@implementation RegularExpressionTool

+ (BOOL)isPhoneNum:(NSString *)phone {
    NSString *numberRegex = @"^1[34578]\d{9}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [carTest evaluateWithObject:phone];
}

+ (BOOL)isPassWordNum:(NSString *)num {
    NSString * numberRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [test evaluateWithObject:num];
}

@end
