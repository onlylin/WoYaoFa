//
//  WProfileHeaderView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/6.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAccount.h"

@interface WProfileHeaderView : UIView

@property (nonatomic, strong) UIView *logoView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UIButton *settingButton;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *creditLabel;

@property (nonatomic, strong) UIView *nameView;

- (id)initWithFrame:(CGRect)frame viewModel:(WAccount*)account;

- (void)updateViewModel:(WAccount*)account;

@end
