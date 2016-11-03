//
//  TextFieldTwoLineView.m
//  MYChat
//
//  Created by ycd15 on 16/11/2.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "TextFieldTwoLineView.h"

#import "RegularExpressionTool.h"

@interface TextFieldTwoLineView()

@property (nonatomic, strong) TextFieldView * username;
@property (nonatomic, strong) TextFieldView * passWord;

@end

@implementation TextFieldTwoLineView

{
    NSInteger _rightViewType;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubView];
        [self setSubViewLocation];
        [self setDisplay];
    
        
        self.oneLineTextField = self.username;
        self.twoLineTextField = self.passWord;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSArray *)array
                     response:(id)response {
    if ([self initWithFrame:frame]) {
        
        //array
        self.username.textField.placeholder = array.firstObject;
        if (array.count > 1) {
            self.passWord.textField.placeholder = array.lastObject;
        }
        
        if ([[response class] isSubclassOfClass:[NSString class]]) {
            //文字    默认灰色不可点击
            [self.rightView.rightClickBtn setTitle:response forState:UIControlStateNormal];
            _rightViewType = 1;
            
        }else if ([[response class] isSubclassOfClass:[NSArray class]]) {
            //按钮可   第一个默认 第二个选中状态
            [self.rightView.rightClickBtn setImage:[UIImage imageNamed:[response firstObject]] forState:UIControlStateNormal];
            [self.rightView.rightClickBtn setImage:[UIImage imageNamed:[response lastObject]] forState:UIControlStateSelected];
            _rightViewType = 2;
        }
        
        //设置
        [self setRightViewSize];
        
        
        __weak typeof(self) wSelf = self;
        self.rightView.rightBtnClickBlock = ^(UIButton *clickBtn) {
            [wSelf endEditing];
            
            if (wSelf.rightViewClickBlock) {
                wSelf.rightViewClickBlock(clickBtn);
            }
            
        };
    }
    return self;
}

#pragma -Method-
- (void)endEditing {
    [self.oneLineTextField endEditing];
    [self.twoLineTextField endEditing];
}

- (void)setOneLine:(NSString *)oneLineStr
           twoLine:(NSString *)twoLineStr {
    if (oneLineStr.length) {
        self.username.textField.text = oneLineStr;
    }
    if (twoLineStr.length) {
        self.passWord.textField.text = twoLineStr;
    }
}

#pragma mark -系统配置-
//样式
- (void)setDisplay {
    [_username setLineHiden:NO mid:YES lineDir:Line_Bottom];
    _passWord.topLine.hidden = YES;
}

//位置
- (void)setSubViewLocation {
    __weak typeof(self) wSelf =self;
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf);
        make.height.equalTo(@45);
    }];
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.username);
        make.top.equalTo(wSelf.username.mas_bottom);
        make.height.equalTo(wSelf.username.mas_height);
    }];
    
//    
//    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(wSelf.passWord.textField);
//        make.right.equalTo(wSelf.passWord).offset(-8);
//    }];
}

- (void)setRightViewSize {
    //获取frame
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGFloat height = self.passWord.textField.frame.size.height;
    CGFloat width = [self.rightView.rightClickBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:kFont(12)}].width + 6.f;
    self.rightView.frame = CGRectMake(0, 0, width, height);
}

//添加SubView
- (void)addSubView {
    [self addSubview:self.username];
    [self addSubview:self.passWord];
    
    //[self.passWord addSubview:self.rightView];
    //[self.passWord addSubview:self.rightClickBtn];
    self.passWord.textField.rightView = self.rightView;
    self.passWord.textField.rightViewMode =UITextFieldViewModeAlways;
}

#pragma mark -各种加载-
- (TextFieldView *)username {
    if (!_username) {
        _username = [TextFieldView.alloc initWithFrame:CGRectZero placeholder:@"请输入账号"];
    }
    return _username;
}

- (TextFieldView *)passWord {
    if (!_passWord) {
        _passWord = [TextFieldView.alloc initWithFrame:CGRectZero placeholder:@"请输入密码"];
    }
    return _passWord;
}

-(TextFieldRightView *)rightView {
    if (!_rightView) {
        _rightView = [TextFieldRightView.alloc initWithFrame:CGRectZero];
    }
    return _rightView;
}

@end

@implementation TextFieldRightView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        _canRepeatClick = NO;
        
        [self addSubview:self.verticalLine];
        [self addSubview:self.rightClickBtn];
        
        
        [self.rightClickBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.verticalLine.backgroundColor = LINE_COLOR;
        [self.rightClickBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.rightClickBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        //[self.rightClickBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        
        __weak typeof(self) wSelf = self;
        [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(wSelf);
            make.width.mas_offset(@1.f);
        }];
        [self.rightClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(wSelf);
            make.left.equalTo(wSelf.verticalLine.mas_right).offset(4.f);
        }];
    }
    return self;
}

//action
- (void)rightBtnAction:(id)sender {
    
    UIButton*btn = (UIButton*)sender;
    
    if (_canRepeatClick == NO) {
        btn.enabled = NO;
    }else {
        btn.selected = !btn.selected;
    }
    if (self.rightBtnClickBlock) {
        self.rightBtnClickBlock(btn);
    }
}


#pragma mark -With-rightBtnView-Lazing-
- (UIView *)verticalLine {
    if (!_verticalLine) {
        _verticalLine = [UIView new];
    }
    return _verticalLine;
}

- (UIButton *)rightClickBtn {
    if (!_rightClickBtn) {
        _rightClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _rightClickBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _rightClickBtn;
}

@end
