//
//  CollectionLineView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/29.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "CollectionLineView.h"

#define FONT_S [UIFont systemFontOfSize:15.0f]
#define FONT_M [UIFont systemFontOfSize:13.0f]

#define TEXTCOLOR [UIColor hex:@"#a1a1a1"]

@implementation CollectionLineView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.arrowView];
        [self addSubview:self.beginLabel];
        [self addSubview:self.endLabel];
        
        [self addSubview:self.logoView];
        [self addSubview:self.companyName];
        [self addSubview:self.priceLabel];
        [self addSubview:self.lightPriceLabel];
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.markLabel];
        [self addSubview:self.distanceLabel];
        [self addSubview:self.volumeLabel];
        
        [self addSubview:self.lineView];
        [self addSubview:self.phoneButton];
        [self addSubview:self.cancelButton];
        [self addSubview:self.orderButton];
        
        self.backgroundColor = [UIColor whiteColor];
        [self addRACSignal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.centerX.equalTo(self);
    }];
    
    [self.beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.arrowView.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.arrowView);
    }];
    //    self.beginLabel.text = @"石家庄新华区";
    
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arrowView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.arrowView);
    }];
    //    self.endLabel.text = @"北京市通州区";
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.mas_offset(15);
        make.top.mas_equalTo(self.beginLabel.mas_bottom).offset(15);
    }];
    self.logoView.backgroundColor = [UIColor redColor];
    
    [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoView.mas_top).offset(5);
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
    }];
    //    self.companyName.text = @"德邦物流有限公司";
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.companyName.mas_bottom).offset(5);
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
    }];
    //    self.priceLabel.text = @"￥ : 1-2元/kg";
    
    [self.lightPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_top);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(10);
    }];
    //    self.lightPriceLabel.text = @"1-2元/立方";
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_top);
        make.left.mas_equalTo(self.lightPriceLabel.mas_right).offset(10);
    }];
    //    self.timeLabel.text = @"时效 : 1-2天";
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(5);
    }];
    //    self.markLabel.text = @"润丰物流园";
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.markLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.markLabel.mas_top);
    }];
    self.distanceLabel.text = @"11km";
    
    [self.volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(self.markLabel.mas_top);
    }];
    //    self.volumeLabel.text = @"成交量 : 10笔";
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
        make.left.mas_offset(15);
    }];
    
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneButton);
        make.right.mas_offset(-15);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneButton);
        make.right.mas_equalTo(self.orderButton.mas_left).offset(-15);
    }];
}

#pragma mark - Event Response
- (void)phoneAction:(id)sender{
    if ([delegate respondsToSelector:@selector(callPhone:)]) {
        [delegate callPhone:self.model];
    }
}

- (void)cancelAction:(id)sender{
    if ([delegate respondsToSelector:@selector(cancel:collection:)]) {
        [delegate cancel:self collection:self.model];
    }
}

- (void)orderAction:(id)sender{
    if ([delegate respondsToSelector:@selector(order:)]) {
        [delegate order:self.model.line];
    }
}

- (void)addRACSignal{
    [RACObserve(self, model) subscribeNext:^(WCollection *collection) {
        WLine *line = collection.line;
        self.beginLabel.text = [NSString stringWithFormat:@"%@%@",line.beginCity,line.beginDistrict];
        self.endLabel.text = [NSString stringWithFormat:@"%@%@",line.endCity,line.endDistrict];
        self.companyName.text = line.company.name;
        self.priceLabel.text = [NSString stringWithFormat:@"￥ : %.f-%.f/kg",line.minPrice,line.maxPrice];
        self.lightPriceLabel.text = [NSString stringWithFormat:@"%.f-%.f/立方",line.lightMinPrice,line.lightMaxPrice];
        self.timeLabel.text = [NSString stringWithFormat:@"时效 : %ld-%ld天",line.minDay,line.maxDay];
        self.markLabel.text = line.mark;
        self.volumeLabel.text = [NSString stringWithFormat:@"成交量 : %ld",line.volume];
    }];
}

#pragma mark - Getter and Setter
- (UILabel*)beginLabel{
    if (_beginLabel == nil) {
        _beginLabel = [UILabel new];
    }
    return _beginLabel;
}

- (UILabel*)endLabel{
    if (_endLabel == nil) {
        _endLabel = [UILabel new];
    }
    return _endLabel;
}

- (UIImageView*)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrive_icon"]];
    }
    return _arrowView;
}

- (UIImageView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIImageView new];
    }
    return _logoView;
}

- (UILabel*)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.font = FONT_S;
    }
    return _companyName;
}

- (UILabel*)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = FONT_M;
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (UILabel*)lightPriceLabel{
    if (_lightPriceLabel == nil) {
        _lightPriceLabel = [UILabel new];
        _lightPriceLabel.font = FONT_M;
        _lightPriceLabel.textColor = [UIColor redColor];
    }
    return _lightPriceLabel;
}

- (UILabel*)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.font = FONT_M;
    }
    return _timeLabel;
}

- (UILabel*)markLabel{
    if (_markLabel == nil) {
        _markLabel = [UILabel new];
        _markLabel.font = FONT_M;
    }
    return _markLabel;
}

- (UILabel*)distanceLabel{
    if (_distanceLabel == nil) {
        _distanceLabel = [UILabel new];
        _distanceLabel.font = FONT_M;
    }
    return _distanceLabel;
}

- (UILabel*)volumeLabel{
    if (_volumeLabel == nil) {
        _volumeLabel = [UILabel new];
        _volumeLabel.font = FONT_M;
    }
    return _volumeLabel;
}

- (UIView*)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = VIEW_BG;
    }
    return _lineView;
}

- (UIButton*)phoneButton{
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _phoneButton.titleLabel.textColor = TEXTCOLOR;
        [_phoneButton setTitle:@"  电话联系  " forState:UIControlStateNormal];
        _phoneButton.layer.borderWidth = 1.2;
        _phoneButton.layer.cornerRadius = 5.0;
        _phoneButton.layer.borderColor = [TEXTCOLOR CGColor];
        _phoneButton.tintColor = TEXTCOLOR;
        _phoneButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_phoneButton addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}

- (UIButton*)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelButton.titleLabel.textColor = TEXTCOLOR;
        [_cancelButton setTitle:@"  取消收藏  " forState:UIControlStateNormal];
        _cancelButton.layer.borderWidth = 1.2;
        _cancelButton.layer.cornerRadius = 5.0;
        _cancelButton.layer.borderColor = [TEXTCOLOR CGColor];
        _cancelButton.tintColor = TEXTCOLOR;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton*)orderButton{
    if (_orderButton == nil) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _orderButton.titleLabel.textColor = TEXTCOLOR;
        [_orderButton setTitle:@"  立即下单  " forState:UIControlStateNormal];
        _orderButton.layer.borderWidth = 1.2;
        _orderButton.layer.cornerRadius = 5.0;
        _orderButton.layer.borderColor = [[UIColor hex:@"#2e82ff"] CGColor];
        _orderButton.tintColor = [UIColor hex:@"#2e82ff"];
        _orderButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_orderButton addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}






@end
