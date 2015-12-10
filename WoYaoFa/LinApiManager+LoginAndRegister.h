//
//  LinApiManager+LoginAndRegister.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LinApiManager.h"


@interface LinApiManager (LoginAndRegister)

- (RACSignal *)validPhone:(NSString*)phone;

- (RACSignal *)registerAccount:(WAccount*)account code:(NSString*)code appkey:(NSString*)appkey;

- (RACSignal *)signIn:(NSString*)username password:(NSString*)password;

@end
