//
//  Singleton.m
//  MYChat
//
//  Created by ycd15 on 16/11/22.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "Singleton.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#define LONGCONNECT @"longConnect"

@implementation Singleton

+ (instancetype)sharedInstance {
    static Singleton * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeOut = -1;
        self.longConnect = LONGCONNECT;
    }
    return self;
}


- (void)openServerOnPort:(uint16_t)port {
    NSError * error = nil;
    BOOL result = [self.serverSocket acceptOnPort:port error:&error];
    if (result && error == nil) {
        //开放成功
        NSLog(@"开放成功");
    }
}


- (void)socketConnectHost {
    NSError *error = nil;
    BOOL result = [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:_timeOut error:&error];
    if (result == YES) {
        DLog(@"成功监听");
    }else {
        DLog(@"监听失败");
    }
}

- (void)sendMessage:(NSString *)msg {
    NSData * data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:_timeOut tag:0];
}

- (void)getMessage:(NSData*)dataMsg {
    if (self.readDataBlock) {
        self.readDataBlock(dataMsg);
    }
}

//
- (void)cutOffSocket {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    [self.socket disconnect];
}


//心跳连接
- (void)longConnectToSocket {
    NSData * dataStream = [self.longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:dataStream withTimeout:_timeOut tag:0];
}

#pragma mark -async delegate-
//服务端的
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    if (sock == self.serverSocket) {
        //保存客户端的socket
        self.clientSocket = newSocket;
        [self.clientSocket readDataWithTimeout:_timeOut tag:0];
    }
}

//用户端的
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    if (self.socket == sock) {
        DLog(@"连接成功就定时发送心跳包");
        __weak typeof(self) wSelf = self;
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 30 * NSEC_PER_SEC), 30 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            [wSelf longConnectToSocket];
        });
        dispatch_resume(self.timer);
        
        [sock readDataWithTimeout:_timeOut tag:0];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if (self.socket) {
        DLog(@"%s",__func__);
        if (err) {
            [self socketConnectHost];
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    DLog(@"%s",__func__);
}

//收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    if (sock == self.clientSocket) {
        //
        NSString * text = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"serverSocket:%@",text);
        
        [self getMessage:data];
        
        [self.clientSocket readDataWithTimeout:_timeOut tag:0];
    }else if (sock == self.socket) {
        NSString * text = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"receipt:%@",text);
        
        [self getMessage:data];
        [self.socket readDataWithTimeout:_timeOut tag:0];
    }
}

- (GCDAsyncSocket *)serverSocket {
    if (!_serverSocket) {
        _serverSocket = [GCDAsyncSocket.alloc initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    return _serverSocket;
}

- (GCDAsyncSocket *)socket {
    if (!_socket) {
        _socket = [GCDAsyncSocket.alloc initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    return _socket;
}

//获取所有相关IP信息
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

@end
