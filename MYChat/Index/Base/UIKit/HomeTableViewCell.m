//
//  HomeTableViewCell.m
//  MYChat
//
//  Created by ycd15 on 16/11/21.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "HomeTableViewCell.h"


@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        
        __weak typeof(UIView*) weakView = self.contentView;
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakView.mas_centerY);
            make.left.equalTo(weakView.mas_left).offset(8);
            make.width.mas_offset(@100);
        }];
    }
    return self;
}

- (void)setValueWithModel:(UserModel*)model {
    self.nameLabel.text = model.name;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel.alloc init];
        _nameLabel.font = kFont(14);
    }
    return _nameLabel;
}

@end
