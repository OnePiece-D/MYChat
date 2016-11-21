//
//  HomeTableViewCell.h
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;

- (void)setValueWithModel:(UserModel*)model;

@end
