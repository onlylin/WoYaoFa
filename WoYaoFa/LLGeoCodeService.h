//
//  LLGeoCodeService.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LLMapBaseService.h"

@interface LLGeoCodeService : LLMapBaseService

@property (nonatomic, copy) void (^reGeocodecompletionBlock)(AMapReGeocodeSearchResponse *response);
@property (nonatomic, copy) void(^geocodecompletionBlock)(AMapGeocodeSearchResponse *response);

- (void)startReGeocodeSearch:(CLLocationCoordinate2D)coordinate success:(void(^)(AMapReGeocodeSearchResponse *response))success;

- (void)startGeocodeSearch:(NSString*)address success:(void(^)(AMapGeocodeSearchResponse *response))success;

@end
