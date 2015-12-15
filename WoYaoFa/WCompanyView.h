//
//  WCompanyView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCompany.h"

@interface WCompanyView : UIView

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UIImageView *CACIIcon;

@property (nonatomic, strong) UIImageView *QCIcon;

@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *volumeLabel;

- (id)initWithFrame:(CGRect)frame viewModel:(WCompany*)company;

@end
