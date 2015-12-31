//
//  LinApiManager+AddressBook.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+AddressBook.h"

static const NSString *LIST_ACTION = @"webapi/addressbooks/list";

static const NSString *ADD_ACTION = @"webapi/addressbooks/add";

static const NSString *MODIFY_ACTION = @"webapi/addressbooks/modify";

static const NSString *SET_DEFAULT_ACTION = @"webapi/addressbooks/setdefault";

@implementation LinApiManager (AddressBook)

/**
 *  获取地址簿
 *
 *  @param accountId
 *  @param type
 *  @param pageIndex
 *  @param pageSize
 *
 *  @return <#return value description#>
 */
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

/**
 *  添加地址簿
 *
 *  @param addressBook
 *
 *  @return
 */
- (RACSignal*)addAddressBook:(WAddressBook *)addressBook{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,ADD_ACTION];
    NSLog(@"%@",addressBook.mj_keyValues);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [self sendPost:url params:addressBook.mj_keyValues success:^(LinBaseRequest *request) {
           [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
           [subscriber sendCompleted];
       } failure:^(LinBaseRequest *request) {
           
       }];
        return nil;
    }];
}

/**
 *  修改地址簿
 *
 *  @param addressBook
 *
 *  @return
 */
- (RACSignal*)modifyAddressBook:(WAddressBook *)addressBook{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,MODIFY_ACTION];
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self sendPost:url params:addressBook.mj_keyValues success:^(LinBaseRequest *request) {
            [subscriber sendNext:[LDataResult mj_objectWithKeyValues:request.responseJSONObject]];
            [subscriber sendCompleted];
        } failure:^(LinBaseRequest *request) {
            
        }];
        return nil;
    }];
}

/**
 *  设置为默认地址
 *
 *  @param addressBookId
 *  @param userId
 *
 *  @return 
 */
- (RACSignal*)setDefaultAddressBook:(NSInteger)addressBookId user:(NSInteger)userId{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld/%ld",HOST,SET_DEFAULT_ACTION,addressBookId,userId];
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
