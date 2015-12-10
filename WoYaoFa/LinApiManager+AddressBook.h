//
//  LinApiManager+AddressBook.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"
#import "WAddressBook.h"

@interface LinApiManager (AddressBook)

- (RACSignal*)getAddressBooks:(NSInteger)accountId addressType:(AddressBookType)type pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
