//
//  ALocationManager.m
//  MYChat
//
//  Created by ycd15 on 16/10/24.
//  Copyright © 2016年 YCD_WYL. All rights reserved.
//

#import "ALocationManager.h"

#import "AccessJudge.h"

@implementation ALocationManager

+ (instancetype)shareManager {
    static ALocationManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ALocationManager alloc] init];
    });
    if([manager startServe] == NO) {
        return nil;
    };
    
    return manager;
}

- (BOOL)startServe {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    if ([AccessJudge authority:Type_Location] == YES) {
        [self.locationManager startUpdatingLocation];
        return YES;
    }
    return NO;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation * location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    if (self.updateLocation) {
        self.updateLocation(location,coordinate.latitude,coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.loactionFail) {
        self.loactionFail(error.code);
    }
}


- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [CLLocationManager.alloc init];
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
    }
    return _locationManager;
}

@end
