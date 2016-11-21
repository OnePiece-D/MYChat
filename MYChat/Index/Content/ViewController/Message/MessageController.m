//
//  DiscoverController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "MessageController.h"

#import "ALocationManager.h"
#import "NewFriendController.h"

#define reuseCell @"friendCell"

@interface MessageController ()

@property (nonatomic, strong) UIView * newFriendBtn;

@property (nonatomic, strong) UITableView * friendList;
@property (nonatomic, strong) NSMutableArray * friendData;

@end

@implementation MessageController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"通讯录";
    [self addRightBarItem:@"添加" action:@selector(addFriends)];
    //监听好友请求
    //[EM_Share.contactManager addDelegate:[EMContactManager manager] delegateQueue:nil];
    //好友关系处理
    //[self friendContact];
    
    //加载内容
    [self addSubView];
    [self setLocation];
    
    [self setUserData];
}


- (void)setUserData {
    [self.friendData setArray:[self getUserList]];
}

- (NSArray*)getUserList {
    EMError *error = nil;
    NSArray *userlist = [EM_Share.contactManager getContactsFromServerWithError:&error];
    if (!error) {
        DLog(@"获取成功%@",userlist);
    }else {
        DLog(@"error:%@",error);
    }
    return nil;
}

#pragma mark -请求-

//添加好友请求
- (void)addFriendRequest:(NSString*)user {
    [EM_Share.contactManager addContact:user message:[NSString stringWithFormat:@"你好我是:%@",UserDefaultObjectForKey(@"username")] completion:^(NSString *aUsername, EMError *aError) {
        if (!aError) {
            [self showHint:@"添加请求已发送"];
        }else {
            [self showHint:@"添加失败！"];
        }
    }];
}

#pragma mark -Action-
//添加好友按钮
- (void)addFriends {
    __weak typeof(self) wSelf = self;
    //[self showHint:@"添加好友" yOffset:36.f];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:@"add new friend" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(UIAlertController*) wAlertVC = alertVC;
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"add" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        [wSelf addFriendRequest:wAlertVC.textFields.firstObject.text];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    RAC(sure, enabled) = [alertVC.textFields.firstObject.rac_textSignal map:^id(id value) {
        NSString * text = (NSString*)value;
        return @(text.length >= 6 ? YES : NO);
    }];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

//确认添加好友
- (void)newFriendsAction {
    //目前不做好友列表
    [self showHint:@"添加新好友"];
}

#pragma mark -tableView_Delegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    
    cell.textLabel.text = [NSString stringWithFormat:@"用户%ld",indexPath.row];
    
    return cell;
}

#pragma mark -EM_好友关系-



#pragma mark -控件添加和位置约束-
- (void)addSubView {
    [self.view addSubview:self.friendList];
    self.friendList.tableHeaderView = self.newFriendBtn;
}

- (void)setLocation {
    __weak typeof(self) wSelf = self;
    [self.friendList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(wSelf.view);
    }];
}

#pragma mark -Lazing-
- (NSMutableArray *)friendData {
    if (!_friendData) {
        _friendData = [NSMutableArray array];
    }
    return _friendData;
}

- (UITableView *)friendList {
    if (!_friendList) {
        _friendList = [RootTableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _friendList.backgroundColor = [UIColor grayColor];
        _friendList.delegate = self;
        _friendList.dataSource = self;
        
        [_friendList registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCell];
    }
    return _friendList;
}

- (UIView*)newFriendBtn {
    if (!_newFriendBtn) {
        //
        _newFriendBtn = [UIView.alloc initWithFrame:CGRectMake(0, 0, 0, 44)];
        UIButton*button = [Factory createBtn:CGRectMake(0, 0, 100, 36) title:@"好友请求" type:UIButtonTypeSystem target:self action:@selector(newFriendsAction)];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_newFriendBtn addSubview:button];
        __weak typeof(UIView*) wView = _newFriendBtn;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wView.mas_centerX);
            make.centerY.equalTo(wView.mas_centerY);
            
            make.size.mas_equalTo(CGSizeMake(100, 36));
        }];
        
        //_newFriendBtn.backgroundColor = [UIColor orangeColor];
        //[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _newFriendBtn;
}

#pragma mark -view-
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc {
    //[EM_Share.contactManager removeDelegate:self];
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
