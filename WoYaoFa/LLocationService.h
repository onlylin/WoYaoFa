//
//  LLocationService.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLMapBaseService.h"

@interface LLocationService : LLMapBaseService

@property (nonatomic, copy) void (^completionBlock)(CLLocationCoordinate2D coordinate);
@property (nonatomic, copy) void(^failureBlock)(NSError *error,CLLocationCoordinate2D coordinate);

- (void)startWithCompletionBlockWithSuccess:(void(^)(CLLocationCoordinate2D coordinate))success
                                    failure:(void(^)(NSError *error,CLLocationCoordinate2D coordinate))failure;

@end
