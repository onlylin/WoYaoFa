//
//  LLGeoCodeService.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LLGeoCodeService.h"

@implementation LLGeoCodeService


- (void)startReGeocodeSearch:(CLLocationCoordinate2D)coordinate success:(void (^)(AMapReGeocodeSearchResponse *))success{
    [self setReGeocodeCompletionBlock:success];
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:fabs(coordinate.longitude)];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)startGeocodeSearch:(NSString *)address success:(void (^)(AMapGeocodeSearchResponse *))success{
    
}

- (void)setGeocodeCompletionBlock:(void(^)(AMapGeocodeSearchResponse*)) success{
    self.geocodecompletionBlock = success;
}

- (void)setReGeocodeCompletionBlock:(void(^)(AMapReGeocodeSearchResponse *)) success{
    self.reGeocodecompletionBlock = success;
}



#pragma mark - AMapSearchDelegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.addressComponent.district];
        if (result && result.length > 0) {
            self.reGeocodecompletionBlock(response);
        }
        
    }
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.geocodes.count != 0) {
        //通过AMapGeocodeSearchResponse对象处理搜索结果
        NSString *strCount = [NSString stringWithFormat:@"count: %ld", response.count];
        NSString *strGeocodes = @"";
        for (AMapTip *p in response.geocodes) {
            strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
        }
        NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
        NSLog(@"Geocode: %@", result);
    }
}



@end
