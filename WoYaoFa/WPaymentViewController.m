//
//  WPaymentViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/21.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WPaymentViewController.h"
#import "UITextView+placeholder.h"

@interface WPaymentViewController ()

@end

@implementation WPaymentViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    if (section != 0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if (indexPath.section == 0) {
        [cell addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.centerY.equalTo(cell);
        }];
        [cell addSubview:self.companyName];
        [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(5);
            make.centerY.equalTo(self.iconImageView);
        }];
        self.companyName.text = @"德邦物流有限公司";
        [cell addSubview:self.phoneImageView];
        [self.phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.centerY.equalTo(cell);
        }];
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, cell.height)];
                label.text = @"提示 : 如有问题请先与承运方进行沟通";
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
                [cell addSubview:label];
                break;
            }
            case 1:
            {
                UILabel *label1 = [UILabel new];
                label1.text = @"理赔金额:";
                [cell addSubview:label1];
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(15);
                    make.centerY.equalTo(cell);
                }];
                [cell addSubview:self.textField];
                [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(label1.mas_right).offset(2);
                    make.width.mas_equalTo(70);
                    make.centerY.equalTo(cell);
                }];
                UILabel *label2 = [UILabel new];
                label2.text = @"元";
                [cell addSubview:label2];
                [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.textField.mas_right).offset(2);
                    make.centerY.equalTo(cell);
                }];
                break;
            }
            case 2:
            {
                UILabel *label = [UILabel new];
                label.text = @"理赔原因:";
                [cell addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(15);
                    make.top.mas_offset(10);
                }];
                [cell addSubview:self.textView];
                [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(label.mas_right).offset(2);
                    make.top.mas_offset(2);
                    make.right.mas_offset(0);
                    make.bottom.mas_offset(0);
                }];
                break;
            }
            default:
                break;
        }
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN.width, cell.height)];
        [cell addSubview:label];
        switch (indexPath.row) {
            case 0:
            {
                label.text = @"发货时间: 2015-10-19 14:00:00";
                break;
            }
            case 1:
            {
                label.text = @"运单号：201510190001";
                break;
            }
            case 2:
            {
                label.text = @"客服电话: 400";
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            return 100;
        }
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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

- (UILabel*)companyName{
    if (_companyName == nil) {
        _companyName = [UILabel new];
        _companyName.font = [UIFont systemFontOfSize:15.0f];
    }
    return _companyName;
}

- (UIImageView*)phoneImageView{
    if (_phoneImageView == nil) {
        _phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_phone"]];
    }
    return _phoneImageView;
}

- (UITextField*)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
    }
    return _textField;
}

- (UITextView*)textView{
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.placeholder = @"点击输入";
        _textView.font = [UIFont systemFontOfSize:15.f];
    }
    return _textView;
}

@end
