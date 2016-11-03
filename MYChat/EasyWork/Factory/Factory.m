//
//  Factory.m
//  MYChat
//
//  Created by ycd15 on 16/11/1.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "Factory.h"

@implementation Factory

//快速创建基本的button
+ (UIButton *)createBtn:(CGRect)frame
                  title:(NSString *)title
                   type:(UIButtonType)type
                 target:(id)target
                 action:(SEL)action {
    UIButton * button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    if (type != UIButtonTypeSystem) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    //action
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (void)setBackgroundBtn:(UIButton *)btn
                  normal:(UIImage *)normal
               highlight:(UIImage *)highlight
                selected:(UIImage *)selected
                  enable:(UIImage *)enable {
    [btn setBackgroundImage:normal forState:UIControlStateNormal];
    [btn setBackgroundImage:highlight forState:UIControlStateHighlighted];
    [btn setBackgroundImage:selected forState:UIControlStateSelected];
    [btn setBackgroundImage:enable forState:UIControlStateDisabled];
}

@end
