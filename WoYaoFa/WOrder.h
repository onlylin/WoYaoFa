//
//  WOrder.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLine.h"

typedef NS_ENUM(NSInteger,OrderStatus) {
    OrderStatusCompleted = -1,
    OrderStatusAccepted,
    OrderStatusShipped,
    OrderStatusReceived,
    OrderStatusConfirmed,
    OrderStatusEvaluated
};

@interface WOrder : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *beginName;
@property (nonatomic, strong) NSString *beginPhone;
@property (nonatomic, strong) NSString *beginAddress;
@property (nonatomic, strong) NSString *endName;
@property (nonatomic, strong) NSString *endPhone;
@property (nonatomic, strong) NSString *endAddress;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) OrderStatus status;
@property (nonatomic, assign) double fee;
@property (nonatomic, assign) double pickUpFee;
@property (nonatomic, assign) double sendFee;
@property (nonatomic, assign) long buyTime;
@property (nonatomic, assign) long dueTime;
@property (nonatomic, assign) long dealTime;
@property (nonatomic, assign) long sendTme;
@property (nonatomic, assign) long arrivalTime;
@property (nonatomic, assign) long completeTime;

@property (nonatomic, strong) WLine *line;

@end
