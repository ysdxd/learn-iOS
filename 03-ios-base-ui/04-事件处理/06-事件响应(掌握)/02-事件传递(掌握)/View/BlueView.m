//
//  BlueView.m
//  02-事件传递(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    
    // 把事件传递给上一个响应者
    [super touchesBegan:touches withEvent:event];
}
@end
