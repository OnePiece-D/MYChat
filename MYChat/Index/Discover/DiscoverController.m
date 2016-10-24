//
//  DiscoverController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "DiscoverController.h"

#import "ALocationManager.h"

@interface DiscoverController ()

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"新大陆";
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ALocationManager * locationManager = [ALocationManager shareManager];
    
    if (locationManager) {
        //有权限
        @weakify(self);
        locationManager.updateLocation = ^(CLLocation *location,CGFloat latitude,CGFloat longitude){
            @strongify(self);
            
            [self alert:nil message:@"你好" handler:nil];
        };
    }else {
        [self alert:nil message:@"没有权限" handler:^(UIAlertAction * action) {
            
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
