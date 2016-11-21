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
        
        //防止tableView被导航栏覆盖
//        self.edgesForExtendedLayout = UIRectEdgeNone;     
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count > 1) {
        //push的都加返回的
        [self addLeftBarItem:@"naviBack" selected:@"naviBackHighlight" action:nil];
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.naviTitleView;
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
- (void)addLeftBarItem:(NSString *)name action:(SEL)action {
    [self addLeftBarItem:name selected:nil action:action];
}

- (void)addLeftBarItem:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setLeftBarButtonItem:[self addBarButtonItem:imageName selectedName:selectedName action:action]];
    UIButton * button = self.navigationItem.leftBarButtonItem.customView;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -44, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -44, 0, 0);
}

//right-Bar
- (void)addRightBarItem:(NSString *)name action:(SEL)action {
    [self addRightBarItem:name selected:nil action:action];
}

- (void)addRightBarItem:(NSString *)imageName selected:(NSString *)selectedName action:(SEL)action {
    if (!action) {
        action = @selector(popOrDismiss);
    }
    [self.navigationItem setRightBarButtonItem:[self addBarButtonItem:imageName selectedName:selectedName action:action]];
    UIButton * button = self.navigationItem.rightBarButtonItem.customView;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -23);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -23);
}

//添加图片或者字体在BarItem上
- (UIBarButtonItem*)addBarButtonItem:(NSString*)name selectedName:(NSString *)selectedName action:(SEL)action {
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    //仅当两个都不是 nil 时才是添加图片，否则就是字体
    if (name && selectedName) {
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedName] forState:UIControlStateHighlighted];
    }else {
        NSLog(@"name:%@",name);
        [button setTitle:name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    button.titleLabel.font = kFont(14);
    
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
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

#pragma mark -Toast-
- (void)showToast:(NSString *)toast {
    [self.view makeToast:toast];
}

#pragma mark -Method-
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
