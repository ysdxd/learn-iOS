//
//  ViewController.m
//  CALayer新建图层
//
//  Created by Gavin on 15/7/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.说明
        以前图层都是系统帮我们的创建的,其实我们可以自己新建一个图层
    2.新建图层
        图层是CALayer类型,它是属于CoreAnimation框架
        CALayer,就相当于我们控件里面的UIView
        CALayer是所有图层的父层,它里面还有很多子层.像UIView一样, 也有很多图层继承CALayer
        
        它像UIView一样, 想要让它显示,必须要设置它的Frame,颜色,并把它添加到一个图层上面.
         CALayer *layer = [CALayer layer];
         layer.frame = CGRectMake(50, 50, 100, 100);
         layer.backgroundColor = [UIColor redColor].CGColor;
         [self.view.layer addSublayer:layer];
 
    3.在Layer上面显示图片
        显示图片是显示在Layer的内容层上面
        layer.contents = [UIImage imageNamed:@"阿狸头像"];
        运行发现在没有图片显示?为什么
        进入头文件发现, 它要传一个CGImageRef类型
        我在后面敲.CGImage,,不过有没有发现,又报错了.
        为什么?进入头文件,看是不是要求我们传入的是一个id类型,这是不是又给它一个CGImage,
        这个时候,可以给它强转一下, 弄一个假像,告诉编译器, 这个是一个id  这个强转是给编译器看的.
        再运行,发现就可以了.
 
    4.介绍PPT,为什么要用CGColor,什么时候用CALayer,什么时候用UIView
        
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.\
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    layer.contents = (id)[UIImage imageNamed:@"阿狸头像"].CGImage;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
