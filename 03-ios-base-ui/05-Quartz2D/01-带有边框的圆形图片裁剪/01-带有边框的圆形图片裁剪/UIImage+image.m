//
//  UIImage+image.m
//  01-带有边框的圆形图片裁剪
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)



+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor image:(UIImage *)image {
    
    //    1.先开启一个图片上下文尺寸大小在原始图片基础上宽高都加上两倍边框宽度.
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //    2.填充一个圆形路径.这个圆形路径大小,和上下文尺寸大小一样.
    UIBezierPath *path = [UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //设置搭边的颜色
    [borderColor set];
    [path fill];
    
    //    3.添加一个小圆,小圆,x,y从边框宽度位置开始添加,宽高和原始图片一样大小.把小圆设为裁剪区域.
    
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.width)];
    //把小圆设为裁剪区域
    [path addClip];
    
    //    4.把图片给绘制上去.
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    //5.从上下文当中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
    
}




@end
