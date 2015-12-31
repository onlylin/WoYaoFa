//
//  WCommentViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/18.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "WComment.h"


@interface WCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *comintButton;

@property (nonatomic, strong) HCSStarRatingView *ratingView;

@property (nonatomic, strong) UILabel *ratingLabel;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) WComment *comment;

@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, strong) NSMutableArray *images;


@end
