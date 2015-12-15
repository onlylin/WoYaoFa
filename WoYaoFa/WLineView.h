//
//  WLineView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLine.h"

@interface WLineView : UIView

@property (nonatomic, strong) UILabel *beginLabel;

@property (nonatomic, strong) UILabel *endLabel;

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UIImageView *CACIIcon;

@property (nonatomic, strong) UIImageView *QCIcon;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *lightPriceLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *volumeLabel;


-(id)initWithFrame:(CGRect)frame viewModel:(WLine*)line;

@end
