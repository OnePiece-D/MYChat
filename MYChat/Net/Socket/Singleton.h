//
//  Singleton.h
//  MYChat
//
//  Created by ycd15 on 16/11/22.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0;\
__strong static id sharedInstance = nil;\
dispatch_once(&onceToken,^{\
sharedInstance = block();\
});\
return sharedInstance;\

typedef NS_ENUM(NSInteger, SocketOfflineType) {
    SocketOfflineByServer, //服务器掉线，默认为0
    SocketOfflineByUser,   //用户主动cut
};


@interface Singleton : NSObject<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket * serverSocket;
@property (nonatomic, strong) GCDAsyncSocket * clientSocket;

@property (nonatomic, strong) GCDAsyncSocket * socket;  //scoket

@property (nonatomic, copy) NSString * socketHost;  //socket 的Host
@property (nonatomic, assign) UInt16 socketPort;    //socket 的prot

@property (nonatomic, strong) dispatch_source_t timer;


/**
 *  心跳链接发送数据
 */
@property (nonatomic, strong) NSString * longConnect;

//default -1
@property (nonatomic, assign) NSInteger timeOut;

//接收的数据
@property (nonatomic, copy) void (^readDataBlock) (NSData*);

+ (instancetype)sharedInstance;

#pragma mark -服务端-
- (void)openServerOnPort:(uint16_t)port;

#pragma mark -用户端-

/**
 socket链接
 */
- (void)socketConnectHost;


- (void)sendMessage:(NSString*)msg;

/**
 断开socket链接
 */
- (void)cutOffSocket;



/**
 *  获取设备IP信息
 */
- (NSDictionary *)getIPAddresses;


@end
