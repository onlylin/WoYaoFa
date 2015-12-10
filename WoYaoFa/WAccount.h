//
//  WAccount.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WUser.h"

@interface WAccount : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) long lastLoginTime;
@property (nonatomic, assign) long createTime;
@property (nonatomic, assign) NSInteger role;
@property (nonatomic, strong) WUser *user;

@end
