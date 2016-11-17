//
//  NetManager.m
//  MYChat
//
//  Created by ycd15 on 16/11/16.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

+(void)get:(NSString *)method
     param:(NSDictionary *)param
   success:(void(^)(NSURLSessionDataTask* _Nonnull task,id _Nullable responseObject))success
failure:(void(^)(NSURLSessionDataTask*_Nullable task,NSError*_Nonnull error))failure{
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //http://127.0.0.1:8081/index.html
    AFHTTPSessionManager * manager = [AFHTTPSessionManager.alloc initWithBaseURL:[NSURL URLWithString:@"http://127.0.0.1:8081"] sessionConfiguration:config];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:method parameters:nil progress:nil success:success failure:failure];
}

@end
