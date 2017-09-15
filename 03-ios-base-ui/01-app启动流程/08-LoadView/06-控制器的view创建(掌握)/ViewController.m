//
//  ViewController.m
//  06-控制器的view创建(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 作用：加载控制器的view

// 什么时候调用，第一次使用控制器的View的时候

// 什么时候需要重写loadView: 自定义控制器的View就调用这个方法
// 控制器的View想展示一张图片
// UIWebView
//- (void)loadView
//{
//   UIView *vcView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    vcView.backgroundColor = [UIColor yellowColor];
//    
//    self.view = vcView;
//}

//- (UIView *)view
//{
//    if (_view == nil) {
//        [self loadView];
//    }
//    return _view;
//}

// 注意：一旦重写了loadView，就不要调用[super loadView]
//- (void)loadView
//{
//    // 调用父类（UIViewController）
//    // 调用系统默认的做法
//    [super loadView];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
