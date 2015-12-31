
//
//  LinApiManager+Order.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Order.h"

static const NSString *LIST_ACTION = @"webapi/orders/list";

static const NSString *ADD_ACTION = @"webapi/orders/add";

static const NSString *CANCEL_ACTION = @"webapi/orders/cancel";

static const NSString *COMFIRM_ACTION = @"webapi/orders/comfirm";

static const NSString *UPLOAD_ACTION = @"webapi/orders/upload";

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

/**
 *  增加一个订单
 *
 *  @param order 订单信息
 *
 *  @return
 */
- (RACSignal*)addOrder:(WOrder *)order{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,ADD_ACTION];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sendPost:url params:order.mj_keyValues success:^(LinBaseRequest *request) {
            [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
            [subscriber sendCompleted];
        } failure:^(LinBaseRequest *request) {
            
        }];
        return nil;
    }];
}

/**
 *  取消订单
 *
 *  @param orderId 订单ID
 *  @param status  订单状态
 *
 *  @return
 */
- (RACSignal*)cancelOrder:(NSInteger)orderId orderStatus:(OrderStatus)status{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld",HOST,CANCEL_ACTION,orderId,status];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendGet:url params:nil success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

/**
 *  确认订单
 *
 *  @param orderId 订单ID
 *
 *  @return
 */
- (RACSignal*)confirmOrder:(NSInteger)orderId{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld",HOST,COMFIRM_ACTION,orderId];
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
 *  上传图片
 *
 *  @param images
 *  @param orderId
 *
 *  @return 
 */
- (RACSignal*)uploadImages:(NSArray *)images ordre:(NSInteger)orderId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,UPLOAD_ACTION];
    NSDictionary *params = @{
                            @"orderId" : @(orderId)
                            };
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self uploadImage:url formDatas:images params:params success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

@end
