//
//  LinApiManager+Comment.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+Comment.h"

static const NSString *ADD_ACTION = @"webapi/comments/add";

static const NSString *UPLOAD_ACTION = @"webapi/comments/upload";

static const NSString *LIST_ACTION = @"webapi/comments/list";

@implementation LinApiManager (Comment)

/**
 *  评论
 *
 *  @param comment
 *
 *  @return
 */
- (RACSignal *)addComment:(WComment *)comment order:(NSInteger)orderId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,ADD_ACTION];
    NSMutableDictionary *params = comment.mj_keyValues;
    [params setObject:@(orderId) forKey:@"orderId"];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendPost:url params:params success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

/**
 *  上传评论的图片
 *
 *  @param images
 *  @param commentId
 *
 *  @return
 */
- (RACSignal *)uploadImages:(NSArray *)images comment:(NSInteger)commentId{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,UPLOAD_ACTION];
    NSDictionary *params = @{
                             @"commentId" : @(commentId)
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

/**
 *  获取评论列表
 *
 *  @param lineId    线路ID
 *  @param pageIndex
 *  @param pageSize
 *
 *  @return 
 */
- (RACSignal *)getCommentsWithLineId:(NSInteger)lineId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld/%ld",HOST,LIST_ACTION,lineId,pageIndex,pageSize];
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
