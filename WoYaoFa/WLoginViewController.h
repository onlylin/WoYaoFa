//
//  WLoginViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLoginViewController : UIViewController

@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UITextField *usernameField;

@property (nonatomic, strong) UIView *usernameLine;

@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIView *passwordLine;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *forgetButtton;

@end
