//
//  WCollectionsViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/29.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinApiManager+Collection.h"

@interface WCollectionsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, assign) CollectionType type;

@property (nonatomic, strong) NSMutableArray *viewModels;

@end
