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
    
    [[self manager] GET:method parameters:param progress:nil success:success failure:failure];
}


+ (void)post:(NSString *)method
       param:(NSDictionary *)param
    progress:(void (^)(NSProgress * _Nonnull))uploadProgress
     success:(void(^)(NSURLSessionDataTask* _Nonnull task,id _Nullable responseObject))success
     failure:(void(^)(NSURLSessionDataTask*_Nullable task,NSError*_Nonnull error))failure{
    
    [[self manager] POST:method parameters:param progress:uploadProgress success:success failure:failure];
}

//HTTP manager
+ (AFHTTPSessionManager*)manager {
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager.alloc initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@:%@",BaseUrl, PORT]] sessionConfiguration:config];
    manager.requestSerializer = [AFJSONRequestSerializer serializer] ;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/html",@"text/json",@"text/javascript",nil];
    return manager;
}

@end
