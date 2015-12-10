//
//  WLoginNavigation.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WLoginNavigation.h"

@interface WLoginNavigation ()

@end

@implementation WLoginNavigation

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = NAV_BG;
    self.navigationBar.tintColor = [UIColor whiteColor];
    //设置文本颜色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    [self pushViewController:self.viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
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
- (WLoginViewController*)viewController{
    if (_viewController == nil) {
        _viewController = [[WLoginViewController alloc] init];
    }
    return _viewController;
}

@end
