//
//  HomeViewModel.m
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)fetchNetRequest {
    //获取主页数据列表
    [NetManager get:@"index" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 1) {
            //成功
            [self successData:responseObject];
        }else {
            //失败
            [self errorData:responseObject];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureBlock];
    }];
}


//成功的数据处理
- (void)successData:(NSDictionary*)responseObject {
    //UserModel
    NSArray * statuses = responseObject[@"list"];
    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary * dic in statuses) {
        UserModel * model = [UserModel mj_objectWithKeyValues:dic];
        [dataArray addObject:model];
    }
    self.returnBlock(dataArray);
}

//异常
- (void)errorData:(NSDictionary*)errorDic {
    self.errorBlock(errorDic);//看code和message
}

//错误
- (void)failureData {
    self.failureBlock();
}

@end
