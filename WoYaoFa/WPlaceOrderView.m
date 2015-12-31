//
//  WPlaceOrderView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/17.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WPlaceOrderView.h"

#define FONT_S [UIFont systemFontOfSize:17.0f]
#define TEXTCOLOR [UIColor hex:@"#a1a1a1"]

@implementation WPlaceOrderView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.name];
        
        [self addSubview:self.phoneLabel];
        [self addSubview:self.phone];
        
        [self addSubview:self.addressLabelView];
        [self addSubview:self.addressView];
        
        [self.addressLabelView addSubview:self.addressLabel];
        [self.addressView addSubview:self.address];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.phoneLabel.text = @"电话:";
        self.addressLabel.text = @"地    址:";
        [self addRACSignal];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(2);
        make.top.mas_equalTo(self.nameLabel.mas_top);
    }];
//    self.name.text = @"都读";
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.top.mas_equalTo(self.nameLabel.mas_top);
    }];
//    self.phone.text = @"12345678901";
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.phone.mas_left).offset(-2);
        make.top.mas_equalTo(self.nameLabel.mas_top);
    }];
    
    
    [self.addressLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(72, 30));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
//    self.addressLabelView.backgroundColor = [UIColor redColor];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.width - 72 - 20, 30));
        make.left.mas_equalTo(self.addressLabelView.mas_right).offset(0);
        make.top.mas_equalTo(self.addressLabelView.mas_top);
    }];
//    self.addressView.backgroundColor = [UIColor blueColor];

    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(2);
        make.right.mas_offset(0);
    }];
//    self.address.text = @"河北省石家庄市桥西区新石中路金狮大厦A座1415号";
}

- (void)addRACSignal{
    [[RACObserve(self, model) filter:^BOOL(WAddressBook *object) {
        return object != nil;
    }] subscribeNext:^(WAddressBook *object) {
        if (object.type == AddressBookTypeReceiver) {
            self.nameLabel.text = @"收货方:";
        }else{
            self.nameLabel.text = @"发货方";
        }
        self.name.text = object.name;
        self.phone.text = object.phone;
        self.address.text = [NSString stringWithFormat:@"%@%@%@%@%@",object.province,object.city,object.district,object.street,object.detail];
    }];
}

#pragma mark - Getter and Setter
- (UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = FONT_S;
        _nameLabel.textColor = TEXTCOLOR;
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
        _phoneLabel.font = FONT_S;
        _phoneLabel.textColor = TEXTCOLOR;
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
        _addressLabel.font = FONT_S;
        _addressLabel.textColor = TEXTCOLOR;
        _addressLabel.textAlignment = NSTextAlignmentRight;
    }
    return _addressLabel;
}

- (UILabel*)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.lineBreakMode = NSLineBreakByCharWrapping;
        _address.numberOfLines = 2;
        _address.font = FONT_S;
    }
    return _address;
}

- (UIView*)addressLabelView{
    if (_addressLabelView == nil) {
        _addressLabelView = [UIView new];
    }
    return _addressLabelView;
}

- (UIView*)addressView{
    if (_addressView == nil) {
        _addressView = [UIView new];
    }
    return _addressView;
}

- (WAddressBook*)model{
    if (_model == nil) {
        _model = [[WAddressBook alloc] init];
    }
    return _model;
}

@end
