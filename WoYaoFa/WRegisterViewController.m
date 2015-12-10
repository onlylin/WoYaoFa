//
//  WRegisterViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WRegisterViewController.h"
#import "LinApiManager+LoginAndRegister.h"

@interface WRegisterViewController ()

@end

@implementation WRegisterViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView setTableFooterView:self.footerView];
    [self.footerView addSubview:self.registerButton];
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN.width - 60, 40));
        make.center.mas_equalTo(self.footerView);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    @weakify(self)
    [self.codeButton addTouchHandle:^(LCountDownButton *countDownButton, NSInteger tag) {
        @strongify(self)
        RACSignal *signal = [[LinApiManager shareInstance] validPhone:self.phoneField.text];
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(id x) {
            //获取验证码
            [self getVerificationCode:countDownButton tag:tag];
        }];
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
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            [cell addSubview:self.phoneField];
            [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.width.mas_equalTo(SCREEN.width * 0.6);
                make.centerY.mas_equalTo(cell);
            }];
            [cell addSubview:self.codeButton];
            [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-10);
                make.height.equalTo(self.phoneField.mas_height);
                make.left.mas_equalTo(self.phoneField.mas_right);
                make.centerY.mas_equalTo(cell);
            }];
            break;
        }
        case 1:
        {
            [cell addSubview:self.codeField];
            [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.right.mas_offset(-10);
                make.centerY.mas_equalTo(cell);
            }];
            break;
        }
        case 2:
        {
            [cell addSubview:self.passwordField];
            [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.right.mas_offset(-10);
                make.centerY.mas_equalTo(cell);
            }];
            break;
        }
        case 3:
        {
            [cell addSubview:self.checkPwdField];
            [self.checkPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.right.mas_offset(-10);
                make.centerY.mas_equalTo(cell);
            }];
            break;
        }
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - Private Method
- (void)addRACSignal{
    RAC(self.codeButton,userInteractionEnabled) = [RACSignal
                        combineLatest:@[
                            self.phoneField.rac_textSignal
                        ]
                        reduce:^id(NSString *phone){
                            NSNumber *enabled = @(phone.length == 11);
                            self.codeButton.alpha = 0.5 + [enabled integerValue];
                            return enabled;
                        }];
    
    self.registerButton.rac_command = [[RACCommand alloc]
                initWithEnabled:[RACSignal
                                   combineLatest:@[
                                        self.phoneField.rac_textSignal,
                                        self.codeField.rac_textSignal,
                                        self.passwordField.rac_textSignal,
                                        self.checkPwdField.rac_textSignal,
                                    ] reduce:^id(NSString *phone, NSString *code, NSString *password, NSString *checkPwd){
                                        NSNumber *enabled = @(phone.length == 11 && code.length == 4 && password.length >= 6 && [password isEqualToString:checkPwd]);
                                        self.registerButton.alpha = 0.5 + [enabled integerValue];
                                        return enabled;
                                    }]
                signalBlock:^RACSignal *(id input) {
                    WAccount *account = [[WAccount alloc] init];
                    account.name = self.phoneField.text;
                    account.password = self.passwordField.text.MD5;
                    return [[LinApiManager shareInstance] registerAccount:account code:self.codeField.text appkey:MOB_SMS_APPKEY];
                }];
    
    [self.registerButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
       [[signal filter:^BOOL(LDataResult *dataResult) {
           [MBProgressHUD showTextOnly:dataResult.msg];
           return dataResult.code == ResponseStatusOk;
       }] subscribeNext:^(id x) {
          
       }];
    }];
}

- (void)getVerificationCode:(LCountDownButton*)button tag:(NSInteger)tag{
    [MBProgressHUD showMessage:@"获取验证码..."];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneField.text zone:@"+86" customIdentifier:nil result:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {
            [MBProgressHUD showSuccess:@"验证码已发送"];
            
            [button startWithTimeInterval:60];
            
            [button didChange:^NSString *(LCountDownButton *countDownButton, NSTimeInterval timeInterval) {
                NSString *title = [NSString stringWithFormat:@"(%ld秒)重新获取",(long)timeInterval];
                return title;
            }];
            
            [button didFinished:^NSString *(LCountDownButton *countDownButton, NSTimeInterval timeInterval) {
                return @"获取验证码";
            }];
        }else{
            [MBProgressHUD showError:@"验证码发送失败"];
        }
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (UITextField*)phoneField{
    if (_phoneField == nil) {
        _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _phoneField.placeholder = @"手机号码";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"binding_phone"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _phoneField.leftView = view;
        _phoneField.leftViewMode = UITextFieldViewModeAlways;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneField;
}

- (LCountDownButton*)codeButton{
    if (_codeButton == nil) {
        _codeButton = [LCountDownButton buttonWithType:UIButtonTypeCustom];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeButton setBackgroundColor:BUTTON_BG];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _codeButton;
}

- (UITextField *)codeField{
    if (_codeField == nil) {
        _codeField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _codeField.placeholder = @"验证码";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"binding_validation"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _codeField.leftView = view;
        _codeField.leftViewMode = UITextFieldViewModeAlways;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeField;
}

- (UITextField *)passwordField{
    if (_passwordField == nil) {
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _passwordField.placeholder = @"请输入密码";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registered_password_1"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _passwordField.leftView = view;
        _passwordField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passwordField;
}

- (UITextField *)checkPwdField{
    if (_checkPwdField == nil) {
        _checkPwdField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _checkPwdField.placeholder = @"再次输入密码";
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registered_password_1"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _checkPwdField.leftView = view;
        _checkPwdField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _checkPwdField;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:BUTTON_BG];
    }
    return _registerButton;
}

- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 70)];
    }
    return _footerView;
}

@end
