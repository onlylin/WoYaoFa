//
//  LinMutipartRequest.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/22.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinBaseRequest.h"

typedef NS_ENUM(NSInteger,LinMutipartRequestMimeType) {
    LinMutipartRequestMimeTypeImageAndPng = 0,
};

@interface LinMutipartRequest : LinBaseRequest

@property (nonatomic, assign) LinMutipartRequestMimeType mimeType;

@property (nonatomic, strong) NSArray *formDatas;

@end
