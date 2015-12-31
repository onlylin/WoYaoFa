//
//  LinNetworkAgent.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinNetworkAgent.h"
#import "LinNetworkPrivate.h"

@interface LinNetworkAgent (){
    NSMutableDictionary *_requestsRecord;
    AFHTTPRequestOperationManager *_manager;
}

@end

@implementation LinNetworkAgent

+ (LinNetworkAgent*)shareInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
    }
    return self;
}

- (void)addRequest:(LinBaseRequest *)request{
    LinRequestMethod method = [request requestMethod];
    NSString *url = [request url];
    id param = [request arguments];
    if (request.requestSerializerType == LinRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == LinRequestSerializerTypeJSON){
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    _manager.requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    
    if (method == LinRequestMethodGet) {
        //GET请求
        request.requestOperation = [_manager GET:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [self handleRequestResult:operation];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            [self handleRequestResult:operation];
        }];
    }else if (method == LinRequestMethodPost){
        //POST请求
        request.requestOperation = [_manager POST:url parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [self handleRequestResult:operation];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            [self handleRequestResult:operation];
        }];
    }
    [self addOperation:request];
}

- (void)addMutiRequest:(LinMutipartRequest *)request{
    NSString *url = [request url];
    id param = [request arguments];
    LinMutipartRequestMimeType mimeType = [request mimeType];
    
    if (request.requestSerializerType == LinRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if (request.requestSerializerType == LinRequestSerializerTypeJSON){
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
     _manager.requestSerializer.timeoutInterval = request.requestTimeoutInterval;
    
    request.requestOperation = [_manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        switch (mimeType) {
            case LinMutipartRequestMimeTypeImageAndPng:
            {
                NSArray *formDatas = [request formDatas];
                for (int i = 0; i < [formDatas count]; i++) {
                    UIImage *image = formDatas[i];
                    NSData *data = UIImagePNGRepresentation(image);
                    NSString *fileName = [NSString stringWithFormat:@"image%d.png",i];
                    NSString *formKey = [NSString stringWithFormat:@"image%d",i];
                    [formData appendPartWithFileData:data name:formKey fileName:fileName mimeType:@"image/png"];
                }
                break;
            }
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self handleRequestResult:operation];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self handleRequestResult:operation];
    }];
    [self addOperation:request];
}

- (void)cancelRequest:(LinBaseRequest *)request{
    [request.requestOperation cancel];
    
}

- (void)cancelAllRequest{
    NSDictionary *copyRecord = [_requestsRecord copy];
    for (NSString *key in copyRecord) {
        LinBaseRequest *request = copyRecord[key];
        [request stop];
    }
}

- (void)handleRequestResult:(AFHTTPRequestOperation *)operation{
    NSString *key = [self requestHashKey:operation];
    LinBaseRequest *request = _requestsRecord[key];
    if (request) {
        BOOL suceed = [self checkResult:request];
        if (suceed) {
            if (request.delegate != nil) {
                [request.delegate requestFinished:request];
            }
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
        }else{
            if (request.delegate != nil) {
                [request.delegate requestFailed:request];
            }
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request);
            }
        }
    }
    [self removeOperation:operation];
    [request clearCompletionBlock];
}

- (BOOL)checkResult:(LinBaseRequest*)request{
    BOOL result = [request statusCodeValidator];
    if (!result) {
        return result;
    }
    id validator = [request jsonValidator];
    if (validator != nil) {
        id json = [request responseJSONObject];
        result = [LinNetworkPrivate checkJson:json withValidator:validator];
    }
    return request;
}

- (NSString *)requestHashKey:(AFHTTPRequestOperation*)operation{
    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)[operation hash]];
    return key;
}


- (void)addOperation:(LinBaseRequest*)request{
    if (request.requestOperation != nil) {
        NSString *key = [self requestHashKey:request.requestOperation];
        @synchronized(self) {
            _requestsRecord[key] = request;
        }
    }
}


- (void)removeOperation:(AFHTTPRequestOperation*)operation{
    NSString *key = [self requestHashKey:operation];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:key];
    }
}

@end
