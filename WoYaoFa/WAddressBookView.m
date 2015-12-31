//
//  WAddressBookView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WAddressBookView.h"

#define TEXTCOLOR [UIColor hex:@"#666666"]
#define FONT_S [UIFont systemFontOfSize:15.0f]

@implementation WAddressBookView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameView];
        [self addSubview:self.phoneView];
        [self addSubview:self.addressView];
        
        [self.nameView addSubview:self.nameLabel];
        [self.nameView addSubview:self.name];
        [self.nameView addSubview:self.defaultImageView];
        
        [self.phoneView addSubview:self.phoneLabel];
        [self.phoneView addSubview:self.phone];
        
        [self.addressView addSubview:self.addressLabel];
        [self.addressView addSubview:self.address];
        
        self.backgroundColor = VIEW_BG;
        
        [self addRACSignal];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN.width / 2 - 1);
        make.height.mas_equalTo(50);
        make.left.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN.width / 2 - 1);
        make.height.mas_equalTo(50);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom).offset(2);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.defaultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_equalTo(self.nameView.mas_height);
        make.width.mas_equalTo(60);
    }];
    self.nameLabel.text = @"姓名：";
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_equalTo(self.phoneView.mas_height);
        make.width.mas_equalTo(60);
    }];
    self.phoneLabel.text = @"电话：";
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(0);
        make.height.mas_equalTo(self.nameView.mas_height);
        make.right.mas_offset(0);
    }];
//    self.name.text = @"小明";
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.phoneLabel.mas_right).offset(0);
        make.height.mas_equalTo(self.phoneView.mas_height);
        make.right.mas_offset(0);
    }];
//    self.phone.text = @"15157119546";
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    self.addressLabel.text = @"地址：";
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.addressLabel.mas_right);
        make.right.mas_offset(-20);
    }];
//    self.address.text = @"石家庄市裕华区建设大街与二环交叉口润丰物流园A排001号";
}

- (void)addRACSignal{
    [[RACObserve(self, model) filter:^BOOL(WAddressBook *object) {
        return object != nil;
    }] subscribeNext:^(WAddressBook *object) {
        self.name.text = object.name;
        self.phone.text = object.phone;
        self.address.text = [NSString stringWithFormat:@"%@%@%@%@%@",object.province,object.city,object.district,object.street,object.detail];
    }];
}

#pragma mark - Getter and Setter
- (UIView*)nameView{
    if (_nameView == nil) {
        _nameView = [UIView new];
        _nameView.backgroundColor = [UIColor whiteColor];
    }
    return _nameView;
}

- (UIView*)phoneView{
    if (_phoneView == nil) {
        _phoneView = [UIView new];
        _phoneView.backgroundColor = [UIColor whiteColor];
    }
    return _phoneView;
}

- (UIView*)addressView{
    if (_addressView == nil) {
        _addressView = [UIView new];
        _addressView.backgroundColor = [UIColor whiteColor];
    }
    return _addressView;
}

- (UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor = TEXTCOLOR;
        _nameLabel.font = FONT_S;
    }
    return _nameLabel;
}

- (UILabel*)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.font = FONT_S;
    }
    return _name;
}

- (UILabel*)phoneLabel{
    if (_phoneLabel == nil) {
        _phoneLabel = [UILabel new];
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.textColor = TEXTCOLOR;
        _phoneLabel.font = FONT_S;
    }
    return _phoneLabel;
}

- (UILabel*)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.font = FONT_S;
    }
    return _phone;
}

- (UILabel*)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [UILabel new];
        _addressLabel.textAlignment = NSTextAlignmentRight;
        _addressLabel.textColor = TEXTCOLOR;
        _addressLabel.font = FONT_S;
    }
    return _addressLabel;
}

- (UILabel*)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.lineBreakMode = NSLineBreakByWordWrapping;
        _address.numberOfLines = 2;
        _address.font = FONT_S;
    }
    return _address;
}

- (UIImageView*)defaultImageView{
    if (_defaultImageView == nil) {
        _defaultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_address_book_default"]];
    }
    return _defaultImageView;
}

- (WAddressBook*)model{
    if (_model == nil) {
        _model = [[WAddressBook alloc] init];
    }
    return _model;
}

@end
