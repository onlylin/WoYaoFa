//
//  WAddressBookAddViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAddressPicker.h"
#import "LinApiManager+AddressBook.h"

@interface WAddressBookAddViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LAddressPickerDelegate>

@property (nonatomic, assign) AddressBookType addressBookType;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *nameField;

@property (nonatomic, strong) UITextField *phoneField;

@property (nonatomic, strong) UITextField *addressField;

@property (nonatomic, strong) UITextField *streetField;

@property (nonatomic, strong) UITextField *detailField;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) WAddressBook *addressBook;

@property (nonatomic, strong) LAddressPicker *addressPicker;

@property (nonatomic, strong) UIButton *setDefaultButton;

@end
