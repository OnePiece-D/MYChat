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

@property (nonatomic, strong) id model;

/**
 *  导航栏
 */
//left-Bar  action可以使是nil
- (void)addLeftBarItem:(NSString *)name action:(SEL)action;
- (void)addLeftBarItem:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action;
//right-Bar
- (void)addRightBarItem:(NSString *)name action:(SEL)action;
- (void)addRightBarItem:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action;

#pragma mark -alert-
- (void)alert:(NSString *)title
      message:(NSString *)message
         sure:(void(^)(UIAlertAction*))sureAction
       cancel:(void(^)(UIAlertAction*))cancelAction
  singleCancel:(BOOL)single;

#pragma mark -Toast-
- (void)showToast:(NSString *)toast;


@end
