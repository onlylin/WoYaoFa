//
//  WRegisterViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCountDownButton.h"

@interface WRegisterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITextField *phoneField;

@property (nonatomic, strong) UITextField *codeField;

@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UITextField *checkPwdField;

@property (nonatomic, strong) LCountDownButton *codeButton;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIView *footerView;

@end
