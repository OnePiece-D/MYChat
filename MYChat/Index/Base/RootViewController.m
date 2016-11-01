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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

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
      sure:(void(^)(UIAlertAction*))sureAction
       cancel:(void(^)(UIAlertAction*))cancelAction singleCancel:(BOOL)single {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelAction];
    [alert addAction:cancel];
    if (single != YES) {
        
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:sureAction];
        [alert addAction:sure];
    }
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
        _naviTitleView.textColor = [UIColor whiteColor];
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

//left-Bar
- (void)addLeftBarItem:(NSString *)name action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setLeftBarButtonItem:[self addBarButtonItem:name selectedName:nil action:action]];
}

- (void)addLeftBarItem:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setLeftBarButtonItem:[self addBarButtonItem:imageName selectedName:selectedName action:action]];
}

//right-Bar
- (void)addRightItem:(NSString *)name action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setRightBarButtonItem:[self addBarButtonItem:name selectedName:nil action:action]];
}

- (void)addRIghtItemImage:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setRightBarButtonItem:[self addBarButtonItem:imageName selectedName:selectedName action:action]];
}

//添加图片或者字体在BarItem上
- (UIBarButtonItem*)addBarButtonItem:(NSString*)name selectedName:(NSString *)selectedName action:(SEL)action {
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    //仅当两个都不是 nil 时才是添加图片，否则就是字体
    if (name && selectedName) {
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedName] forState:UIControlStateHighlighted];
    }else {
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

- (void)popOrDismiss {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
