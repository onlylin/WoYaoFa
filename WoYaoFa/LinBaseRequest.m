//
//  LinBaseRequest.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinBaseRequest.h"
#import "LinNetworkAgent.h"

@implementation LinBaseRequest

- (void)start{
    [[LinNetworkAgent shareInstance] addRequest:self];
}

- (void)stop{
    self.delegate = nil;
    [[LinNetworkAgent shareInstance] cancelRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(LinBaseRequest *))success failure:(void (^)(LinBaseRequest *))failure{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(LinBaseRequest *))success failure:(void (^)(LinBaseRequest *))failure{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (NSInteger)responseStatusCode{
    return self.requestOperation.response.statusCode;
}

- (id)responseJSONObject{
    return self.responseJSONObject;
}

- (NSString*)responseString{
    return self.responseString;
}

- (NSDictionary*)responseHeaders{
    return self.responseHeaders;
}

- (BOOL)statusCodeValidator{
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <= 299) {
        return YES;
    }else{
        return NO;
    }
}

- (id)jsonValidator{
    return nil;
}

- (LinRequestMethod)requestMethod{
    return self.requestMethod;
}

- (LinRequestSerializerType)requestSerializerType{
    return LinRequestSerializerTypeHTTP;
}

- (id)arguments{
    return self.arguments;
}

- (NSString*)url{
    return self.url;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 60;
}


@end
