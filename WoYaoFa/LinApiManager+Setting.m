//
//  LinApiManager+Setting.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/14.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Setting.h"

static NSString *MODIFY_ACTION = @"webapi/users/modify";

static NSString *UPLOAD_ACTION = @"webapi/users/face";

@implementation LinApiManager (Setting)

/**
 *  修改用户信息
 *
 *  @param user
 *
 *  @return
 */
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


/**
 *  上传图片
 *
 *  @param image     图片信息
 *  @param accountId 账号Id
 *  @param userId    用户Id
 *
 *  @return
 */
- (RACSignal*)uploadLogo:(UIImage *)image account:(NSInteger)accountId user:(NSInteger)userId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,UPLOAD_ACTION];
    NSDictionary *params = @{
                             @"accountId" : @(accountId),
                             @"userId" : @(userId)
                             };
    NSArray *images = @[image];
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
