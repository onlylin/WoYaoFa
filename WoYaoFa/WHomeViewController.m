//
//  WHomeViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/5.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WHomeViewController.h"
#import "WebViewJavascriptBridge.h"
#import "WLineAndCompanyViewController.h"
#import "UIWebView+LWebView.h"

@interface WHomeViewController (){
    WebViewJavascriptBridge *bridge;
}

@end

@implementation WHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.view.backgroundColor = VIEW_BG;
    self.navigationController.navigationBar.barTintColor = NAV_BG;
    self.navigationItem.leftBarButtonItem = self.leftButton;
    self.navigationItem.titleView = self.titleView;
    
    [self.view addSubview:self.webView];
    [self.titleView addSubview: self.arrowView];
    [self.view addSubview:self.textField];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(-5);
        make.centerY.equalTo(self.titleView);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [self setHidesBottomBarWhenPushed:YES];
    [self.webView loadHTMLFile:@"index.html" path:@"www"];
    if (!bridge) {
        [WebViewJavascriptBridge enableLogging];
        bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"发快递");
        }];
        //发快递
        [bridge registerHandler:@"express" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"testObjcCallback called: %@", data);
        }];
        //找物流
        [bridge registerHandler:@"findLogistics" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"找物流");
            WLineAndCompanyViewController *viewController = [[WLineAndCompanyViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    [self.webView bk_setDidFinishLoadBlock:^(UIWebView *webView) {
        
    }];
    
    //定位开启
    [self.locationService startWithCompletionBlockWithSuccess:^(CLLocationCoordinate2D coordinate) {
        self.defaultAddress.lat = coordinate.latitude;
        self.defaultAddress.lng = coordinate.longitude;
        [self.geocodeService startReGeocodeSearch:coordinate success:^(AMapReGeocodeSearchResponse *response) {
            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:@"提示" message:[NSString stringWithFormat:@"是否把当前位置修改为%@",response.regeocode.addressComponent.district] cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    self.defaultAddress.province = response.regeocode.addressComponent.province;
                    self.defaultAddress.city = response.regeocode.addressComponent.city;
                    self.defaultAddress.district = response.regeocode.addressComponent.district;
                    self.leftButton.title = response.regeocode.addressComponent.district;
                    [[NSUserDefaults standardUserDefaults] setObject:self.defaultAddress.mj_keyValues forKey:ADDRESS];
                }
            }];
            [alertView show];
        }];
    } failure:^(NSError *error, CLLocationCoordinate2D coordinate) {
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LAddressPicker Delegate
- (void)selectedProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@,%@,%@",province,city,district] forKey:ADDRESS];
    self.leftButton.title = district;
    [self deSelected];
}

- (void)deSelected{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGFloat M = 3.1415;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(0*M);
    self.arrowView.transform = transform;
    [UIView commitAnimations];
    [self.textField resignFirstResponder];
}

#pragma mark - Event Response
- (void)selectAddress:(id)sender{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGFloat M = 3.1415;
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(1*M);
    self.arrowView.transform = transform;
    [UIView commitAnimations];
    [self.textField becomeFirstResponder];
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
- (UIWebView*)webView{
    if (_webView == nil) {
        _webView = [UIWebView new];
    }
    return _webView;
}

- (LLocationService*)locationService{
    if (_locationService == nil) {
        _locationService = [[LLocationService alloc] init];
    }
    return _locationService;
}

- (LLGeoCodeService*)geocodeService{
    if (_geocodeService == nil) {
        _geocodeService = [[LLGeoCodeService alloc] init];
    }
    return _geocodeService;
}

- (UIBarButtonItem*)leftButton{
    if (_leftButton == nil) {
        _leftButton = [[UIBarButtonItem alloc] initWithTitle:@"地址" style:UIBarButtonItemStylePlain target:self action:@selector(selectAddress:)];
    }
    return _leftButton;
}

- (UIImageView*)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"an"]];
    }
    return _arrowView;
}

- (UIView*)titleView{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN.width, 44)];
    }
    return _titleView;
}

- (LAddressPicker*)addressPicker{
    if (_addressPicker == nil) {
        _addressPicker = [[LAddressPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 240)];
        _addressPicker.delegate = self;
    }
    return _addressPicker;
}

- (UITextField*)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.inputView = self.addressPicker;
    }
    return _textField;
}

- (WDefaultAddress*)defaultAddress{
    if (_defaultAddress == nil) {
        _defaultAddress = [[WDefaultAddress alloc] init];
    }
    return _defaultAddress;
}



@end
