//
//  WSettingViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDateView.h"

@interface WSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIDateViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, strong) WUser *user;

@property (nonatomic, strong) UIDateView *datePicker;

@property (nonatomic, strong) UITextField *textField;


@end
