//
//  PopButton.m
//  05-hitTest练习2
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "PopButton.h"

@implementation PopButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
   CGPoint chatP = [self convertPoint:point toView:_chatView];
    
    // 判断下点在不在chatView
    if ([_chatView pointInside:chatP withEvent:event]) {
        return _chatView;
    }else{
        return [super hitTest:point withEvent:event];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // 获取UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:self];
    
    
    // x和y轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    
    // 修改它形变
    self.transform = CGAffineTransformTranslate(self.transform, offsetX , offsetY );
}

@end
