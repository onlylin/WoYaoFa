//
//  LinApiManager+Feedback.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Feedback.h"

static NSString *ADD_ACTION = @"webapi/feedbacks/add";

@implementation LinApiManager (Feedback)

/**
 *  意见反馈
 *
 *  @param content   反馈内容
 *  @param accountId 反馈账号
 *
 *  @return
 */
- (RACSignal*)addFeedback:(NSString *)content account:(NSInteger)accountId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,ADD_ACTION];
    NSDictionary *params = @{
                             @"content" : content,
                             @"accountId" : @(accountId)
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
