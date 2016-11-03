//
//  DiscoverController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "MessageController.h"

#import "ALocationManager.h"


@interface MessageController ()

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
    [EM_Share.contactManager addDelegate:self delegateQueue:nil];
    
    //好友列表
    [self getUserList];
    
}

- (void)getUserList {
    EMError *error = nil;
    NSArray *userlist = [EM_Share.contactManager getContactsFromServerWithError:&error];
    if (!error) {
        DLog(@"获取成功%@",userlist);
    }
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


#pragma mark -EM_Delegate-
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage {
    [self showHint:@"有新的好友请求"];
}


#pragma mark -view-
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)dealloc {
    [EM_Share.contactManager removeDelegate:self];
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
