//
//  PayManager.h
//  MYChat
//
//  Created by ycd15 on 16/10/17.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PayManager : NSObject

+ (instancetype)sharePay;


+ (void)setPayParamCallback:(void(^)(NSDictionary*))callback;

@end
