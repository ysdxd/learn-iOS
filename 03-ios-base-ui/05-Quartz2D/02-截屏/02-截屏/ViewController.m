//
//  ViewController.m
//  02-截屏
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{

    //生成一个跟屏幕大小一样大的图片.
    
    //1.开启一个图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    //获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.把控制器View的内容绘制上下文当中.
    //UIView上面的内容是不能够直接画.要渲染到上下文当中.
    [self.view.layer renderInContext:ctx];
    //3.从上下文当中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文.
    UIGraphicsEndImageContext();
    
    NSData *data =  UIImagePNGRepresentation(newImage);
   
    [data writeToFile:@"/Users/gaoxinqiang/Desktop/newImage.png" atomically:YES];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
