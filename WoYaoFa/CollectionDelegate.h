//
//  CollectionDelegate.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/30.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCollection.h"

@protocol CollectionDelegate <NSObject>

@optional
- (void)cancel:(UIView*)view collection:(WCollection*)collection;
- (void)order:(WLine*)line;
- (void)callPhone:(WCollection*)collection;

@end
