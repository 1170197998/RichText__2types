//
//  ShowViewController.m
//  TextViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ShowViewController.h"

@interface ShowViewController ()
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (strong, nonatomic)UIWebView *webView;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray array];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
}


@end
