//
//  LinNetworkAgent.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinBaseRequest.h"
#import "LinMutipartRequest.h"

@interface LinNetworkAgent : NSObject

+ (LinNetworkAgent*)shareInstance;

- (void)addRequest:(LinBaseRequest*)request;

- (void)addMutiRequest:(LinMutipartRequest*)request;

- (void)cancelRequest:(LinBaseRequest*)request;

- (void)cancelAllRequest;


@end
