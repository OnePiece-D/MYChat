//
//  MineController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "MineController.h"

#import "Singleton.h"

@interface MineController ()



@end

@implementation MineController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"我";
    
    
    UIButton * button = [Factory createBtn:CGRectMake(100, 100, 80, 30) title:@"Send" type:UIButtonTypeSystem target:self action:@selector(sendMessage)];
    UIButton * getBtn = [Factory createBtn:CGRectMake(100, 180, 80, 30) title:@"get" type:UIButtonTypeSystem target:self action:@selector(getMessage)];
    
    UILabel * title = [UILabel.alloc initWithFrame:CGRectMake(100, 250, 80, 30)];
    title.font = kFont(14);
    [self.view addSubview:button];
    [self.view addSubview:getBtn];
    [self.view addSubview:title];
    
    
    Singleton * singleton = [Singleton sharedInstance];
    NSDictionary * dic = [singleton getIPAddresses];
    singleton.socketHost = [dic objectForKey:@"bridge100/ipv4"];
    singleton.socketPort = 8088;//默认就8080了
    
    [singleton openServerOnPort:8088];
    
    __weak typeof(UILabel*) wLabel = title;
    singleton.readDataBlock = ^(NSData * data){
        NSString * readStr = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        wLabel.text = readStr;
    };
}

- (void)sendMessage {
    [[Singleton sharedInstance] sendMessage:@"天气有点儿冷!"];
}

- (void)getMessage {
    Singleton * singleton = [Singleton sharedInstance];
    
    [singleton socketConnectHost];
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
