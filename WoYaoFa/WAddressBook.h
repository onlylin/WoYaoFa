//
//  WAddressBook.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AddressBookType) {
    AddressBookTypeReceiver = 0,
    AddressBookTypeShipper
};

@interface WAddressBook : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) AddressBookType type;
@property (nonatomic, assign) NSInteger accountId;
@property (nonatomic, assign) long createTime;

@end
