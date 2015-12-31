//
//  WHomeViewController.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/5.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLocationService.h"
#import "LLGeoCodeService.h"
#import "LAddressPicker.h"

@interface WHomeViewController : UIViewController<LAddressPickerDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) LLocationService *locationService;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) LLGeoCodeService *geocodeService;

@property (nonatomic, strong) UIBarButtonItem *leftButton;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) LAddressPicker *addressPicker;

@property (nonatomic, strong) WDefaultAddress *defaultAddress;

@end
