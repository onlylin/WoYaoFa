//
//  LinMutipartRequest.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/22.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinMutipartRequest.h"
#import "LinNetworkAgent.h"

@implementation LinMutipartRequest


- (void)start{
    [[LinNetworkAgent shareInstance] addMutiRequest:self];
}

- (LinRequestSerializerType)requestSerializerType{
    return LinRequestSerializerTypeHTTP;
}

@end
