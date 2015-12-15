//
//  LinApiManager+Setting.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/14.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Setting.h"

static NSString *MODIFY_ACTION = @"webapi/users/modify";

@implementation LinApiManager (Setting)

- (RACSignal *)modifyUser:(WUser *)user{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,MODIFY_ACTION];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendPost:url params:user.mj_keyValues success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

@end
