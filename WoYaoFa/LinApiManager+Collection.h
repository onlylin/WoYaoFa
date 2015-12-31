//
//  LinApiManager+Collection.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"
#import "WCollection.h"

@interface LinApiManager (Collection)

- (RACSignal*)getCollectionByAccountId:(NSInteger)accountId type:(CollectionType)type;

- (RACSignal*)cancelCollection:(NSInteger)collectionId;

@end
