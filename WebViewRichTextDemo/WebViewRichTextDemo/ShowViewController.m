//
//  ShowViewController.m
//  WebViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowWebView.h"
@interface ShowViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)ShowWebView *webView;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[ShowWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
    
    NSLog(@"second:---%@",self.htmlString);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL] options:@{} completionHandler:nil];
        return NO;
    }
    return YES;
}

@end
