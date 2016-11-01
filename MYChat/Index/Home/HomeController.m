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
#import "DiscoverController.h"

#import "ChatRoomController.h"

@interface HomeController ()
@property (nonatomic, weak) id<myProtocol> protocol;

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
    self.naviTitle = @"开始";
//    LoginController * VC = [[LoginController alloc] init];
//    NaviController * navi = [[NaviController alloc] initWithRootViewController:VC];
//    [self presentViewController:navi animated:YES completion:nil];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 30);
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    UIButton * roomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    roomBtn.frame = CGRectMake(100, 150, 100, 30);
    [roomBtn setTitle:@"ROOM" forState:UIControlStateNormal];
    [roomBtn addTarget:self action:@selector(roomAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roomBtn];
}

- (void)action {
    LoginController<myProtocol> * VC = [[LoginController<myProtocol> alloc] init];
    self.protocol = VC;
    UINavigationController * navi = [UINavigationController.alloc initWithRootViewController:VC];
    if ([self.protocol respondsToSelector:@selector(setMyName:)]) {
        [self.protocol setMyName:@"asdadaw"];
    }
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)roomAction {
//    ChatRoomController * roomVC = [ChatRoomController.alloc initWithConversationChatter:USER_ONE conversationType:EMConversationTypeChat];
//    [self.navigationController pushViewController:roomVC animated:YES];
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
