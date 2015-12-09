//
//  MBProgressHUD+LHUD.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/9.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (LHUD)

+ (void)showTextOnly:(NSString*)text;
+ (void)showTextOnly:(NSString *)text inView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success inView:(UIView *)view;

+ (void)showError:(NSString*)error;
+ (void)showError:(NSString *)error inView:(UIView *)view;

+ (MBProgressHUD*)showMessage:(NSString*)message;
+ (MBProgressHUD*)showMessage:(NSString *)message inView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
