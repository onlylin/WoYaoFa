//
//  LLMapBaseService.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LLMapBaseService.h"
#import "AMapKey.h"

@implementation LLMapBaseService

- (id)init{
    self = [super init];
    if (self) {
        [self initMapView];
        [self initLocationManager];
        [self initSearchApi];
    }
    return self;
}

- (void)initMapView{
    [MAMapServices sharedServices].apiKey = (NSString*)GD_KEY;
    self.mapView.frame = self.bounds;
    self.mapView.delegate = self;
    [self addSubview:self.mapView];
}


- (void)initLocationManager{
    [AMapLocationServices sharedServices].apiKey = (NSString*)GD_KEY;
    self.locationManager.delegate = self;
}

- (void)initSearchApi{
    [AMapSearchServices sharedServices].apiKey = (NSString*)GD_KEY;
    self.search.delegate = self;
}

#pragma mark - Getter and Setter
- (MAMapView*)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] init];
    }
    return _mapView;
}

- (AMapLocationManager*)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[AMapLocationManager alloc] init];
    }
    return _locationManager;
}

- (AMapSearchAPI*)search{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
    }
    return _search;
}

@end
