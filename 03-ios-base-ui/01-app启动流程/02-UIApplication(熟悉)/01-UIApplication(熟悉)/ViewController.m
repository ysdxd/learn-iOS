//
//  ViewController.m
//  01-UIApplication(熟悉)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 在iOS7之后，状态栏默认交给控制器处理
   
}

// 通过控制器隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

//  1.设置提醒数字，可以设置联网状态
- (void)setUp
{
    //   UIApplication *app =  [[UIApplication alloc] init];
    
    //    UIApplication *app1 =  [[UIApplication alloc] init];
    // UIApplication在程序启动的时候，由系统帮我们创建
    UIApplication *app =  [UIApplication sharedApplication];
    
    //   UIApplication *app1 =  [UIApplication sharedApplication];
    //    NSLog(@"%p--%p",app,app1);
    
    // 1.设置提醒数字，可以设置联网状态，可以设置状态栏,可以打电话，发短信，打开网页。
    
    // -[UIApplication registerUserNotificationSettings:]
    // 设置提醒数字
    app.applicationIconBadgeNumber = 10;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    // 注册一个用户的通知
    [app registerUserNotificationSettings:settings];
    
    // 设置联网状态
    [app setNetworkActivityIndicatorVisible:YES];
    

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 设置状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
     UIApplication *app =  [UIApplication sharedApplication];
    // 打开网页
    // URL:资源路径
    // URL组成: 协议头/路径 http:// file:// tel://
    //  根据url的协议头判断用什么软件
    // http://www.baidu.com
//    [app openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
