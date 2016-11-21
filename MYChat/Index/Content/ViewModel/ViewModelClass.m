//
//  ViewModelClass.m
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "ViewModelClass.h"

@implementation ViewModelClass

- (void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock
                     errorBlock:(ErrorCodeBlock)errorBlock
                   failureBlock:(FailureBlock)failureBlock {
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}



/**
 页面的跳转

 @param model 传递的model参数
 @param frontVC A
 @param behindVC B跳转后的页面
 */
- (void)pushWithModel:(id)model
              frontVC:(UIViewController *)frontVC
             behindVC:(UIViewController *)behindVC {
    [frontVC.navigationController pushViewController:behindVC animated:YES];
}

@end
