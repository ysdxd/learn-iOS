//
//  ViewController.m
//  01-CALayer-基本使用(了解)
//
//  Created by Gavin on 15/7/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.介绍PPT
    2.新建工程,演示效果
        拖一个尺寸为100 * 100的View,拖线,拿到Layer
 
    3.代表演示图层常用属性,View的Layer
        3.1 阴影
        设置阴影不透明Opacity View的透明度 alpha
        _RedView.layer.shadowOpacity = 1;
        运行得出结论: 默认图层是有阴影的, 只不过,是透明的
        设置阴影的模糊程度
        _RedView.layer.shadowRadius  =10;
        设置阴影的颜色,把UIKit转换成CoreGraphics框架,用.CG开头
        _RedView.layer.shadowColor = [UIColor blueColor].CGColor;
        
        3.2 图层的圆角半径
        图层的圆角半径,圆角半径为宽度的一半, 就是一个圆
        _RedView.layer.cornerRadius = 50;
        
        3.3 设置图层边框
        设置边框必须得有颜色,和宽度
        //设置图层边框,在图层中使用CoreGraphics的CGColorRef
        _RedView.layer.borderColor = [UIColor whiteColor].CGColor;
        _RedView.layer.borderWidth = 2;
    
    4.UIImageView的Layer
        在StoryBoard中拖一个UIImageView, 设置尺寸100 * 100;拖线
 
        4.1设置图片的圆角半径
        _imageView.layer.cornerRadius = 50;
        运行发现没有效果
        原因:一个View都有一个根层,用Layer属性修改的都是根层的Layer,除了根层以外, 还有一个内容层
            UIImageView当中的Image是添加到内容层上面的.所以没有效果
 
        注意,图片不是加到子层上面,是添加到内容层上面,验证
                 NSLog(@"%@",_imageView.layer.sublayers); (null)
                 NSLog(@"%@",_imageView.layer.contents);  <CGImage 0x7fb439811510>
 
        解决办法:对图片做一次裁剪
 
                裁剪,超出裁剪区域的部分全部裁剪掉.
                默认的裁剪区域和根层是一样的.
 
                View的层中还有一个裁剪区域层 mask层,这个层专门用来做裁剪的.
                默认的区域和根层是一样的,根层多大, 它就是多大,它会用Mask层去裁剪图片,超出区域的,会裁剪掉
 
                简单理解:超出主导的部分都会被裁剪掉
                 _imageView.layer.masksToBounds = YES;
 
                虽然设置控件可以设置圆形头像,但是有条件,必须是正方形
         4.2 设置图形边框
            这里改的是控件,以前是生成的图片
            _imageView.layer.borderWidth = 1;
            _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
 
 
 
     5.利用图层做3D效果
        
        什么时候有3D效果?旋转的时候才有3D效果 做旋转,就是形变,UiView有形变,图层也有形变
        
        5.1 直接修改属性 x,y,z 分别代表x轴,y轴,Z轴旋转
        _imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
 
        5.2 利用KVC
        修改属性transform的值为CATransform3DMakeRotation(M_PI, 1, 0, 0)
        CATransform3DMakeRotation(M_PI, 1, 0, 0)为结构体类型
        Value要一个对象类型
        把结构体转换成对象
        NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
        [_imageView.layer setValue:value forKey:@"transform"];
 
        注意:Value的类型 必须得要跟属性的值的类型匹配.
 
 
        什么时候用KVC?
        做旋转的时候,最好不要使用KVC.
        做一些快速缩放的时候和一些二维的旋转
        比如:
        这样写它会快速的把宽高都给缩放成0.5,就不用再写很长的一串
        [_imageView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
        [_imageView.layer setValue:@M_PI forKeyPath:@"transform.rotation"];
 
 
*/



#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *RedView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
}

- (void)imageViewLayer{
    
    //设置图片的圆角半径
    _imageView.layer.cornerRadius = 50;
    //裁剪,超出裁剪区域的部分全部裁剪掉
    _imageView.layer.masksToBounds = YES;
    
    //设置图形边框
    _imageView.layer.borderWidth = 2;
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
}



- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    [UIView animateWithDuration:1 animations:^{
        
//        _imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        
        //利用KVC
        
        //修改属性transform的值为CATransform3DMakeRotation(M_PI, 1, 0, 0)
//        CATransform3DMakeRotation(M_PI, 1, 0, 0)为结构体类型
//        Value要一个对象类型
//        把结构体转换成对象
//
      NSValue *value = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
        [_imageView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
        
        
    }];
    
    
    
    
}







- (void)ViewLayer{
    //阴影
    //设置阴影不透明Opacity View的透明度 alpha
    //默认图层是有阴影的, 只不过,是透明的
    _RedView.layer.shadowOpacity = 1;
    //设置阴影的圆角
    _RedView.layer.shadowRadius  =10;
    //设置阴影的颜色,把UIKit转换成CoreGraphics框架,用.CG开头
    _RedView.layer.shadowColor = [UIColor blueColor].CGColor;
    
    //图层的圆角半径,圆角半径为宽度的一半, 就是一个圆
    _RedView.layer.cornerRadius = 50;
    
    //设置图层边框,在图层中使用CoreGraphics的CGColorRef
    _RedView.layer.borderColor = [UIColor whiteColor].CGColor;
    _RedView.layer.borderWidth = 2;
    
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
