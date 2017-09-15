//
//  ViewController.m
//  03-图片截屏
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//


/*
 1.加载一张图片.
 2.添加手势.(拖动手势)
 3.手指移动的时候,添加一个UIView.(UIView的位置 ,尺寸)
 4.手指松开的时候,把超过UIView尺寸以外的东西都给裁剪掉.
 */
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic,assign) CGPoint beginP;
@property (nonatomic,weak) UIView *coverView;

@end

@implementation ViewController

-(UIView *)coverView{
    
    if (_coverView == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.6;
        [self.view addSubview:coverView];
        _coverView = coverView;
    }
    return _coverView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    
     UIImageView *panImageV =  (UIImageView *)pan.view;
    
      CGPoint curP = [pan locationInView:panImageV];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        //起始点
        self.beginP = curP;
    }else if (pan.state == UIGestureRecognizerStateChanged){
        //添加一个UIView.
        
        CGFloat offSetX = curP.x - self.beginP.x;
        CGFloat offsetY = curP.y - self.beginP.y;
        CGRect rect = CGRectMake(self.beginP.x, self.beginP.y, offSetX, offsetY);
        
        self.coverView.frame = rect;
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
        
        //开启图片上下文.
        UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, YES);
        
        //把超过UIView尺寸以外的东西都给裁剪掉.
        //要设置一个裁剪
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        //添加成为裁剪区域
        [path addClip];
        
        //取得当前的上下文.
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        //把原来的图片绘制到上下文.
        [self.imageV.layer renderInContext:ctx];
        
        //生成一张图片.
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //把生成的一张图片再imageView重新赋值
        self.imageV.image = newImage;
        //关闭上下文.
        UIGraphicsEndImageContext();
        
        //移除遮盖
        [self.coverView removeFromSuperview];
        
        
    }
    
    
  
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
