//
//  WLine.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLine : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *beginProvince;
@property (nonatomic, strong) NSString *beginCity;
@property (nonatomic, strong) NSString *beginDistrict;
@property (nonatomic, strong) NSString *beginStreet;
@property (nonatomic, strong) NSString *beginAddress;

@property (nonatomic, strong) NSString *endProvince;
@property (nonatomic, strong) NSString *endCity;
@property (nonatomic, strong) NSString *endDistrict;
@property (nonatomic, strong) NSString *endStreet;
@property (nonatomic, strong) NSString *endAddress;

@property (nonatomic, assign) double minPrice;
@property (nonatomic, assign) double maxPrice;

@property (nonatomic, assign) double lightMinPrice;
@property (nonatomic, assign) double lightMaxPrice;

@property (nonatomic, assign) NSInteger minDay;
@property (nonatomic, assign) NSInteger maxDay;

@property (nonatomic, assign) NSInteger volume;

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) NSInteger commentNum;
@property (nonatomic, assign) NSInteger commentTotalScore;

@property (nonatomic, strong) NSString *mark;

@property (nonatomic, assign) NSInteger status;

@end
