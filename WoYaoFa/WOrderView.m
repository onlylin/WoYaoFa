//
//  WOrderView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WOrderView.h"

#define FONT_S [UIFont systemFontOfSize:16.0f]
#define FONT_M [UIFont systemFontOfSize:15.0f]
#define TEXTCOLOR [UIColor hex:@"#a1a1a1"]

@implementation WOrderView

- (id)initWithFrame:(CGRect)frame viewModel:(WOrder *)order{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        [self.headerView addSubview:self.companyImageView];
        [self.headerView addSubview:self.companyName];
        [self.headerView addSubview:self.arrowImageView];
        [self.headerView addSubview:self.orderStatus];
        
        [self validOrderStatus:order.status];
        
        [self addSubview:self.line1View];
        self.line1View.backgroundColor = VIEW_BG;
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.beginAddress];
        [self.contentView addSubview:self.addressArrowImageView];
        [self.contentView addSubview:self.endAddress];
        [self.contentView addSubview:self.logoView];
        [self.contentView addSubview:self.goodsDetail];
        [self.contentView addSubview:self.buyTimeLabel];
        
        
        
        self.beginAddress.text = [NSString stringWithFormat:@"%@%@",order.line.beginCity,order.line.beginDistrict];
        self.endAddress.text = [NSString stringWithFormat:@"%@%@",order.line.endCity,order.line.endDistrict];
        self.goodsDetail.text = [NSString stringWithFormat:@"货物信息：%@",order.detail != nil ? order.detail : @"无"];
        
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:order.buyTime / 1000];
        self.buyTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",[[YLMoment momentWithDate:date] format:@"yyyy-MM-dd HH:mm"]];
        
        [self addSubview:self.line2View];
        self.line2View.backgroundColor = VIEW_BG;
        
        [self.contentView addSubview:self.orderNumber];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.unitLabel];
        
        self.orderNumber.text = [NSString stringWithFormat:@"运单号：%@",order.number];

        [self addSubview:self.line3View];
        self.line3View.backgroundColor = VIEW_BG;
        
        [self.contentView addSubview:self.footerView];
        [self.footerView addSubview:self.leftButton];
        [self.footerView addSubview:self.right1Button];
        [self.footerView addSubview:self.right2Button];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(40);
    }];
    
    [self.companyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.equalTo(self.headerView);

    }];
    
    [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(self.companyImageView);
    }];
    self.companyName.text = @"德邦物流有限公司";
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyName.mas_right).offset(5);
        make.centerY.mas_equalTo(self.companyName);
    }];
    
    [self.orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.equalTo(self.headerView);
    }];
    self.orderStatus.text = @"待受理";
    
    [self.line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1View.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(220);
    }];
    
    [self.beginAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
    }];
//    self.beginAddress.text = @"石家庄市裕华区";
    
    [self.addressArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.beginAddress.mas_right).offset(10);
        make.centerY.mas_equalTo(self.beginAddress);
    }];
    
    [self.endAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addressArrowImageView.mas_right).offset(10);
        make.top.mas_offset(10);
    }];
//    self.endAddress.text = @"北京市全境";
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beginAddress.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    self.logoView.backgroundColor = [UIColor blackColor];
    
    [self.goodsDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoView.mas_top).offset(5);
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
    }];
//    self.goodsDetail.text = @"货物信息：物品易碎，小心运输";
    
    [self.buyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.logoView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
    }];
//    self.buyTimeLabel.text = @"下单时间：2015-01-01 12:00";
    
    [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(2);
    }];
    
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line2View.mas_bottom).offset(10);
        make.left.mas_offset(15);
    }];
//    self.orderNumber.text = @"运单号：2015101900002";
    
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line2View.mas_bottom).offset(10);
        make.right.mas_offset(-25);
    }];
    self.unitLabel.text = @"元";
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.unitLabel.mas_bottom);
        make.right.mas_equalTo(self.unitLabel.mas_left);
    }];
    self.price.text = @"688.0";
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line2View.mas_bottom).offset(10);
        make.right.mas_equalTo(self.price.mas_left);
    }];
    self.priceLabel.text = @"总价 : ";
    
    [self.line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumber.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(2);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line3View.mas_bottom);
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.footerView);
    }];
    
    [self.right2Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.mas_equalTo(self.footerView);
    }];
    
    [self.right1Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.right2Button.mas_left).offset(-10);
        make.centerY.mas_equalTo(self.footerView);
    }];
}


- (void)validOrderStatus:(OrderStatus)status{
    switch (status) {
        case OrderStatusAccepted:
        {
            self.orderStatus.text = @"待受理";
            break;
        }
        case OrderStatusShipped:
        {
            self.orderStatus.text = @"待发货";
            break;
        }
        case OrderStatusReceived:
        {
            self.orderStatus.text = @"待收货";
            break;
        }
        case OrderStatusConfirmed:
        {
            self.orderStatus.text = @"待确认";
            break;
        }
        case OrderStatusEvaluated:
        {
            self.orderStatus.text = @"待评论";
            break;
        }
        case OrderStatusCompleted:
        {
            self.orderStatus.text = @"已完成";
            break;
        }
        default:
            break;
    }
}


#pragma mark - Getter and Setter
- (UIView*)headerView{
    if (_headerView == nil) {
        _headerView = [UIView new];
    }
    return _headerView;
}

- (UIImageView*)companyImageView{
    if (_companyImageView == nil) {
        _companyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_logistics"]];
    }
    return _companyImageView;
}

- (UILabel*)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.font = FONT_S;
    }
    return _companyName;
}

- (UIImageView*)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_details_arrow"]];
    }
    return _arrowImageView;
}

- (UILabel*)orderStatus{
    if (_orderStatus == nil) {
        _orderStatus = [UILabel new];
        _orderStatus.font = FONT_S;
        _orderStatus.textColor = TEXTCOLOR;
    }
    return _orderStatus;
}

- (UIView*)line1View{
    if (_line1View == nil) {
        _line1View = [UIView new];
    }
    return _line1View;
}


- (UIView*)contentView{
    if (_contentView == nil) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UILabel*)beginAddress{
    if (_beginAddress == nil) {
        _beginAddress = [UILabel new];
        _beginAddress.font = FONT_S;
    }
    return _beginAddress;
}

- (UILabel*)endAddress{
    if (_endAddress == nil) {
        _endAddress = [UILabel new];
        _endAddress.font = FONT_S;
    }
    return _endAddress;
}

- (UIImageView*)addressArrowImageView{
    if (_addressArrowImageView == nil) {
        _addressArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrive_icon"]];
    }
    return _addressArrowImageView;
}

- (UIImageView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIImageView new];
    }
    return _logoView;
}

- (UILabel*)goodsDetail{
    if (_goodsDetail == nil) {
        _goodsDetail = [UILabel new];
        _goodsDetail.font = FONT_M;
        _goodsDetail.textColor = TEXTCOLOR;
    }
    return _goodsDetail;
}

- (UILabel*)buyTimeLabel{
    if (_buyTimeLabel == nil) {
        _buyTimeLabel = [UILabel new];
        _buyTimeLabel.font = FONT_M;
        _buyTimeLabel.textColor = TEXTCOLOR;
    }
    return _buyTimeLabel;
}

- (UIView*)line2View{
    if (_line2View == nil) {
        _line2View = [UIView new];
    }
    return _line2View;
}

- (UILabel*)orderNumber{
    if (_orderNumber == nil) {
        _orderNumber = [UILabel new];
        _orderNumber.font = FONT_M;
        _orderNumber.textColor = TEXTCOLOR;
    }
    return _orderNumber;
}

- (UILabel*)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel new];
        _priceLabel.font = FONT_M;
    }
    return _priceLabel;
}

- (UILabel*)price{
    if (_price == nil) {
        _price = [UILabel new];
        _price.font = [UIFont systemFontOfSize:19.0f];
    }
    return _price;
}

- (UILabel*)unitLabel{
    if (_unitLabel == nil) {
        _unitLabel = [UILabel new];
        _unitLabel.font = FONT_M;
    }
    return _unitLabel;
}

- (UIView*)line3View{
    if (_line3View == nil) {
        _line3View = [UIView new];
    }
    return _line3View;
}

- (UIView*)footerView{
    if (_footerView == nil) {
        _footerView = [UIView new];
    }
    return _footerView;
}

- (UIButton*)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _leftButton.titleLabel.textColor = TEXTCOLOR;
        [_leftButton setTitle:@"  左边按钮  " forState:UIControlStateNormal];
        _leftButton.layer.borderWidth = 1.2;
        _leftButton.layer.cornerRadius = 5.0;
        _leftButton.layer.borderColor = [TEXTCOLOR CGColor];
        _leftButton.tintColor = TEXTCOLOR;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _leftButton;
}

- (UIButton*)right1Button{
    if (_right1Button == nil) {
        _right1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _right1Button.titleLabel.textColor = TEXTCOLOR;
        [_right1Button setTitle:@"  右边1按钮  " forState:UIControlStateNormal];
        _right1Button.layer.borderWidth = 1.2;
        _right1Button.layer.cornerRadius = 5.0;
        _right1Button.layer.borderColor = [TEXTCOLOR CGColor];
        _right1Button.tintColor = TEXTCOLOR;
        _right1Button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _right1Button;
}

- (UIButton*)right2Button{
    if (_right2Button == nil) {
        _right2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _right2Button.titleLabel.textColor = TEXTCOLOR;
        [_right2Button setTitle:@"  右边2按钮  " forState:UIControlStateNormal];
        _right2Button.layer.borderWidth = 1.2;
        _right2Button.layer.cornerRadius = 5.0;
        _right2Button.layer.borderColor = [TEXTCOLOR CGColor];
        _right2Button.tintColor = TEXTCOLOR;
        _right2Button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _right2Button;
}

@end
