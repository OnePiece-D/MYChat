//
//  EMContactManager.h
//  MYChat
//
//  Created by ycd15 on 16/11/4.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EM_UserName @"username"
#define EM_Message @"message"

#import "EMSDK.h"

@interface EMContactManager : NSObject<EMContactManagerDelegate>

/**
 *  用户B同意用户A的加好友请求后，用户A会收到这个回调    用户B
 */
@property (nonatomic, copy) void(^receiveUserApproveBlock)(NSString*);
//@property (nonatomic, strong) NSString * receiveUserApprove;

/**
 *  用户B拒绝用户A的加好友请求后，用户A会收到这个回调    用户B
 */
@property (nonatomic, copy) void(^receiveUserDecLineBlock)(NSString*);
//@property (nonatomic, strong) NSString * receiveUserDecLine;

/**
 *  用户B删除与用户A的好友关系后，用户A会收到这个回调    用户B
 */
@property (nonatomic, copy) void(^receiveUserRemoveBlock)(NSString*);
//@property (nonatomic, strong) NSString * receiveUserRemove;

/**
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调  另一方
 */
@property (nonatomic, copy) void(^didAddUserBlock)(NSString*);
//@property (nonatomic, strong) NSString * didAddUser;

/**
 *  用户B申请加A为好友后，用户A会收到这个回调  {@"username":value,@"message":valu}
 */
@property (nonatomic, copy) void(^receiveFromUserBlock)(NSDictionary*);
//@property (nonatomic, strong) NSMutableDictionary * receiveFromUser;

+ (instancetype)manager;

@end
