//
//  WProfileViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/5.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WProfileViewController.h"
#import "WAddressBookViewController.h"
#import "WSettingViewController.h"
#import "WLoginNavigation.h"
#import "WLineAndCompanyViewController.h"

@interface WProfileViewController ()

@end

@implementation WProfileViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.view.backgroundColor = VIEW_BG;
    self.profileHeadView.backgroundColor = NAV_BG;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.profileHeadView;
    
    [self addRACsignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
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
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"my_address_book"];
            cell.textLabel.text = @"地址簿";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"my_collection"];
            cell.textLabel.text = @"我的收藏";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"my_order_history"];
            cell.textLabel.text = @"历史订单";
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"my_opinion"];
            cell.textLabel.text = @"意见反馈";
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"my_phone"];
            cell.textLabel.text = @"联系我们";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            WAddressBookViewController *viewController = [[WAddressBookViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 1:
        {
            WSettingViewController *viewController = [[WSettingViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 2:
        {
            
            break;
        }
        default:
        {
            WLineAndCompanyViewController *viewController = [[WLineAndCompanyViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
    }
}


#pragma mark - Event Response
-(BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark - Private Method
- (void)addRACsignal{
    self.profileHeadView.settingButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (self.account != nil) {
            //注册退出登录的通知
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotificationLogout object:nil] subscribeNext:^(id x) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:currentUser];
                self.account = nil;
            }];
            //用户信息更新通知
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotficationUpdateUser object:nil] subscribeNext:^(NSNotification *notification) {
                NSLog(@"%@",notification.object);
                WAccount *modifyAccount = self.account;
                modifyAccount.user = notification.object;
                NSLog(@"%@",modifyAccount.user.name);
                self.account = modifyAccount;
            }];
            WSettingViewController *viewController = [[WSettingViewController alloc] init];
            viewController.user = self.account.user;
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
            [self showLoginView];
        }
        return [RACSignal empty];
    }];
    
    [RACObserve(self, account) subscribeNext:^(WAccount *object) {
        [self.profileHeadView updateViewModel:object];
        [[NSUserDefaults standardUserDefaults] setObject:self.account.mj_keyValues forKey:currentUser];
    } completed:^{
        
    }];
}


- (void)showLoginView{
    WLoginNavigation *loginNavigation = [[WLoginNavigation alloc] init];
    [self presentViewController:loginNavigation animated:YES completion:^{
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotificationLogin object:nil] subscribeNext:^(NSNotification *notification) {
            self.account = notification.object;
        }];
    }];
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (WProfileHeaderView*)profileHeadView{
    if (_profileHeadView == nil) {
        _profileHeadView = [[WProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 0.3 * SCREEN.height) viewModel:self.account];
    }
    return _profileHeadView;
}

- (UIView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIView new];
    }
    return _logoView;
}

- (WAccount*)account{
    if (_account == nil) {
        _account = [WAccount mj_objectWithKeyValues:[[NSUserDefaults standardUserDefaults] objectForKey:currentUser]];
    }
    return _account;
}


@end
