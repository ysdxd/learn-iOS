//
//  WhiteView.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "WhiteView.h"

@implementation WhiteView
// hitTest作用：寻找最合适的view
//hitTest什么时候调用：只要控件一接收到事件，就会调用hitTest去寻找最合适的view


// 作用：判断下当前触摸点在不在方法调用者上
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return NO;
//}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    NSLog(@"%s",__func__);
//    return [super hitTest:point withEvent:event];
//}


@end
