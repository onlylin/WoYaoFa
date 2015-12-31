//
//  WSelectAddressViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/18.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinApiManager+AddressBook.h"

@interface WSelectAddressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *viewModels;

@property (nonatomic, assign) AddressBookType addressBookType;

@end
