//
//  ViewController.m
//  10-导航控制器的基本使用(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController
// 如果一个控制器是导航控制器的子控制器，就可以拿到导航控制器
- (IBAction)jump2Two:(id)sender {
    
    TwoViewController *twoVC = [[TwoViewController alloc] init];
    
    [self.navigationController pushViewController:twoVC animated:YES];
    NSLog(@"%@",self.navigationController);
    
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
