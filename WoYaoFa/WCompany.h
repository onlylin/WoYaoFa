//
//  WCompany.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/14.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCompany : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *person;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, assign) NSInteger CAIC;
@property (nonatomic, strong) NSMutableArray *CAICImages;
@property (nonatomic, assign) NSInteger QC;
@property (nonatomic, strong) NSMutableArray *QCImages;
@property (nonatomic, assign) double registeredCapital;
@property (nonatomic, assign) NSInteger carNum;
@property (nonatomic, assign) NSInteger staffNum;
@property (nonatomic, assign) NSInteger areaCovered;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSArray *lines;


@end
