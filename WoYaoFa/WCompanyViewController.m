//
//  WCompanyViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/23.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCompanyViewController.h"
#import "WebViewJavascriptBridge.h"
#import "WCompanyDetailViewController.h"
#import "UIWebView+LWebView.h"

@interface WCompanyViewController (){
    WebViewJavascriptBridge *bridge;
}

@end

@implementation WCompanyViewController
@synthesize companyId;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.title = @"公司首页";
    [self.view addSubview:self.webView];
    [self initWebView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)initWebView{
    [self.webView loadHTMLFile:@"company_index.html" path:@"www/html"];
    if (!bridge) {
        [WebViewJavascriptBridge enableLogging];
        bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"发快递");
        }];
        //打电话
        [bridge registerHandler:@"callPhone" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSDictionary *dictionary = data;
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] bk_initWithTitle:nil];
            [actionSheet bk_addButtonWithTitle:dictionary[@"phone"] handler:^{
                
            }];
            [actionSheet bk_setCancelButtonWithTitle:@"取消" handler:^{
                
            }];
            [actionSheet showInView:self.view];
        }];
        
        //公司详情
        [bridge registerHandler:@"detail" handler:^(id data, WVJBResponseCallback responseCallback) {
            WCompanyDetailViewController *viewController = [[WCompanyDetailViewController alloc] init];
            viewController.dictionary = data;
            [self.navigationController pushViewController:viewController animated:YES];
        }];
    }
    NSDictionary *dictionary = @{
                                 @"id" : @(companyId)
                                 };
    [bridge callHandler:@"companyHome" data:dictionary responseCallback:^(id responseData) {
        
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
- (UIWebView*)webView{
    if (_webView == nil) {
        _webView = [UIWebView new];
    }
    return _webView;
}

@end
