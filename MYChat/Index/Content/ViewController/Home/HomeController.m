//
//  HomeViewController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "HomeController.h"

#import "NaviController.h"
#import "LoginController.h"

@interface HomeController ()


@end

@implementation HomeController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"消息";
    
    if (!UserDefaultObjectForKey(@"username")) {
        LoginViewModel * viewModel = [LoginViewModel.alloc init];
        LoginController * VC = [LoginController.alloc initWithViewModel:viewModel];
        NaviController * navi = [NaviController.alloc initWithRootViewController:VC];
        [self presentViewController:navi animated:YES completion:nil];
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
