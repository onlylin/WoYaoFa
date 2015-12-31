//
//  WLineAndCompanyViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAddressPicker.h"
#import "WDefaultAddress.h"

@interface WLineAndCompanyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LAddressPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIButton *beginButton;

@property (nonatomic, strong) UIButton *endButton;

@property (nonatomic, strong) UIButton *distanceButton;

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UIView *imageView;

@property (nonatomic, strong) LAddressPicker *addressPicker;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *viewModels;

@property (nonatomic, strong) UIImageView *beginImageView;

@property (nonatomic, strong) UIImageView *endImageView;

@property (nonatomic, strong) WDefaultAddress *defaultAddress;

@end
