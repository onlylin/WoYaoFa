//
//  MJExtnsionConfig.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "MJExtnsionConfig.h"
#import "LDataResult.h"
#import "LPageResult.h"

@implementation MJExtnsionConfig

+ (void)load{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id"
                 };
    }];
    
    [LDataResult mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"code" : @"code",
                 @"datas" : @"datas",
                 @"msg" : @"msg"
                 };
    }];
    
    [LPageResult mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"currentPage" : @"currentPage",
                 @"totoalSize" : @"totoalSize",
                 @"pageSize" : @"pageSize",
                 @"results" : @"resultList"
                 };
    }];
}

@end
