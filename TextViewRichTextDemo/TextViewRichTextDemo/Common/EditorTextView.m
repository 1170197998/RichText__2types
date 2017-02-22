//
//  EditorTextView.m
//  RichText
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#import "EditorTextView.h"

@implementation EditorTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollEnabled = YES;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.font = [UIFont systemFontOfSize:18];
    }
    return self;
}

@end
