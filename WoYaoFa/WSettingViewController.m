//
//  WSettingViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WSettingViewController.h"
#import "HZActionSheet.h"
#import "WSettingView.h"
#import "LinApiManager+Setting.h"
#import "WEditNameViewController.h"
#import "MLSelectPhotoPickerViewController.h"
#import "WSecurityViewController.h"
#import "UIImage+LImage.h"

@interface WSettingViewController ()<HZActionSheetDelegate>

@end

@implementation WSettingViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"设置";
    
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:self.footerView];
    [self.footerView addSubview:self.logoutButton];
    [self.view addSubview:self.textField];
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

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:WNotficationUpdateUser object:self.user];
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
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleLogo viewModel:self.user];
            [RACObserve(self.user, logo) subscribeNext:^(id x) {
                [view updateViewModel:self.user role:WSettingViewRoleLogo];
            }];
            break;
        }
        case 1:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleNikname viewModel:self.user];
            [RACObserve(self.user, name) subscribeNext:^(id x) {
                [view updateViewModel:self.user role:WSettingViewRoleNikname];
            }];
            break;
        }
        case 2:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleSex viewModel:self.user];
            [RACObserve(self.user, sex) subscribeNext:^(id x) {
                [view updateViewModel:self.user role:WSettingViewRoleSex];
            }];
            break;
        }
        case 3:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleBirthday viewModel:self.user];
            [RACObserve(self.user, birthday) subscribeNext:^(id x) {
                [view updateViewModel:self.user role:WSettingViewRoleBirthday];
            }];
            break;
        }
        case 4:
        {
            view = [[WSettingView alloc] initWithFrame:cell.bounds viewRole:WSettingViewRoleAccountAndSecurity viewModel:nil];
            break;
        }
    }
    view.backgroundColor = [UIColor whiteColor];
    [cell addSubview:view];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            HZActionSheet *actionSheet = [[HZActionSheet alloc] initWithTitle:@"头像选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonIndexSet:nil otherButtonTitles:@[@"拍照",@"相册"]];
            actionSheet.tag = 0;
            [actionSheet showInView:self.view];
            break;
        }
        case 1:
        {
            //注册修改昵称的通知
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotficationNikname object:nil] subscribeNext:^(NSNotification *notification) {
                self.user.name = notification.object;
            }];
            WEditNameViewController *viewController = [[WEditNameViewController alloc] init];
            viewController.userId = self.user.ID;
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 2:
        {
            HZActionSheet *actionSheet = [[HZActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonIndexSet:nil otherButtonTitles:@[@"男",@"女"]];
            actionSheet.tag = 1;
            [actionSheet showInView:self.view];
            break;
        }
        case 3:
        {
            [self.textField becomeFirstResponder];
            break;
        }
        case 4:
        {
            WSecurityViewController *viewController = [[WSecurityViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - HZActionSheetDelegate
- (void)actionSheet:(HZActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 0) {
        if (buttonIndex != 2) {
            NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                if (buttonIndex == 0) {
                    //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                }else if (buttonIndex == 1){
                    //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
            }else{
                if (buttonIndex == 0) {
                    return;
                } else {
                    sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                }
            }
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
    }else{
        if (buttonIndex != 2) {
            WUser *modifyUser = [[WUser alloc] init];
            modifyUser.ID = self.user.ID;
            modifyUser.sex = buttonIndex;
            RACSignal *signal = [[LinApiManager shareInstance] modifyUser:modifyUser];
            [[signal filter:^BOOL(LDataResult *dataResult) {
                [MBProgressHUD showTextOnly:dataResult.msg];
                return dataResult.code == ResponseStatusOk;
            }] subscribeNext:^(LDataResult *dataResult) {
                self.user.sex = modifyUser.sex;
            } completed:^{
                
            }];
        }
    }
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    CGFloat imageHight = SCREEN.width;
    if (image.size.height < imageHight) {
        imageHight = image.size.height;
    }
    //压缩图片
    UIImage *smallImage = [image scaledToSize:CGSizeMake(SCREEN.width, imageHight)];
    RACSignal *signal = [[LinApiManager shareInstance] uploadLogo:smallImage account:33 user:3];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk;
    }] subscribeNext:^(LDataResult *dataResult) {
        self.user.logo = dataResult.datas;
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIDateView Delegate
- (void)selected:(NSDate *)date{
    WUser *modifyUser = [[WUser alloc] init];
    modifyUser.ID = self.user.ID;
    modifyUser.birthday = [date timeIntervalSince1970] * 1000;
    RACSignal *signal = [[LinApiManager shareInstance] modifyUser:modifyUser];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk;
    }] subscribeNext:^(LDataResult *dataResult) {
        self.user.birthday = modifyUser.birthday;
    } completed:^{
        
    }];
    [self deSelected];
}

- (void)deSelected{
    [self.textField resignFirstResponder];
}

#pragma mark - Event Response
- (void)logoutAction:(id)sender{
    UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否退出当前账号?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"退出"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            //发送退出登录通知
            [[NSNotificationCenter defaultCenter] postNotificationName:WNotificationLogout object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertView show];
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
        [_logoutButton addTarget:self action:@selector(logoutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

- (WUser*)user{
    if (_user == nil) {
        _user = [[WUser alloc] init];
    }
    return _user;
}

- (UIDateView*)datePicker{
    if (_datePicker == nil) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        _datePicker = [[UIDateView alloc] initWithTimeZone:timeZone locale:locale mode:UIDatePickerModeDate maxDate:[NSDate date]];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UITextField*)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.inputView = self.datePicker;
    }
    return _textField;
}

@end
