//
//  ALocationManager.h
//  MYChat
//
//  Created by ycd15 on 16/10/24.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/**
    使用位置服务需要在Info中添加:
        1:Privacy - Location Always Usage Description
        2:Privacy - Location When In Use Usage Description
    以上两条的使用描述
        
 
 */


@interface ALocationManager : NSObject<CLLocationManagerDelegate>

/*
 *  位置管理
 */
@property (nonatomic, strong) CLLocationManager * locationManager;

@property (nonatomic, copy) void (^updateLocation) (CLLocation *location,CGFloat latitude,CGFloat longitude);
@property (nonatomic, copy) void (^loactionFail) (NSInteger);

+ (instancetype)shareManager;

- (BOOL)startServe;

@end
