//
//  main.m
//  02-UIApplicationDelegate(熟悉)
//
//  Created by apple on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        // nil -> @"UIApplication"
        // principalClassName：只能传入UIApplication或者他的子类
        // delegateClassName：传入一个代理的类名字符串
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
        // NSStringFromClass:反射机制
        // 把类名的字符串转换成类名Class
//        NSClassFromString(<#NSString *aClassName#>)
        // 好处： 1.防止写错 2.有提示
        
    }
}

// main -> UIApplicationMain -> 通知代理程序启动完成

// UIApplicationMain底层实现
/*
 1.创建UIApplication对象
 2.创建UIApplication对象代理，设置为UIApplication对象的代理
 3.开启主运行循环，目的：保持程序一直运行
 4.加载info.plist文件，判断下是否指定了main
 
 // 表示程序启动完成，才会通知代理。
 
 */