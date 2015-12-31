//
//  WCommentListViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "WCommentView.h"

@interface WCommentListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) HCSStarRatingView *ratingView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) NSInteger lineId;

@property (nonatomic, strong) NSMutableArray *viewModels;

@end
