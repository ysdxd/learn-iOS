//
//  ViewController.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
// 当修改父控件的alpha，会影响子控件的alpha
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_imageView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
