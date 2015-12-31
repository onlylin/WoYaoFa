//
//  WCommentView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "WComment.h"

@interface WCommentView : UIView

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *levelLabel;

@property (nonatomic, strong) HCSStarRatingView *ratingView;

@property (nonatomic, strong) UILabel *ratingLabel;

@property (nonatomic, strong) WComment *model;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITextView *textView;

@end
