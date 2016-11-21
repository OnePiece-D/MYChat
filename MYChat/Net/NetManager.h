//
//  NetManager.h
//  MYChat
//
//  Created by ycd15 on 16/11/16.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseUrl @"http://127.0.0.1"
#define PORT @"8080"

@interface NetManager : NSObject

+(void)get:(NSString *)method
     param:(NSDictionary *)param
   success:(void(^)(NSURLSessionDataTask* _Nonnull task,id _Nullable responseObject))success
   failure:(void(^)(NSURLSessionDataTask*_Nullable task,NSError*_Nonnull error))failure;

+ (void)post:(NSString *)method
       param:(NSDictionary *)param
    progress:(void (^)(NSProgress * _Nonnull))uploadProgress
     success:(void(^)(NSURLSessionDataTask* _Nonnull task,id _Nullable responseObject))success
     failure:(void(^)(NSURLSessionDataTask*_Nullable task,NSError*_Nonnull error))failure;

@end
