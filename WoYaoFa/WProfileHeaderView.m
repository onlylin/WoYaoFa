//
//  WProfileHeaderView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/6.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WProfileHeaderView.h"

#define LOGOVIEW_WIDTH 70

@implementation WProfileHeaderView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.logoView];
        [self.logoView addSubview:self.logoImageView];
        [self addSubview:self.settingButton];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LOGOVIEW_WIDTH, LOGOVIEW_WIDTH));
        make.center.equalTo(self);
    }];
    self.logoView.layer.cornerRadius = LOGOVIEW_WIDTH / 2;
    self.logoView.backgroundColor = [UIColor redColor];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LOGOVIEW_WIDTH - 4, LOGOVIEW_WIDTH - 4));
        make.center.equalTo(self.logoView);
    }];
    self.logoImageView.layer.cornerRadius = (LOGOVIEW_WIDTH - 4) / 2;
    self.logoImageView.backgroundColor = [UIColor blackColor];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(15);
    }];
}

#pragma mark - Getter and Setter
- (UIView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIView new];
    }
    return _logoView;
}

- (UIImageView*)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [UIImageView new];
    }
    return _logoImageView;
}

- (UIButton*)settingButton{
    if (_settingButton == nil) {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingButton setTitle:@" 设置" forState:UIControlStateNormal];
        [_settingButton setImage:[UIImage imageNamed:@"my_set_up"] forState:UIControlStateNormal];
    }
    return _settingButton;
}

@end
