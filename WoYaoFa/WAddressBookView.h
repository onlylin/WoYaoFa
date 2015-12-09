//
//  WAddressBookView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAddressBookView : UIView

@property (nonatomic, strong) UIView *nameView;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UIView *addressView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *phone;
@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UIImageView *defaultImageView;

- (id)initWithFrame:(CGRect)frame;

@end
