//
//  LLocationService.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LLocationService.h"

static CLLocationCoordinate2D histroyCoordinate;

@implementation LLocationService

- (id)init{
    self = [super init];
    if (self) {
        [self configLocationManager];
    }
    return self;
}

-(void)startWithCompletionBlockWithSuccess:(void (^)(CLLocationCoordinate2D))success failure:(void (^)(NSError *, CLLocationCoordinate2D))failure{
    [self setCompletionBlock:success failure:failure];
    [self start];
}

- (void)setCompletionBlock:(void (^)(CLLocationCoordinate2D))success failure:(void (^)(NSError *,CLLocationCoordinate2D))failure{
    self.completionBlock = success;
    self.failureBlock = failure;
}

- (void)start{
    [self.locationManager startUpdatingLocation];
}

- (void)clearLocationManager
{
    [self.locationManager stopUpdatingLocation];
    
    //Restore Default Value
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    self.locationManager.delegate = nil;
}

- (void)configLocationManager
{
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
}

#pragma mark - AMapLocationManager Delegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    histroyCoordinate = location.coordinate;
    [self clearLocationManager];
    self.completionBlock(location.coordinate);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    self.failureBlock(error,histroyCoordinate);
}

@end
