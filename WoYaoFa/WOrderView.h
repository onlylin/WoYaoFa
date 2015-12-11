//
//  WOrderView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+LLabel.h"
#import "WOrder.h"

@interface WOrderView : UIView

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIView *line1View;

@property (nonatomic, strong) UIView *line2View;

@property (nonatomic, strong) UIView *line3View;

@property (nonatomic, strong) WOrder *order;

@property (nonatomic, strong) UIImageView *companyImageView;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *orderStatus;

@property (nonatomic, strong) UILabel *beginAddress;

@property (nonatomic, strong) UILabel *endAddress;

@property (nonatomic, strong) UIImageView *addressArrowImageView;

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *goodsDetail;

@property (nonatomic, strong) UILabel *buyTimeLabel;

@property (nonatomic, strong) UILabel *orderNumber;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *right1Button;

@property (nonatomic, strong) UIButton *right2Button;


- (id)initWithFrame:(CGRect)frame viewModel:(WOrder*)order;

@end
