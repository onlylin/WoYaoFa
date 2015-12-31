//
//  LinApiManager.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"

@implementation LinApiManager

+ (LinApiManager*)shareInstance{
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
        
    }
    return self;
}

/**
 *  GET请求
 *
 *  @param url     请求地址
 *  @param params  提交参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
- (void)sendGet:(NSString *)url params:(id)params success:(void (^)(LinBaseRequest *))success failure:(void (^)(LinBaseRequest *))failure{
    NSLog(@"发送GET请求");
    LinBaseRequest *request = [[LinBaseRequest alloc] init];
    request.url = url;
    request.arguments = params;
    request.requestMethod = LinRequestMethodGet;
    _successBlock = success;
    _failureBlock = failure;
    [request startWithCompletionBlockWithSuccess:^(LinBaseRequest *request) {
        success(request);
    } failure:^(LinBaseRequest *request) {
        failure(request);
    }];
}

/**
 *  POST请求
 *
 *  @param url     请求地址
 *  @param params  提交参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
- (void)sendPost:(NSString *)url params:(id)params success:(void (^)(LinBaseRequest *))success failure:(void (^)(LinBaseRequest *))failure{
    NSLog(@"发送POST请求");
    LinBaseRequest *request = [[LinBaseRequest alloc] init];
    request.url = url;
    request.arguments = params;
    request.requestMethod = LinRequestMethodPost;
    _successBlock = success;
    _failureBlock = failure;
    [request startWithCompletionBlockWithSuccess:^(LinBaseRequest *request) {
        success(request);
    } failure:^(LinBaseRequest *request) {
        failure(request);
    }];
}

/**
 *  图片上传
 *
 *  @param url      上传地址
 *  @param formData 图片文件
 *  @param params   提交参数
 *  @param success  上传成功回调
 *  @param failure  上传失败回调
 */
- (void)uploadImage:(NSString *)url formDatas:(NSArray*)formDatas params:(id)params success:(void (^)(LinBaseRequest *))success failure:(void (^)(LinBaseRequest *))failure{
    NSLog(@"文件上传");
    LinMutipartRequest *request = [[LinMutipartRequest alloc] init];
    request.url = url;
    request.mimeType = LinMutipartRequestMimeTypeImageAndPng;
    request.arguments = params;
    request.formDatas = formDatas;
    _successBlock = success;
    _failureBlock = failure;
    [request startWithCompletionBlockWithSuccess:^(LinBaseRequest *request) {
        success(request);
    } failure:^(LinBaseRequest *request) {
        failure(request);
    }];
}

@end
