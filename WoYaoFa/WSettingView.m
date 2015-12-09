//
//  WSettingView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WSettingView.h"

#define TEXTCOLOR [UIColor hex:@"#666666"]
#define FONT_S [UIFont systemFontOfSize:17.0f]

@interface WSettingView ()

@end

@implementation WSettingView

- (id)initWithFrame:(CGRect)frame viewRole:(WSettingViewRole)role{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textLabel];
        [self addSubview:self.text];
        
        switch (role) {
            case WSettingViewRoleLogo:
            {
                //头像
                self.textLabel.text = @"头像 : ";
                [self addSubview:self.imageView];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(self.height - 6, self.height - 6));
                    make.left.mas_equalTo(self.textLabel.mas_right).offset(-25);
                    make.centerY.equalTo(self);
                }];
                self.imageView.layer.cornerRadius = (self.height - 6) / 2;
                self.imageView.backgroundColor = [UIColor redColor];
                break;
            }
            case WSettingViewRoleNikname:
                //昵称
                self.textLabel.text = @"昵称 : ";
                break;
            case WSettingViewRoleSex:
                //性别
                self.textLabel.text = @"性别 : ";
                break;
            case WSettingViewRoleBirthday:
                //出生日期
                self.textLabel.text = @"出生日期 : ";
                break;
            case WSettingViewRoleAccountAndSecurity:
                //账户安全
                self.textLabel.text = @"账户与安全";
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.mas_height);
        make.left.mas_offset(15);
        make.width.mas_equalTo(85);
    }];
}

#pragma mark - Getter and Setter
- (UILabel*)textLabel{
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.font = FONT_S;
        _textLabel.textColor = TEXTCOLOR;
    }
    return _textLabel;
}

- (UILabel*)text{
    if (_text == nil) {
        _text = [UILabel new];
    }
    return _text;
}

- (UIImageView*)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
