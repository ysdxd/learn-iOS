//
//  VCView.m
//  06-手势解锁
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "VCView.h"

@implementation VCView


-(void)drawRect:(CGRect)rect{

    //加载图片
   UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    //把图片给绘制View
    [image drawAtPoint:CGPointZero];
    
    
}


@end
