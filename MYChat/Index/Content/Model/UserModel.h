//
//  UserModel.h
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "RootModel.h"

@interface UserModel : RootModel

@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSNumber * age;
@property (nonatomic, copy) NSString * hoby;

@end
