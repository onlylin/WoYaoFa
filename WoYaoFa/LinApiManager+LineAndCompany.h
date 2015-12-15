//
//  LinApiManager+LineAndCompany.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"

@interface LinApiManager (LineAndCompany)


- (RACSignal *)getCompaniesByDistance:(NSInteger)distance lat:(NSString*)lat lng:(NSString*)lng;


- (RACSignal *)getLineByDistance:(NSInteger)distance lat:(NSString*)lat lng:(NSString*)lng begin:(NSString*)begin end:(NSString*)end;

@end
