//
//  LinApiManager+LineAndCompany.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+LineAndCompany.h"

static NSString *LIST_COMPANY_ACTION = @"webapi/companies/list";

static NSString *LIST_LINE_ACTION = @"webapi/lines/list";

@implementation LinApiManager (LineAndCompany)

/**
 *  查询附近物流公司
 *
 *  @param distance 距离
 *  @param lat      纬度
 *  @param lng      经度
 *
 *  @return
 */
- (RACSignal*)getCompaniesByDistance:(NSInteger)distance lat:(NSString *)lat lng:(NSString *)lng{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%@/%@",HOST,LIST_COMPANY_ACTION,distance,lat,lng];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendGet:url params:nil success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

/**
 *  查询附近线路
 *
 *  @param distance 距离
 *  @param lat      纬度
 *  @param lng      经度
 *  @param begin    始发地
 *  @param end      目的地
 *
 *  @return
 */
- (RACSignal *)getLineByDistance:(NSInteger)distance lat:(NSString *)lat lng:(NSString *)lng begin:(NSString *)begin end:(NSString *)end{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,LIST_LINE_ACTION];
    NSDictionary *params = @{
                             @"distance" : @(distance),
                             @"lat" : lat,
                             @"lng" : lng,
                             @"begin" : begin,
                             @"end" : end
                             };
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sendPost:url params:params success:^(LinBaseRequest *request) {
            [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
            [subscriber sendCompleted];
        } failure:^(LinBaseRequest *request) {
            
        }];
        return nil;
    }];
}



@end
