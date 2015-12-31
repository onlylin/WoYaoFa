//
//  UIWebView+LWebView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/23.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "UIWebView+LWebView.h"

@implementation UIWebView (LWebView)

- (void)loadHTMLFile:(NSString *)name path:(NSString *)path{
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:name ofType:nil inDirectory:path];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self loadHTMLString:appHtml baseURL:baseURL];
}

@end
