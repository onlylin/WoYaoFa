//
//  WCollection.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLine.h"

typedef NS_ENUM(NSInteger,CollectionType) {
    CollectionTypeCompany = 0,
    CollectionTypeLine
};

@interface WCollection : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) CollectionType type;
@property (nonatomic, strong) WLine *line;
@property (nonatomic, strong) WCompany *company;

@end
