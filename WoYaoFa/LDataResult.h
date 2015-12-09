//
//  LDataResult.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDataResult : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) id datas;

@property (nonatomic, strong) NSString *msg;

@end
