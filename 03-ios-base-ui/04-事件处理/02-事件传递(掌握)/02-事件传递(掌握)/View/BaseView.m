//
//  BaseView.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

// __func__获取当前方法在哪个类里面调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@--touchesBegan",[self class]);
}

@end
