//
//  WLineViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/24.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WLineViewController.h"
#import "WebViewJavascriptBridge.h"
#import "WPlaceOrderViewController.h"
#import "WCompanyDetailViewController.h"
#import "WCommentListViewController.h"
#import "UIWebView+LWebView.h"

@interface WLineViewController (){
    WebViewJavascriptBridge *bridge;
}

@end

@implementation WLineViewController
@synthesize companyId;
@synthesize lineId;

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    [self initWebView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)initWebView{
    [self.webView loadHTMLFile:@"line_detail.html" path:@"www/html"];
    if (!bridge) {
        [WebViewJavascriptBridge enableLogging];
        bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"发快递");
        }];
        
        //下单
        [bridge registerHandler:@"makeOrder" handler:^(id data, WVJBResponseCallback responseCallback) {
            WPlaceOrderViewController *viewController = [[WPlaceOrderViewController alloc] init];
            viewController.lineId = lineId;
            [self.navigationController pushViewController:viewController animated:YES];
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
        
        //评论列表
        [bridge registerHandler:@"comment" handler:^(id data, WVJBResponseCallback responseCallback) {
            WCommentListViewController *viewController = [[WCommentListViewController alloc] init];
            viewController.lineId = lineId;
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
        //公司详情
        [bridge registerHandler:@"detail" handler:^(id data, WVJBResponseCallback responseCallback) {
            WCompanyDetailViewController *viewController = [[WCompanyDetailViewController alloc] init];
            viewController.dictionary = data;
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        
    }
    NSDictionary *dictionary = @{
                                 @"id" : @(lineId),
                                 @"companyId" : @(companyId),
                                 @"accountId" : @(33)
                                 };
    [bridge callHandler:@"lineDetail" data:dictionary responseCallback:^(id responseData) {
        
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
