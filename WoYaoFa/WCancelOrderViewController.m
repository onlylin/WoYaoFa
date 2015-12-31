//
//  WCancelOrderViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/20.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCancelOrderViewController.h"

@interface WCancelOrderViewController ()

@end

@implementation WCancelOrderViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    switch (indexPath.section) {
        case 0:
        {
            [cell addSubview:self.iconImageView];
            [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.centerY.mas_equalTo(cell);
            }];
            [cell addSubview:self.phoneImageView];
            [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.centerY.mas_equalTo(cell);
            }];
            break;
        }
            
        default:
            break;
    }
    return cell;
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (UIImageView*)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order_logistics"]];
    }
    return _iconImageView;
}

- (UIImageView*)phoneImageView{
    if (_phoneImageView == nil) {
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_phone"]];
    }
    return _phoneImageView;
}

@end
