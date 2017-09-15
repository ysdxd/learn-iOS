//
//  ViewController.m
//  06-控制器的view创建(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGViewController.h"

@interface XMGViewController ()

@end

@implementation XMGViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"%s",__func__);
    
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
// 只要没有重写loadView，系统就会自动判断有没有storyboard或者xib描述控制器的View,如果有就会去加载它们描述控制器的view
//- (void)loadView
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
