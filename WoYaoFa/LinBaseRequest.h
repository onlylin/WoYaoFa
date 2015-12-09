//
//  LinBaseRequest.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class LinBaseRequest;

typedef NS_ENUM(NSInteger , LinRequestMethod) {
    LinRequestMethodGet = 0,
    LinRequestMethodPost
};

typedef NS_ENUM(NSInteger , LinRequestSerializerType) {
    LinRequestSerializerTypeHTTP = 0,
    LinRequestSerializerTypeJSON,
};

@protocol LinBaseRequestDelegate <NSObject>

@optional
- (void)requestFinished:(LinBaseRequest *)request;
- (void)requestFailed:(LinBaseRequest *)request;
- (void)clearRequest;

@end


@interface LinBaseRequest : NSObject


/// request delegate object
@property (nonatomic, weak) id<LinBaseRequestDelegate> delegate;

@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;

@property (nonatomic, strong, readonly) NSDictionary *responseHeaders;

@property (nonatomic, strong, readonly) NSString *responseString;

@property (nonatomic, strong, readonly) id responseJSONObject;

@property (nonatomic, readonly) NSInteger responseStatusCode;

@property (nonatomic, copy) void (^successCompletionBlock)(LinBaseRequest *);

@property (nonatomic, copy) void (^failureCompletionBlock)(LinBaseRequest *);

@property (nonatomic, strong) id arguments;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, assign) LinRequestMethod requestMethod;


- (void)start;

- (void)stop;

- (void)startWithCompletionBlockWithSuccess:(void(^)(LinBaseRequest *request)) success
                                    failure:(void(^)(LinBaseRequest *request)) failure;

- (void)setCompletionBlockWithSuccess:(void (^)(LinBaseRequest *request))success
                              failure:(void (^)(LinBaseRequest *request))failure;

- (void)clearCompletionBlock;

/**
 *  用于检查Status Code是否正常的方法
 *
 *  @return
 */
- (BOOL)statusCodeValidator;

/**
 *  用于检查JSON是否合法的对象
 *
 *  @return
 */
- (id)jsonValidator;

/**
 *  请求方式
 *
 *  @return
 */
- (LinRequestMethod)requestMethod;

/**
 *  请求的SerializerType
 *
 *  @return
 */
- (LinRequestSerializerType)requestSerializerType;


/**
 *   请求的连接超时时间，默认为60秒
 *
 *  @return
 */
- (NSTimeInterval)requestTimeoutInterval;

@end
