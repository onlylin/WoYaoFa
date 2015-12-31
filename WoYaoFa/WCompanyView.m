//
//  WCompanyView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCompanyView.h"
#import "WLine.h"

#define FONT_S [UIFont systemFontOfSize:15.0f]
#define FONT_M [UIFont systemFontOfSize:13.0f]

@implementation WCompanyView


- (id)initWithFrame:(CGRect)frame viewModel:(WCompany *)company{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.logoView];
        [self addSubview:self.companyName];
        [self addSubview:self.lineLabel];
        [self addSubview:self.markLabel];
        [self addSubview:self.distanceLabel];
        [self addSubview:self.volumeLabel];
        
        self.companyName.text = company.name;
        
        NSString *linesText = @"";
        NSInteger total = 0;
        NSArray *lines = [WLine mj_objectArrayWithKeyValuesArray:company.lines];
        for (WLine *line in lines) {
            linesText = [linesText stringByAppendingString:[NSString stringWithFormat:@"%@%@>%@%@",line.beginCity,line.beginDistrict,line.endCity,line.endDistrict]];
            total += line.volume;
        }
        self.lineLabel.text = [NSString stringWithFormat:@"主营线路 : %@",linesText];

        self.markLabel.text = company.mark;
        
        self.volumeLabel.text = [NSString stringWithFormat:@"成交量 : %ld笔",total];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.model = company;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.left.mas_offset(15);
    }];
    self.logoView.backgroundColor = [UIColor blackColor];
    
    [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoView.mas_right).offset(15);
        make.top.mas_equalTo(self.logoView.mas_top).offset(5);
    }];
//    self.companyName.text = @"邦德物流有限公司";
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyName.mas_left);
        make.top.mas_equalTo(self.companyName.mas_bottom).offset(5);
        make.right.mas_offset(-10);
    }];
//    self.lineLabel.text = @"主营线路 : 石家庄裕华区 > 上海市全境 石家庄裕华区 > 深圳全境 石家庄裕华区 > 深圳全境";
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.companyName.mas_left);
        make.bottom.mas_equalTo(self.logoView.mas_bottom).offset(-2);
    }];
//    self.markLabel.text = @"润丰物流园";
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.markLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.markLabel.mas_bottom);
    }];
    self.distanceLabel.text = @"11km";
    
    [self.volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_equalTo(self.markLabel.mas_bottom);
    }];
//    self.volumeLabel.text = @"成交量 : 10笔";
}


#pragma mark - Getter and Setter
- (UIImageView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIImageView new];
    }
    return _logoView;
}

- (UILabel*)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
    }
    return _companyName;
}

- (UILabel*)lineLabel{
    if (_lineLabel == nil) {
        _lineLabel = [UILabel new];
        _lineLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _lineLabel.numberOfLines = 3;
        _lineLabel.font = FONT_M;
    }
    return _lineLabel;
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

@end
