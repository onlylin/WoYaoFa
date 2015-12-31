//
//  WPlaceOrderViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDateView.h"
#import "WOrder.h"

@interface WPlaceOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIDateViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) WOrder *order;

@property (nonatomic, strong) UIDateView *datePicker;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, assign) NSInteger lineId;

@end
