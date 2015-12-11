//
//  WOrdersViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface WOrdersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HMSegmentedControl *segment;

@property (nonatomic, strong) NSMutableArray *viewModels;

@end
