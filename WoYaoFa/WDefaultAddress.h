//
//  WDefaultAddress.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/31.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDefaultAddress : NSObject

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;

@end
