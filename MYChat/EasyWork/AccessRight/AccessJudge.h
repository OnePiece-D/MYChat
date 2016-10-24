//
//  YCDAccessJudge.h
//  YcdFrameWork
//
//  Created by ycd15 on 16/9/13.
//  Copyright © 2016年 YCD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AuthorityType) {
    Type_Photo = 0,
    Type_Camera,
    Type_Location
};

@interface AccessJudge : NSObject

+ (BOOL)authority:(AuthorityType)type;

@end
