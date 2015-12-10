//
//  WUser.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UserSexType) {
    UserSexTypeMale = 0,
    UserSexTypeFemale
};

@interface WUser : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) UserSexType sex;
@property (nonatomic, assign) long birthday;
@property (nonatomic, assign) NSInteger credit;
@property (nonatomic, assign) NSInteger accountId;

@end
