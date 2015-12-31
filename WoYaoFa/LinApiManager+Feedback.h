//
//  LinApiManager+Feedback.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"

@interface LinApiManager (Feedback)

- (RACSignal*)addFeedback:(NSString*)content account:(NSInteger)accountId;

@end
