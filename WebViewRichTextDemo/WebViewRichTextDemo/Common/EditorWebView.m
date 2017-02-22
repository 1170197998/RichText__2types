//
//  STWebView.m
//  WebViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#import "EditorWebView.h"

@implementation EditorWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"RichTextEditor" withExtension:@"html"];
        [self loadRequest:[NSURLRequest requestWithURL:fileUrl]];
        [self setKeyboardDisplayRequiresUserAction:NO];
        self.dataDetectorTypes = UIDataDetectorTypeNone;
        self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return self;
}


@end
