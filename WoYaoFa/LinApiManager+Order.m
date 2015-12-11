
//
//  LinApiManager+Order.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Order.h"

static const NSString *LIST_ACTION = @"webapi/orders/list";

@implementation LinApiManager (Order)

/**
 *  获取订单列表
 *
 *  @param accountId 账号ID
 *  @param status    订单状态
 *  @param pageIndex
 *  @param pageSize
 *
 *  @return 
 */
- (RACSignal*)getOrders:(NSInteger)accountId orderStatus:(OrderStatus)status pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld/%ld/%ld",HOST,LIST_ACTION,accountId,status,pageIndex,pageSize];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sendGet:url params:nil success:^(LinBaseRequest *request) {
            [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
            [subscriber sendCompleted];
        } failure:^(LinBaseRequest *request) {
            
        }];
        return nil;
    }];
}

@end
