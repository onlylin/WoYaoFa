//
//  WLoginViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WLoginViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "WRegisterViewController.h"
#import "LinApiManager+LoginAndRegister.h"

@interface WLoginViewController ()

@end

@implementation WLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self.view addSubview:self.backView];
    [self.view addSubview:self.usernameField];
    [self.view addSubview:self.usernameLine];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.passwordLine];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgetButtton];
    
    [self addRACSiganl];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view.bounds.size);
    }];
    
    [self.usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-280);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
    }];
    
    [self.usernameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(self.usernameField.mas_bottom).offset(1);
    }];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(self.usernameLine.mas_bottom).offset(20);
    }];
    
    [self.passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(self.passwordField.mas_bottom).offset(1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.passwordLine.mas_bottom).offset(35);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(15);
    }];
    
    [self.forgetButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.bottom.mas_equalTo(self.usernameField.mas_top).offset(-5);
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}


#pragma mark - Private Method
- (void)addRACSiganl{
    self.registerButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        WRegisterViewController *viewController = [[WRegisterViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        return [RACSignal empty];
    }];
    
    self.loginButton.rac_command = [[RACCommand alloc]
                        initWithEnabled:[RACSignal
                                         combineLatest:@[
                                            self.usernameField.rac_textSignal,
                                            self.passwordField.rac_textSignal
                                         ] reduce:^id(NSString *username,NSString *password){
                                             NSNumber *enabled = @(username.length > 0 && password.length >= 6);
                                             self.loginButton.alpha = 0.5 + [enabled integerValue];
                                             return enabled;
                                         }]
                        signalBlock:^RACSignal *(id input) {
                            return [[LinApiManager shareInstance] signIn:self.usernameField.text password:self.passwordField.text.MD5];
                        }];
    
    [self.loginButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [[[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] map:^id(LDataResult *dataResult) {
            NSLog(@"%@",dataResult.datas);
            return [WAccount mj_objectWithKeyValues:dataResult.datas];
        }] subscribeNext:^(WAccount *account) {
//            [[NSUserDefaults standardUserDefaults] setObject:account.mj_keyValues forKey:currentUser];
            [[NSNotificationCenter defaultCenter] postNotificationName:WNotificationLogin object:account];
            [self dismissViewControllerAnimated:YES completion:nil];
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
-(UIImageView*)backView{
    if (_backView == nil) {
        _backView = [[UIImageView alloc] init];
        [_backView setImageToBlur:[UIImage imageNamed:@"bg"] completionBlock:nil];
    }
    return _backView;
}

- (UITextField *)usernameField{
    if (_usernameField == nil) {
        _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _usernameField.placeholder = @"手机号码";
        [_usernameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registered_phone"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _usernameField.leftView = view;
        _usernameField.leftViewMode = UITextFieldViewModeAlways;
        _usernameField.textColor = [UIColor whiteColor];
    }
    return _usernameField;
}

- (UIView *)usernameLine{
    if (_usernameLine == nil) {
        _usernameLine = [UIView new];
        _usernameLine.backgroundColor = [UIColor whiteColor];
    }
    return _usernameLine;
}

- (UITextField*)passwordField{
    if (_passwordField == nil) {
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 40)];
        _passwordField.placeholder = @"密码";
        [_passwordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registered_password"]];
        [view addSubview:iconView];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        _passwordField.leftView = view;
        _passwordField.leftViewMode = UITextFieldViewModeAlways;
        _passwordField.textColor = [UIColor whiteColor];
    }
    return _passwordField;
}

- (UIView *)passwordLine{
    if (_passwordLine == nil) {
        _passwordLine = [UIView new];
        _passwordLine.backgroundColor = [UIColor whiteColor];
    }
    return _passwordLine;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:BUTTON_BG];
        _loginButton.layer.cornerRadius = 5.0;
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:BUTTON_BG];
        _registerButton.layer.cornerRadius = 5.0;
    }
    return _registerButton;
}

- (UIButton*)forgetButtton{
    if (_forgetButtton == nil) {
        _forgetButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButtton setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    }
    return _forgetButtton;
}

@end
