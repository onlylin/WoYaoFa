//
//  LinApiManager+Collection.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Collection.h"

static const NSString *LIST_ACTION = @"webapi/collections/list";

static const NSString *CANCEL_ACTION = @"webapi/collections/cancel";

@implementation LinApiManager (Collection)

- (RACSignal*)getCollectionByAccountId:(NSInteger)accountId type:(CollectionType)type{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld",HOST,LIST_ACTION,accountId,type];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendGet:url params:nil success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

- (RACSignal*)cancelCollection:(NSInteger)collectionId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,CANCEL_ACTION];
    NSDictionary *params = @{
                             @"collectionId" : @(collectionId)
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
