//
//  TextFieldView.h
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "RootView.h"

#import <Masonry/Masonry.h>


#define LINE_HEIGHT 1.0f

typedef NS_ENUM(NSInteger,Line_Dir) {
    Line_Top = 0,
    Line_Bottom
};

@interface TextFieldView : RootView

/**
 上面和下面的分割线
 */
@property (nonatomic, strong) UIView * topLine;
@property (nonatomic, strong) UIView * bottomLine;

/**
 输入的文本框
 */
@property (nonatomic, strong) UITextField * textField;

//如果设置居中的话是距离边缘的距离 默认20px
@property (nonatomic, assign) CGFloat levelSpace;
//是否设置为密码模式 默认 NO
@property (nonatomic, assign) BOOL isSecret;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString*)placeholder;


/**
 设定上下部的线

 @param hiden   是否隐藏
 @param mid     是否居中    _levelSpace默认20px
 @param lineDir 是上部线还是下部的
 */
- (void)setLineHiden:(BOOL)hiden mid:(BOOL)mid lineDir:(Line_Dir)lineDir;

- (void)endEditing;

@end
