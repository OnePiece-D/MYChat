//
//  RootViewController.m
//  MYChat
//
//  Created by ycd15 on 16/9/26.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UILabel * naviTitleView;
@property (nonatomic, strong) UIBarButtonItem * leftBar;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.naviTitleView;
    self.navigationItem.backBarButtonItem = self.leftBar;
}


#pragma mark -alert-
- (void)alert:(NSString *)title
      message:(NSString *)message
      handler:(void(^)(UIAlertAction*))action{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:action];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -navi-

//title
- (void)setNaviTitle:(NSString *)naviTitle {
    self.naviTitleView.text = naviTitle;
}

- (UILabel *)naviTitleView {
    if (!_naviTitleView) {
        _naviTitleView = [UILabel.alloc initWithFrame:CGRectMake(0, 0, 100, 44)];
        
        _naviTitleView.textAlignment = NSTextAlignmentCenter;
        _naviTitleView.font = kFont(14);
    }
    return _naviTitleView;
}


//left-Bar
- (UIBarButtonItem *)leftBar {
    if (!_leftBar) {
#warning 这里打算事件分离
        
    }
    return _leftBar;
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
