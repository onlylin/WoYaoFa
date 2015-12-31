//
//  ViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/4.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *viewControllers = @[self.homeNavigation,self.orderNavigation,self.profileNavigation];
    self.viewControllers = viewControllers;
    
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:2];
    
//    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil];
    
    [item1 setImage:[UIImage imageNamed:@"house_not_choose"]];
    [item1 setSelectedImage:[UIImage imageNamed:@"house_choose"]];
    [item1 setTitle:@"首页"];
    [item2 setImage:[UIImage imageNamed:@"order_not_choose"]];
    [item2 setSelectedImage:[UIImage imageNamed:@"order_choose"]];
    [item2 setTitle:@"订单"];
    [item3 setImage:[UIImage imageNamed:@"my_not_choose"]];
    [item3 setSelectedImage:[UIImage imageNamed:@"my_choose"]];
    [item3 setTitle:@"我的"];
    
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Getter and Setter
- (WHomeNavigation *)homeNavigation{
    if (_homeNavigation == nil) {
        _homeNavigation = [[WHomeNavigation alloc] init];
    }
    return _homeNavigation;
}

- (WOrderNavigation *)orderNavigation{
    if (_orderNavigation == nil) {
        _orderNavigation = [[WOrderNavigation alloc] init];
    }
    return _orderNavigation;
}

- (WProfileNavigation *)profileNavigation{
    if (_profileNavigation == nil) {
        _profileNavigation = [[WProfileNavigation alloc] init];
    }
    return _profileNavigation;
}

@end
