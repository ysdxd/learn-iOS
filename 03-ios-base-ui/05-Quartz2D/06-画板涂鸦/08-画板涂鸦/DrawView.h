//
//  DrawView.h
//  08-画板涂鸦
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

//清屏
- (void)clear;
//撤销
- (void)undo;
//橡皮擦
- (void)erase;
//选择颜色
- (void)choseColor:(UIColor *)colore;
//设置线的宽度
- (void)setLineWidth:(CGFloat)width;


@property (nonatomic, strong) UIImage *image;



@end
