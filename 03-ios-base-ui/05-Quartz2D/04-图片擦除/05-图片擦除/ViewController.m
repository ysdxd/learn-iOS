//
//  ViewController.m
//  05-图片擦除
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pan:(UIPanGestureRecognizer *)pan {
    
    
    //确定擦除的范围
    CGFloat rectWH = 30;
    
    //获取手指的当前点.curP
    CGPoint curP = [pan locationInView:pan.view];
    CGFloat x = curP.x - rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    CGRect rect = CGRectMake(x, y,rectWH, rectWH);
    
    //先把图片绘制到上下文.
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把上面一张图片绘制到上下文.
    [self.imageView.layer renderInContext:ctx];
    //再绘上下文当中图片进行擦除.
    CGContextClearRect(ctx, rect);
    //生成一张新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //再把新的图片给重新负值
    self.imageView.image = newImage;
    //关闭上下文.
    UIGraphicsEndImageContext();
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
