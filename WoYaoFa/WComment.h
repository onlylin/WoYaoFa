//
//  WComment.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUser.h"

@interface WComment : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger accountId;
@property (nonatomic, assign) NSInteger lineId;
@property (nonatomic, strong) WUser *user;
@property (nonatomic, assign) long createTime;

@end
