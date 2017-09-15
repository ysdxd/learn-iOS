//
//  AppDelegate.m
//  03-UIWindow(掌握)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *window1;
//@property (nonatomic, strong) UITextField *textField;

@end

@implementation AppDelegate

// 1.创建窗口
// 2.加载Main.storyboard，并且创建storyboard描述的控制器
// 3.把storyboard描述的控制器作为窗口的根控制器
// 4.显示窗口

//注意：窗口要显示出来必须的步骤 1.强引用窗口 2.设置窗口的尺寸
// 在程序启动完成的时候，仅仅只是帮你创建好窗口，并不会马上显示。
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSLog(@"%@",self.window);
    NSLog(@"%@",application.keyWindow);
    
    return YES;
}
- (void)windowLevel
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    self.window.alpha = 0.6;
    // 设置窗口的层级 UIWindowLevelAlert UIWindowLevelNormal UIWindowLevelStatusBar
    // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    //    self.window.windowLevel = UIWindowLevelStatusBar + 1;
    
    NSLog(@"%f",UIWindowLevelAlert);
    self.window.backgroundColor = [UIColor yellowColor];
    
    // 状态栏是一个窗口，键盘也是一个窗口
    // application.windows:可以利用这个属性，学习下当前API哪些控件是窗口
    
    
    // 弹出键盘,UITextField就是用来弹出键盘，不需要展示
    // 注意，如果想通过textField弹出键盘，必须要把textField添加到某个控件上
    //    UITextField *textField = [[UITextField alloc] init];
    //    [textField becomeFirstResponder];
    //    [self.window addSubview:textField];
    
    // 让窗口显示,让窗口成为我们应用程序的主窗口
    [self.window makeKeyAndVisible];
    // 1.让窗口成为应用程序的主窗口 2.设置窗口不要给隐藏
    //    1. application.keyWindow = self.window
    //    2. self.window.hidden = NO;
    
    // 创建第二个窗口
    self.window1 = [[UIWindow alloc] initWithFrame:CGRectMake(50, 400, 300, 300)];
    
    self.window1.backgroundColor = [UIColor redColor];
    
    self.window1.windowLevel = UIWindowLevelStatusBar;
    NSLog(@"%f",self.window1.windowLevel);
    
    self.window1.hidden = NO;
    
    //    NSLog(@"%@",application.windows);

}

- (void)setWindow
{
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor redColor];
    
    // 2.创建窗口的根控制器
    UIViewController *rootVc = [[UIViewController alloc] init];
    rootVc.view.backgroundColor = [UIColor greenColor];
    
    //    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    addBtn.center = CGPointMake(200, 200);
    //    [rootVc.view addSubview:addBtn];
    //    [self.window addSubview:rootVc.view];
    
    // 把控制器作为窗口的跟控制器，就会把跟控制器的view自动添加到窗口
    // 设置了窗口的根控制器，有旋转的功能
    self.window.rootViewController = rootVc;
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
        NSLog(@"%@",application.keyWindow);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
