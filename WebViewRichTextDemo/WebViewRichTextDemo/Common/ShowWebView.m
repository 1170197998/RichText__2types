//
//  ShowWebView.m
//  WebViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#import "ShowWebView.h"

@implementation ShowWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return self;
}

@end
