//
//  AppDelegate.m
//  02-UIApplicationDelegate(熟悉)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#warning AppDelegate没有自己创建，系统会默认帮我们创建。

// 处理应用程序的一些生命周期方法
// 内存警告

// 程序启动完成的时候调用
// __func__：表示当前的方法在哪个类里面调用
// -[AppDelegate application:didFinishLaunchingWithOptions:]
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%s",__func__);
    // Override point for customization after application launch.
    return YES;
}

// 当应用程序失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
        NSLog(@"%s",__func__);
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 当应用程序进入后台的时候调用
// 保存一些数据
- (void)applicationDidEnterBackground:(UIApplication *)application {
        NSLog(@"%s",__func__);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// 当应用程序进入进台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
        NSLog(@"%s",__func__);
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// 当应用程序获取焦点的时候调用
// 当用户完全获取焦点的时候，才能跟界面交互
- (void)applicationDidBecomeActive:(UIApplication *)application {
        NSLog(@"%s",__func__);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 当应用程序关闭的时候调用
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 当程序接收到内存警告的时候调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清空图片缓存
    NSLog(@"%s",__func__);
}

@end
