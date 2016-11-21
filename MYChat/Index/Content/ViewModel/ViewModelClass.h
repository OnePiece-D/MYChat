//
//  ViewModelClass.h
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock) ();

typedef void (^NetWorkBlock) (BOOL netConnetState);

@interface ViewModelClass : NSObject

@property (nonatomic, strong) ReturnValueBlock returnBlock;
@property (nonatomic, strong) ErrorCodeBlock errorBlock;
@property (nonatomic, strong) FailureBlock failureBlock;


/**
 网络请求的模块
 */
- (void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock
                     errorBlock:(ErrorCodeBlock)errorBlock
                   failureBlock:(FailureBlock)failureBlock;

//跳转页面的数据
- (void)pushWithModel:(id)model
              frontVC:(UIViewController*)frontVC
             behindVC:(UIViewController*)behindVC;

@end
