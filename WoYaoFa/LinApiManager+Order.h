//
//  LinApiManager+Order.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"
#import "WOrder.h"

@interface LinApiManager (Order)


- (RACSignal*)getOrders:(NSInteger)accountId orderStatus:(OrderStatus)status pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
