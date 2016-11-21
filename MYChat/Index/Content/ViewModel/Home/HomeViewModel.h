//
//  HomeViewModel.h
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "ViewModelClass.h"

#import "UserModel.h"

@interface HomeViewModel : ViewModelClass

//获取主页内容的数据
- (void)fetchNetRequest;


@end
