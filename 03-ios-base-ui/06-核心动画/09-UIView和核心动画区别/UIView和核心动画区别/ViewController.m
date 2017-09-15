//
//  ViewController.m
//  UIView和核心动画区别
//
//  Created by Gavin on 15/8/3.
//  Copyright © 2015年 Gavin. All rights reserved.
/*
    1.UIView与核心动画的区别
        1.核心动画作用在Layer,只能给layer添加动画.不能给UIView添加核心动画.
        2.核心动画一切都是假像.并不会改变真实的值.
 
    2.测试,拖一个UiView,UIView的宽高都是为100,100,把它的位置放到左上角.
      假设我一点屏幕让它到右下角的位置.
      在TouchBegain方法中写代码
 
     CABasicAnimation *anim = [CABasicAnimation animation];
     anim.keyPath = @"position";
     anim.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
     //取消反弹
     //动画完成的时候不要移除
     anim.removedOnCompletion = NO;
     //保持一个最新的动态
     anim.fillMode = kCAFillModeForwards;
     [self.redView.layer addAnimation:anim forKey:nil];
 
 
    现在已经能够完成动画的移动.
    那如果我想看一下它的位置到底有没有到底部.打印红色view的position;
    在动画完成的时候打印.
    现在要监听动画的完成.
    设置动画的代理.监听动画的完成.
     anim.delegate = self;
    设置完成之后,是不是没有警告,以前设置代理 是不是有警告, 是不是告诉你必须得要遵守某个协议吧.
    
    那这个时候,我们是不是可以猜一下
    代理方法, 核心动画完成的时候调用 .
     -(void)animationDidStop:(nonnull CAAnimation *)anim finished:(BOOL)flag{
     
     }
    我们进这个方法里面看一下, 看看它是不是一个协议, 进去后发现它是不一个协议吧, 它是NSobject的一个分类
    有些装逼的面试官,它把这个叫做非正式协议.就是不用遵守协议的一种方法.
 
    打印下红色视图的Position有没有改变
    NSLog(@"%@",NSStringFromCGPoint(_redView.layer.position));
    发现它的值还是 {61, 78},还是它原来的位置.
 
    在ViewDidLoad方法中再打印一下.运行发现两值是一样的.
 
    结论, 核心动画一切都是假像.并不会改变真实的值.
 
     [UIView animateWithDuration:0.25 animations:^{
        self.redView.center = CGPointMake(250, 500);
     }];
    改变的是真实值
 
    3.什么时候用核心动画, 什么时候用UIView
        如果需要与用户交互,就使用UIView动画
        原因,如果用核心动画,点按钮不会有反应.因为按钮的值还在原始位置.
        不需要与用户交互的时候,可以使用核心动画.
    4.什么场景使用核心动画最多?
        转场动画.
        1.在转场动画中, 核心动画的类型比较多.
        2.根据一个路径做动画,只能用核心动画.(帧动画)
        3.动画组的时候.
 
 
 
 
 */




#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      NSLog(@"%@",NSStringFromCGPoint(_redView.layer.position));
}

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.redView.center = CGPointMake(250, 500);
    }];
    

}



- (void)layerAnimation{
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"position";
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
    //取消反弹
    //动画完成的时候不要移除
    anim.removedOnCompletion = NO;
    //保持一个最新的动态
    anim.fillMode = kCAFillModeForwards;
    //设置动画的代理.监听动画的完成.
    anim.delegate = self;
    
    [self.redView.layer addAnimation:anim forKey:nil];

}


-(void)animationDidStop:(nonnull CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"%s",__func__);
    
    //打印下红色视图的Position有没有改变
    NSLog(@"%@",NSStringFromCGPoint(_redView.layer.position));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
