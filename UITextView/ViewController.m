//
//  ViewController.m
//  UITextView
//
//  Created by leergou on 16/7/15.
//  Copyright © 2016年 WhiteHouse. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITextViewDelegate>

/** textView */
@property (nonatomic, weak) UITextView *textView;

/** placeHoldLabel */
@property (nonatomic, weak) UILabel *placeHoldLabel;

/** noticeLabel */
@property (nonatomic, weak) UILabel *noticeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"分享到新浪微博" action:@selector(changeColor:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)]; //初始化大小并自动释放
    
    _textView = textView;
    
    textView.textColor = [UIColor blackColor];//设置字体颜色
    
    textView.font = [UIFont fontWithName:@"Arial" size:18.0];//设置 字体 和 大小
    
    textView.delegate = self;// 设置控制器为 textView 的代理方法
    
    textView.backgroundColor = [UIColor lightGrayColor];//设置它的背景颜色
    
    textView.returnKeyType = UIReturnKeyDefault;//返回键的类型
    
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    
    textView.scrollEnabled = YES;//是否可以拖动

    [self.view addSubview:textView];
    
    
    UILabel *placeHoldLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth, 25)];
    
    self.placeHoldLabel = placeHoldLabel;
    
    placeHoldLabel.font = [UIFont systemFontOfSize:18];
    
    placeHoldLabel.enabled = NO;
    
    placeHoldLabel.text = @"请输入您的内容...";
    
    placeHoldLabel.numberOfLines=0;
    
    placeHoldLabel.font =  [UIFont systemFontOfSize:12];

    [self.textView addSubview:placeHoldLabel];
    
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 280, kScreenWidth * 0.95, 20)];
    
    self.noticeLabel = noticeLabel;
    
    noticeLabel.textAlignment = NSTextAlignmentRight;
    
    noticeLabel.text = @"您还可以输入200字!";

    [self.view addSubview:noticeLabel];
}

#pragma mark - 3. 自定义选中按钮
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(changeColor:))
    {
        if(self.textView.selectedRange.length>0)
            return YES;
    }
    return NO;
}

- (void)changeColor:(BOOL)needChange{
    
    
}

#pragma mark - 2.textView delegate
-(void)textViewDidChange:(UITextView *)textView
{
    if ([self.textView.text length] == 0) {
        [self.placeHoldLabel setHidden:NO];
    }else{
        [self.placeHoldLabel setHidden:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    if (range.location>=200){
        
        self.noticeLabel.text=@"还能输入0字";
        return  NO;
    } else {
        
        self.noticeLabel.text=[NSString stringWithFormat:@"还能输入%lu字",200-range.location];
        return YES;
    }
}



@end
