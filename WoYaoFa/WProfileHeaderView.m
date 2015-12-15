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


- (id)initWithFrame:(CGRect)frame viewModel:(WAccount *)account{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.logoView];
        [self.logoView addSubview:self.logoImageView];
        [self addSubview:self.settingButton];
        
        [self addSubview:self.nameView];
        [self.nameView addSubview:self.nameLabel];
        [self addSubview:self.creditLabel];
        if (account) {
            [self updateViewModel:account];
        }
    }
    return self;
}

- (void)updateViewModel:(WAccount *)account{
    self.nameLabel.text = account.user.name;
    self.creditLabel.text = [NSString stringWithFormat:@"积分 : %ld",account.user.credit];
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
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN.width, 20));
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.nameView);
    }];
//    self.nameLabel.text = @"大地公司";
    
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameView.mas_bottom).offset(0);
        make.centerX.equalTo(self);
    }];
//    self.creditLabel.text = @"积分 : 10";
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

- (UIView*)nameView{
    if (_nameView == nil) {
        _nameView = [UIView new];
    }
    return _nameView;
}

- (UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel*)creditLabel{
    if (_creditLabel == nil) {
        _creditLabel = [UILabel new];
        _creditLabel.textColor = [UIColor whiteColor];
        _creditLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _creditLabel;
}

@end
