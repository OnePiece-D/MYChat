//
//  TabBarConfig.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "TabBarConfig.h"

#import "RootViewController.h"

@implementation TabBarConfig

+ (UITabBarController*)setTabBar {
    TabBarController * tabBar = [TabBarController.alloc init];
    NSArray * tabBarArray = @[@"HomeController",@"DiscoverController",@"MineController"];
    NSArray * titleArray = @[@"首页",@"发现",@"我的"];
    NSMutableArray * VCArray = [NSMutableArray array];
    int i = 0;
    for (NSString * tabBarTitle in tabBarArray) {
        RootViewController * VC = [NSClassFromString(tabBarTitle).alloc init];
        NaviController * navi = [NaviController.alloc initWithRootViewController:VC];
        navi.title = titleArray[i++];
        
        [VCArray addObject:navi];
    }
    [tabBar setViewControllers:VCArray];
    return tabBar;
}

@end
