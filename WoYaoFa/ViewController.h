//
//  ViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHomeNavigation.h"
#import "WOrderNavigation.h"
#import "WProfileNavigation.h"

@interface ViewController : UITabBarController

@property (nonatomic, strong) WHomeNavigation *homeNavigation;

@property (nonatomic, strong) WOrderNavigation *orderNavigation;

@property (nonatomic, strong) WProfileNavigation *profileNavigation;

@end
