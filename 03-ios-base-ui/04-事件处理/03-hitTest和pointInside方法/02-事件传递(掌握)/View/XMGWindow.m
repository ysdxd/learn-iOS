//
//  XMGWindow.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGWindow.h"

@implementation XMGWindow

// 作用：寻找最合适的view
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//    
//    // 返回肯定是最合适view
//    UIView *fitView = [super hitTest:point withEvent:event];
//    
//    NSLog(@"%@",fitView);
//    
//    return  fitView;
//    
//}

// point:是方法调用者坐标系上的触摸点的位置
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.判断下能否接收触摸事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.0) return nil;
    
    // 2.判断下点在不在控件上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    
    // 3.从后往前遍历子控件
    int count = (int)self.subviews.count;
    
    for (int i = count - 1; i >= 0 ; i--) {
        // 取出显示在最前面的子控件
        UIView *childView =  self.subviews[i];
        
        // 转换成子控件坐标系上点
        CGPoint childP = [self convertPoint:point toView:childView];
        
        UIView *fitView = [childView hitTest:childP withEvent:event];
        
        if (fitView) {
            return fitView;
        }
        
    }
    
    // 表示没有比自己更合适的view
    return self;
    
}


@end
