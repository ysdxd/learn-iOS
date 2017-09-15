//
//  YellowView.m
//  04-hitTest练习(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "YellowView.h"

@interface YellowView ()


@property (nonatomic, weak) IBOutlet UIButton *btn;


@end

@implementation YellowView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"%s",__func__);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint btnP = [self convertPoint:point toView:_btn];

    // 判断下当前点在不在按钮，如果在按钮上，返回按钮
    if ([_btn pointInside:btnP withEvent:event]) { // 点在按钮上
        return NO;
    }else{
        return [super pointInside:point withEvent:event];
    }
    
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    
//    CGPoint btnP = [self convertPoint:point toView:_btn];
//    
//    // 判断下当前点在不在按钮，如果在按钮上，返回按钮
//    if ([_btn pointInside:btnP withEvent:event]) { // 点在按钮上
//        return _btn;
//    }else{
//        return [super hitTest:point withEvent:event];
//    }
//    
//    
//    
//    
//}

@end
