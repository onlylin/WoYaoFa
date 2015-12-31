//
//  WCancelOrderViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/20.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCancelOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *phoneImageView;

@end
