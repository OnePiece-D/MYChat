//
//  YCDAccessJudge.m
//  YcdFrameWork
//
//  Created by ycd15 on 16/9/13.
//  Copyright © 2016年 YCD. All rights reserved.
//

#import "AccessJudge.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>

@implementation AccessJudge

+ (BOOL)authority:(AuthorityType)type {
    switch (type) {
        case Type_Photo:
        {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted ||
                status == PHAuthorizationStatusDenied) {
                //无权限
                return NO;
            }else {
                return YES;
            }
        }
        break;
        case Type_Camera:
        {
            AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
            {
                //无权限
                return NO;
            }else {
                return YES;
            }
        }
        break;
        case Type_Location:
        {
            if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
                
                //定位功能可用
                return YES;
            }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
                
                //定位不能用
                return NO;
            }
        }
        break;
            
        default:
            return NO;
            break;
    }
    return NO;
}

@end
