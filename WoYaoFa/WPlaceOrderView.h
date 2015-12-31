//
//  WPlaceOrderView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/17.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAddressBook.h"

@interface WPlaceOrderView : UIView

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *phone;

@property (nonatomic, strong) UIView *addressLabelView;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UIView *addressView;

@property (nonatomic, strong) WAddressBook *model;


- (id)initWithFrame:(CGRect)frame;

@end
