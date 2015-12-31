//
//  LinApiManager+Comment.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"
#import "WComment.h"

@interface LinApiManager (Comment)

- (RACSignal *)addComment:(WComment*)comment order:(NSInteger)orderId;

- (RACSignal *)uploadImages:(NSArray*)images comment:(NSInteger)commentId;

- (RACSignal *)getCommentsWithLineId:(NSInteger)lineId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end
