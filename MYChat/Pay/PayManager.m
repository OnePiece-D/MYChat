//
//  PayManager.m
//  MYChat
//
//  Created by ycd15 on 16/10/17.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "PayManager.h"

#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation PayManager

+ (instancetype)sharePay {
    static PayManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PayManager alloc] init];
    });
    return manager;
}

+ (void)setPayParamCallback:(void(^)(NSDictionary*))callback {
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2016092801989043";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOnHGLTnwZvUnNZGZT7qjj+FKnko/UYllLWSn2/E3wCJOwN7kYDjI4fauTqixG0yYUP/2ZdCCgwfTz4LjY8qc9Yc+HE79pZhJILw5otdjQZFXC5N6HU7QuDI3fNh/JO+j8sJKzay2iWUfQ76mKiKBZ1FtMIF783nVTl/rcjmi223AgMBAAECgYA5vo//v283SqEi3GiNzeotDnubSeClvwqofvsa5Iog28TT62XZbEGOgRxXu3TBdDxKS5w3nHxW2jT8omXpAxdxRvFJxLZq4Yi8wQWP+oJMLldDOQl1uEDOxIK+voc5RdD+FApGHD5U2r3qH9TZ3HV8U2YNTl4dlDepA3W2pzhv4QJBAP080A7LrslPjgHVhk86pHDxRjkbkJBl+WXXwGoiqxynGJsgTdQVTKW9Z3ZjgZd61zk5JvoDhAJ2wcMHBzVpDlsCQQDsU/DI90so8ud+4Ctzn4NIUA+cqj+KTxkFwoazL8BSS9Jr4uW7Fcx0PWUh7EDs2/uc/KNjy7ZXqQ9ALqlzKDTVAkEA5KuESMf+JgRzfA5/AI44rVABlFHiwbGDekZPlseFchMlMfcCsG8nTkZw5cPG4q1nKWIFYx/HlZ39K4nuJXmfHwJBAOm8M59wBiQf6hmwOQmIMF3q4SX/tAxlIshxlqvOhJZga2NM7A3XB3nH5yhf8+7Pu9GOhUMEjfmxOWYvQGSm1WkCQQCsLfBVyP6Zpj/kAMVhQ2jrD0/95OlrlzrtwwTt+LiK8MDFaQXTocVwJp+6VsYFQCWUK0C6 jiNxZsk3YmstHQDv";
    
    
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        NSLog(@"-----------------------");
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //order.biz_content.seller_id = @"2088102174911831";
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"myChat";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:callback];
    }
}


+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
