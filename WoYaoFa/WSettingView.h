//
//  WSettingView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WSettingViewRole) {
    WSettingViewRoleLogo,
    WSettingViewRoleNikname,
    WSettingViewRoleSex,
    WSettingViewRoleBirthday,
    WSettingViewRoleAccountAndSecurity
};


@interface WSettingView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *value;
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame viewRole:(WSettingViewRole)role viewModel:(WUser*)user;

- (void)updateViewModel:(WUser*)user role:(WSettingViewRole)role;

@end
