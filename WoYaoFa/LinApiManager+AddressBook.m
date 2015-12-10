//
//  LinApiManager+AddressBook.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+AddressBook.h"

static const NSString *LIST_ACTION = @"webapi/addressbooks/list";

@implementation LinApiManager (AddressBook)

- (RACSignal*)getAddressBooks:(NSInteger)accountId addressType:(AddressBookType)type pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld/%ld/%ld",HOST,LIST_ACTION,accountId,type,pageIndex,pageSize];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sendGet:url params:nil
            success:^(LinBaseRequest *request) {
                [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
                [subscriber sendCompleted];
            } failure:^(LinBaseRequest *request) {
               
            }];
        return nil;
    }];
}

@end
