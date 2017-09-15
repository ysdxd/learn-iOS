//
//  UIImage+image.h
//  01-带有边框的圆形图片裁剪
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)


+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)borderColor image:(UIImage *)image;

@end
