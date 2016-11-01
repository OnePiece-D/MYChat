//
//  Factory.h
//  MYChat
//
//  Created by ycd15 on 16/11/1.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Factory : NSObject

/**
 *  创建UIButton
 */
+ (UIButton*)createBtn:(CGRect)frame
                 title:(NSString *)title
                  type:(UIButtonType)type
                target:(nullable id)target
                action:(nullable SEL)action;



@end
