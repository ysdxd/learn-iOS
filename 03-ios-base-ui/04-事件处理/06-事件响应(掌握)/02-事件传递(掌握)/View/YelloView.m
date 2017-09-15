//
//  YelloView.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "YelloView.h"

@implementation YelloView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    // 系统默认：把事件向上传递，自己不处理
    // 把事件传递给上一个响应者（）,谁是黄色view的上一个响应者
    // 黄色的上一个响应者是蓝色，上一个响应者可能是父控件
    // super 不是父控件
    [super touchesBegan:touches withEvent:event];
}

@end
