//
//  TextFieldView.m
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "TextFieldView.h"

@implementation TextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _levelSpace = 8.f;             //水平间距
        _isSecret = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubView];
        [self setSubViewLocation];
        [self setDisplay];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    if ([self initWithFrame:frame]) {
        //
        [self setContent:placeholder];
    }
    return self;
}


#pragma mark -公共的方法-
- (void)setLineHiden:(BOOL)hiden mid:(BOOL)mid lineDir:(Line_Dir)lineDir {
    __weak typeof(self) wSelf = self;
    switch (lineDir) {
        case Line_Top:
        {
            //上部的
            self.topLine.hidden = hiden;
            [self.topLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(wSelf).offset(_levelSpace);
                //make.right.equalTo(wSelf).offset(-_levelSpace);
            }];
        }
            break;
        case Line_Bottom:
        {
            //下部的
            self.bottomLine.hidden = hiden;
            [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(wSelf).offset(_levelSpace);
                //make.right.equalTo(wSelf).offset(-_levelSpace);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setIsSecret:(BOOL)isSecret {
    _isSecret = isSecret;
    
    self.textField.secureTextEntry = isSecret;
}

- (void)endEditing {
    [self.textField endEditing:YES];
}

#pragma mark -私有的方法-

//内容
- (void)setContent:(NSString*)content {
    self.textField.placeholder = content;
}

//样式
- (void)setDisplay {
    self.topLine.backgroundColor = LINE_COLOR;
    self.bottomLine.backgroundColor = LINE_COLOR;
    
    _textField.font = kFont(14);
}

//位置
- (void)setSubViewLocation {
    __weak typeof(self) wSelf = self;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf).offset(4.f);
        make.bottom.equalTo(wSelf).offset(-4.f);
        make.left.equalTo(wSelf).offset(_levelSpace);
        make.right.equalTo(wSelf).offset(-_levelSpace);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
}

//添加SubView
- (void)addSubView {
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.textField];
}


#pragma mark -Lazing-
- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField.alloc initWithFrame:CGRectZero];
        
    }
    return _textField;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}

@end
