//
//  RedView.m
//  01-UIView的拖拽(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "RedView.h"

@implementation RedView

/*
 1.处理一个控件的触摸事件步骤
 1.1 自定义View
 1.2 重写touches方法
 
 
 */

// NSSet:集合，无序
// 当手指触摸当前控件的时候调用
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    
//    NSLog(@"%d",touches.count);
//    // 随机取一个
//    UITouch *touch = [touches anyObject];
//    
//    // 获取当前点
//   CGPoint curP = [touch locationInView:self];
//    
//     NSLog(@"%@",NSStringFromCGPoint(curP));
    NSLog(@"%s",__func__);
}

// 当手指在当前控件移动的时候调用
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    // 获取UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    
    // 获取上一次点
    CGPoint preP = [touch previousLocationInView:self];
    
    // 获取x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取y轴偏移量
    CGFloat offsetY = curP.y - preP.y;
    
    // 修改当前控件的位置
    // 修改形变
    // CGAffineTransformMakeTranslation:相对于最开始的位置，使用Make，会把之前的所有形变清空，从零开始形变
    // 相对于上一次的形变
    
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    
    NSLog(@"%s",__func__);
}

// 当手指抬起的时候调用
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}

// 当触摸事件被打断的时候调用，比如打电话
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
