//
//  LinApiManager+Setting.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/14.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"

@interface LinApiManager (Setting)

- (RACSignal*)modifyUser:(WUser*)user;

@end
