//
//  ViewController.m
//  09-控制器的view延迟加载(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//- (UIView *)view
//{
//    if (_view == nil) {
//        [self loadView];
//        [self viewDidLoad];
//    }
//    return _view;
//}
- (void)loadView
{
    // 如果当前控制器是窗口的根控制器，可以不设置尺寸。
    UIView *greenView = [[UIView alloc] init];
    
    greenView.backgroundColor = [UIColor greenColor];
    
    self.view = greenView;
}

// 控制器的View加载完成的时候调用
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 以后打印控制器的View真实尺寸，一般不再viewDidLoad去打印，因为不准确
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
