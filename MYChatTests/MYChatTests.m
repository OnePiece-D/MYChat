//
//  MYChatTests.m
//  MYChatTests
//
//  Created by ycd15 on 16/9/23.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <UIKit/UIKit.h>

//waitForExpectationsWithTimeout是等待时间，超过了就不再等待往下执行。
#define WAIT do {\
[self expectationForNotification:@"RSBaseTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);

#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"RSBaseTest" object:nil];


#import "NetManager.h"

@interface MYChatTests : XCTestCase

@end

@implementation MYChatTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}



//网络测试
- (void)testRequest {
    [NetManager get:@"index" param:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@",responseObject);
        NOTIFY;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"erro:%@",error);
        NOTIFY;
    }];
    WAIT;
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    /*
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];*/
}

@end
