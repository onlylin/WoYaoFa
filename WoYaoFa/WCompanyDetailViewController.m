//
//  WCompanyDetailViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/24.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCompanyDetailViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UIWebView+LWebView.h"

@interface WCompanyDetailViewController (){
    WebViewJavascriptBridge *bridge;
}

@end

@implementation WCompanyDetailViewController
@synthesize dictionary;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.title = @"公司详情";
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.webView loadHTMLFile:@"company_detail.html" path:@"www/html"];
    if (!bridge) {
        [WebViewJavascriptBridge enableLogging];
        bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"发快递");
        }];
    }
    //获取公司详情
    [bridge callHandler:@"comapnyDetail" data:dictionary responseCallback:^(id responseData) {
        NSLog(@"%@",responseData);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
