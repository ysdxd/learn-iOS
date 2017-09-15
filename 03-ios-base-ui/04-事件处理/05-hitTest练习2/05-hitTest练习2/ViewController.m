//
//  ViewController.m
//  05-hitTest练习2
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "PopButton.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)btnClick:(PopButton *)sender {
    
    // 弹出对话框，UIButton
    UIButton *chatView = [UIButton buttonWithType:UIButtonTypeCustom];
    chatView.bounds = CGRectMake(0, 0, 200, 200);
    chatView.center = CGPointMake(100, -100);
    
    // 子控件是可以超出父控件的位置，而且可以显示
    [chatView setBackgroundImage:[UIImage imageNamed:@"对话框"] forState:UIControlStateNormal];
    
    [chatView setBackgroundImage:[UIImage imageNamed:@"小孩"] forState:UIControlStateHighlighted];
    
    sender.chatView = chatView;
    
    [sender addSubview:chatView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
