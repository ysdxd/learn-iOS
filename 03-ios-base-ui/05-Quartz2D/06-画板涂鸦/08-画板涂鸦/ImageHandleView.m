//
//  ImageHandleView.m
//  08-画板涂鸦
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "ImageHandleView.h"

@interface ImageHandleView()<UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIImageView *imageV;


@end


@implementation ImageHandleView


-(UIImageView *)imageV{
    
    if(_imageV == nil){
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
        _imageV = imageView;
        imageView.userInteractionEnabled = YES;
        [self setUpGes:imageView];
    }
    return _imageV;
  
}


-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageV.image = image;
    
}





// 添加UIImageView所有的手势
- (void)setUpGes:(UIImageView *)imageV
{
    // pan
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(pan:)];
    
    [imageV addGestureRecognizer:pan];
    
    // pinch
    // 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinch.delegate = self;
    [imageV addGestureRecognizer:pinch];
    
    
    //添加旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    
    [imageV addGestureRecognizer:rotation];
    
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imageV addGestureRecognizer:longPress];
}


//捏合的时候调用.
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    
    pinch.view.transform = CGAffineTransformScale( pinch.view.transform, pinch.scale, pinch.scale);
    // 复位
    pinch.scale = 1;
}


//旋转的时候调用
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    // 旋转图片
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    
    // 复位,只要想相对于上一次旋转就复位
    rotation.rotation = 0;
    
}


//长按的时候调用
// 什么时候调用:长按的时候调用,而且只要手指不离开,拖动的时候会一直调用,手指抬起的时候也会调用
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    //让图片闪一下之后, 绘制到画板上去.
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.25 animations:^{
            longPress.view.alpha = 0;
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                longPress.view.alpha = 1;
            }completion:^(BOOL finished) {
                //把UIimageView上的图片给绘制画板
                UIGraphicsBeginImageContextWithOptions(longPress.view.bounds.size, NO, 0);
                //获出当前的上下文
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                //开始生成一张图片.
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                
                //调用代理方法
                if ([self.delegate respondsToSelector:@selector(imageHandleView:image:)]) {
                    [self.delegate imageHandleView:self image:newImage];
                }
                
                //关闭上下文
                UIGraphicsEndImageContext();
                
                [self removeFromSuperview];
                
            }];
            
        }];
        
        
    }
    
    
}







//拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:pan.view];
    
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
}


//能够同时支持多个手势
-(BOOL)gestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}






@end
