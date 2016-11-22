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

#import "HomeViewModel.h"
#import "HomeTableViewCell.h"


#define reuseCellName @"homeCell"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * friendList;

@property (nonatomic, strong) NSArray * friendData;

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
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
//    if (!UserDefaultObjectForKey(@"username")) {
//        LoginViewModel * viewModel = [LoginViewModel.alloc init];
//        LoginController * VC = [LoginController.alloc initWithViewModel:viewModel];
//        NaviController * navi = [NaviController.alloc initWithRootViewController:VC];
//        [self presentViewController:navi animated:YES completion:nil];
//    }
    
    __weak typeof(self) wSelf = self;
    HomeViewModel * homeViewModel = [HomeViewModel.alloc init];
    [homeViewModel setBlockWithReturnBlock:^(id returnValue) {
        //array
        _friendData = returnValue;
        [wSelf.friendList reloadData];
    } errorBlock:^(id errorCode) {
        //dic
        [self showToast:@"网络error了！"];
    } failureBlock:^{
        //failure
        [self showToast:@"网络出问题了！"];
    }];
    [homeViewModel fetchNetRequest];
    
    [self.view addSubview:self.friendList];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _friendData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellName];
    [cell setValueWithModel:_friendData[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableView*)friendList {
    if (!_friendList) {
        _friendList = [Factory createTableView:self.view.bounds target:self cell:[HomeTableViewCell class] reuseName:reuseCellName];
    }
    return _friendList;
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
