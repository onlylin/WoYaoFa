//
//  WSettingViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WSettingViewController.h"
#import "WSettingView.h"

@interface WSettingViewController ()

@end

@implementation WSettingViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:self.footerView];
    [self.footerView addSubview:self.logoutButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.width.mas_equalTo(SCREEN.width - 30);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.footerView);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    WSettingView *view;
    switch (indexPath.row) {
        case 0:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleLogo];
            break;
        }
        case 1:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleNikname];
            break;
        }
        case 2:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleSex];
            break;
        }
        case 3:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleBirthday];
            break;
        }
        case 4:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleAccountAndSecurity];
            break;
        }
    }
    view.backgroundColor = [UIColor whiteColor];
    [cell addSubview:view];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
- (UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [UITableView new];
    }
    return _tableView;
}

- (UIView*)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 100)];
    }
    return _footerView;
}

- (UIButton*)logoutButton{
    if (_logoutButton == nil) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出当前账户" forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:BUTTON_BG];
    }
    return _logoutButton;
}

@end
