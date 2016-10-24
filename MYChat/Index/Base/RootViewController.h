//
//  RootViewController.h
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyWork.h"

@interface RootViewController : UIViewController

@property (nonatomic, copy) NSString * naviTitle;

#pragma mark -alert-
- (void)alert:(NSString *)title
      message:(NSString *)message
      handler:(void(^)(UIAlertAction*))action;

@end
