//
//  ThreeViewController.m
//  10-导航控制器的基本使用(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController
// 回到上一个控制器
- (IBAction)backPre:(id)sender {
    
    // 跳转到上一个界面
    // 调用popViewControllerAnimated，并不会马上销毁对象，等跳转动画完成的时候才会销毁控制器对象
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 回到根控制器
- (IBAction)backRoot:(id)sender {
    
    // viewControllers保存导航控制器的所有子控制器
//    self.navigationController.viewControllers;
//    NSLog(@"%@",self.navigationController.viewControllers);
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)dealloc
{
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
