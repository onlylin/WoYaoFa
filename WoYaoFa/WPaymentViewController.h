//
//  WPaymentViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOrder.h"

@interface WPaymentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *phoneImageView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) WOrder *order;

@end
