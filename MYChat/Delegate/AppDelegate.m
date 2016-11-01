//
//  AppDelegate.m
//  MYChat
//
//  Created by ycd15 on 16/9/23.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "AppDelegate.h"

#import "NaviConfig.h"
#import "TabBarConfig.h"

#import "ChatConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [UIWindow.alloc initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //环信注册
    [[ChatConfig shareConfig] setEMAppKey:EM_APPKEY apnsName:EM_PUSH_DEV];
    
    [[NaviConfig config] defaultConfig];
    
    self.window.rootViewController = [TabBarConfig setTabBar];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


/**
 APP进入后台

 @param application 配置进入后台时的参数
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //环信的配置
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
    /**
     *  其他的配置
     */
}


/**
 APP将要从后台返回

 @param application 配置将要从后台返回的参数
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    //环信的配置
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    
    /**
     *  其他的配置
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
