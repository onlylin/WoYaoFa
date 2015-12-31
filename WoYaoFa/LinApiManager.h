//
//  LinApiManager.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinNetwork.h"

typedef NS_ENUM(NSInteger,ResponseStatus) {
    ResponseStatusOk = 2000,
    ResponseStatusFail = 2001
};

@interface LinApiManager : NSObject

@property (nonatomic, copy) void (^successBlock)(LinBaseRequest *);

@property (nonatomic, copy) void (^failureBlock)(LinBaseRequest *);

+ (LinApiManager*)shareInstance;

- (void)sendGet:(NSString*)url params:(id)params success:(void(^)(LinBaseRequest *request)) success
                                                 failure:(void(^)(LinBaseRequest *request)) failure;

- (void)sendPost:(NSString*)url params:(id)params success:(void(^)(LinBaseRequest *request)) success
        failure:(void(^)(LinBaseRequest *request)) failure;

- (void)uploadImage:(NSString*)url formDatas:(NSArray*)formDatas params:(id)params success:(void(^)(LinBaseRequest *request)) success failure:(void(^)(LinBaseRequest *request)) failure;

@end
