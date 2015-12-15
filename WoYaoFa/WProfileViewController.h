//
//  WProfileViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/5.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WProfileHeaderView.h"

@interface WProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) WProfileHeaderView *profileHeadView;

@property (nonatomic, strong) UIView *logoView;

@property (nonatomic, strong) WAccount *account;


@end
