//
//  LinApiManager+LoginAndRegister.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager+LoginAndRegister.h"

static const NSString *VALID_PHONE_ACITON = @"webapi/accounts/valid";

static const NSString *REGISTER_ACCOUNT_ACTION = @"webapi/accounts/register";

static const NSString *SIGNIN_ACTION = @"webapi/accounts/signin";

static const NSString *CHANGE_PWD_ACTION = @"webapi/accounts/resetPwd";

@implementation LinApiManager (LoginAndRegister)

/**
 *  验证手机号是否被注册
 *
 *  @param phone 手机号码
 *
 *  @return
 */
- (RACSignal *)validPhone:(NSString *)phone{
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",HOST,VALID_PHONE_ACITON,phone];
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
 *  注册账号
 *
 *  @param account 账号信息
 *  @param code    验证码
 *  @param appkey  mob的appkey
 *
 *  @return
 */
- (RACSignal *)registerAccount:(WAccount *)account code:(NSString *)code appkey:(NSString *)appkey{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,REGISTER_ACCOUNT_ACTION];
    NSMutableDictionary *params = account.mj_keyValues;
    [params setObject:code forKey:@"code"];
    [params setObject:appkey forKey:@"appkey"];
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
 *  用户登录
 *
 *  @param username 用户名
 *  @param password 密码
 *
 *  @return
 */
- (RACSignal *)signIn:(NSString *)username password:(NSString *)password{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,SIGNIN_ACTION];
    NSDictionary *params = @{
                                    @"username" : username,
                                    @"password" : password
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

/**
 *  修改密码
 *
 *  @param account
 *  @param code
 *  @param appkey
 *
 *  @return 
 */
- (RACSignal*)resetPwd:(WAccount *)account code:(NSString *)code appKey:(NSString *)appkey{
    NSString *url = [NSString stringWithFormat:@"%@/%@",HOST,CHANGE_PWD_ACTION];
    NSMutableDictionary *params = account.mj_keyValues;
    [params setObject:code forKey:@"code"];
    [params setObject:appkey forKey:@"appkey"];
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
