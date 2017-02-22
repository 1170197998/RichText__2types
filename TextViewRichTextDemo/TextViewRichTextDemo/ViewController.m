//
//  ViewController.m
//  TextViewRichTextDemo
//
//  Created by ShaoFeng on 2017/2/22.
//  Copyright © 2017年 ShaoFeng. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "EditorTextView.h"
#import "ShowViewController.h"
@interface ViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)EditorTextView *textView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray array];
    self.textView = [[EditorTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2)];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}

- (IBAction)push:(id)sender {
    ShowViewController *vc = [[ShowViewController alloc] init];
    vc.htmlString = [ViewController attriToStrWithAttri:self.textView.attributedText];
    [self.navigationController pushViewController:vc animated:YES];
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
    NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg", [self stringDate]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:@"public.image"])
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    
    NSInteger userid = 00001;
    NSString *url = [NSString stringWithFormat:@"http://pic.baidu.com/images/%@/%@/%@",[NSString stringWithFormat:@"%ld",userid],[NSString stringWithFormat:@"%ld",(long)userid],imageName];
    NSDictionary *dic = @{@"url":url,@"image":image,@"name":imageName};
    [self uploadImage:image];
    [self.imageArray addObject:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image
{
    [self.textView replaceRange:self.textView.selectedTextRange withText:@"\n"];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(0, 10, SCREEN_WIDTH / 2, (image.size.height / (image.size.width / SCREEN_WIDTH)) / 2);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [strM replaceCharactersInRange:self.textView.selectedRange withAttributedString:imageText];
    [strM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(self.textView.selectedRange.location, 1)];
    self.textView.attributedText = strM;
    self.textView.selectedRange = NSMakeRange(self.textView.selectedRange.location + 1,0);
}

- (NSString *)stringDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

- (IBAction)save:(id)sender {
    
    NSLog(@"富文本-----%@",self.textView.attributedText);
    NSLog(@"-----------");
    NSLog(@"html字符串-----%@",[ViewController attriToStrWithAttri:self.textView.attributedText]);
}

//富文本转html字符串
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri
{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length) documentAttributes:tempDic error:nil];
    return [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
}

//字符串转富文本
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr
{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

@end
