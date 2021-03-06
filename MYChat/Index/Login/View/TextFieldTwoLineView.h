//
//  TextFieldTwoLineView.h
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "RootView.h"

#import "TextFieldView.h"

@class TextFieldRightView;

@interface TextFieldTwoLineView : RootView

//一二行的内容
@property (nonatomic, strong) TextFieldView * oneLineTextField;
@property (nonatomic, strong) TextFieldView * twoLineTextField;

@property (nonatomic, strong) TextFieldRightView * rightView;

@property (nonatomic, copy) void(^rightViewClickBlock) (UIButton*);

//respons 传入NSString 就是字符串或者NSArray是图片[@"默认",@"选中"]
- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSArray*)array
                     response:(id)response;


- (void)setOneLine:(NSString*)oneLineStr
           twoLine:(NSString*)twoLineStr;

- (void)endEditing;


@end

@interface TextFieldRightView : UIView

//验证码什么的竖直的分割线
@property (nonatomic, strong) UIView * verticalLine;
//和他所在一行的textField有交互
@property (nonatomic, strong) UIButton * rightClickBtn;

//默认是不可以重复点击的
@property (nonatomic, assign) BOOL canRepeatClick;

@property (nonatomic, copy) void(^rightBtnClickBlock)(UIButton*);

@end
