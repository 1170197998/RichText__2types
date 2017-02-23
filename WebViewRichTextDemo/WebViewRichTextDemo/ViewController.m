//
//  ViewController.m
//  WebViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#import "ViewController.h"
#import "EditorWebView.h"
#import "ShowViewController.h"
@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)EditorWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[EditorWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (IBAction)showPage:(id)sender
{
    ShowViewController *vc = [[ShowViewController alloc] init];
    vc.htmlString = [self getHtmlString];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)getHtmlString
{
    NSString *htmlString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    NSLog(@"htmlString:---%@",htmlString);
    return [self changeString:htmlString];
}

-(NSString *)changeString:(NSString *)str
{
    NSMutableArray * marr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"\""]];
    for (int i = 0; i < marr.count; i ++) {
        NSString * subStr = marr[i];
        if ([subStr hasPrefix:@"/var"] || [subStr hasPrefix:@" id="]) {
            [marr removeObject:subStr];
            i --;
        }
    }
    NSString * newStr = [marr componentsJoinedByString:@"\""];
    return newStr;
}

- (IBAction)addImage:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *imageName = [NSString stringWithFormat:@"ios%@.png", [self stringDate]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:@"public.image"]) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    NSInteger userid = 000001;
    NSString *url = [NSString stringWithFormat:@"http://pic.baidu.com/images/%@/%@/%@",[NSString stringWithFormat:@"%ld",userid],[NSString stringWithFormat:@"%ld",(long)userid],imageName];
    NSString *script = [NSString stringWithFormat:@"window.insertImage('%@','%@')",url,imagePath];
    NSLog(@"script---%@",script);
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)stringDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

@end
