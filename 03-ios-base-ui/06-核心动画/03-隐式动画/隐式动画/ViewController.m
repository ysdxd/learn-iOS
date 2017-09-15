//
//  ViewController.m
//  隐式动画
//
//  Created by Gavin on 15/7/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.演示PPT
        说明只有非根层才有隐式动画
        所以要自己手动创建
    2.创建CALayer
      2.1演示Position和某点
 
         CALayer *layer = [CALayer layer];
         layer.backgroundColor = [UIColor redColor].CGColor;
         默认在(0,0)位置,如果不写也是在(0,0)位置
         layer.position = CGPointZero;
         layer.bounds = CGRectMake(0, 0, 100, 100);
         [self.view.layer addSublayer:layer];
        运行结果:只能看到一半,为什么只能看到一半.
           原因: 锚点的位置默认在中间(0.5,0.5);
           PPT演示
           想要看到全部,修改layer的anchorPoint (0,0)
           layer.anchorPoint = CGPointMake(0, 0);
 
      2.2 Layer中的Position就是UIView的中的Center
          验证:
          把之前的东西都注释掉, 添加一个UIView
 
         UIView *redView = [[UIView alloc] init];
         redView.backgroundColor = [UIColor redColor];
         //center默认点在(0,0)
         redView.bounds = CGRectMake(0, 0, 100, 100);
         //如果想要修改它的位置
         redView.layer.anchorPoint = CGPointMake(0, 0);
         redView.center = CGPointMake(100, 100);
         [self.view addSubview:redView];
    
    3. 隐式动画
        3.1 点击屏幕的时候,来更Layer的属性, 首先第一步,要拿到上面的这个图层,所以要它先成为成员属性
            只要一个属性有Animatable属性,它就会有隐式动画,(进入头文件查找)
            隐式动画,修改Bounds
            _layer.bounds = CGRectMake(0, 0, 20, 20);
        
       3.2 验证只有非根层才有隐式动画
            让RedView成为成员属性,
            修改RedView的bounds
            只有非根层才有隐式动画,所谓根层, 就是系统帮你创建的层
            _RedView.bounds =  CGRectMake(0, 0, 20, 20);
 
      3.3 演示Layer其它隐式动画
            _layer.position = CGPointMake(100, 100);
            _layer.cornerRadius = 10;
            _layer.borderColor = [UIColor blueColor].CGColor;
            _layer.borderWidth = 5;
 
    4.搞一些随机的效果
        
         _layer.position = CGPointMake(arc4random_uniform(300), arc4random_uniform(400));
         _layer.cornerRadius = arc4random_uniform(50);
         _layer.borderColor = [self randomColor].CGColor;
         _layer.borderWidth = arc4random_uniform(15);
 
    5.关闭隐式动画
        
        想要关闭隐式动画,首先要了解核心动画的原理
        任何动画,它都会封装到一个事务里面.学数据库都应该了解事务的吧.
        什么叫事务, 把很多操作绑定在一起, 必须这些操作中的每一项全部完成,它才能做一些事件.
        就是说,你一个动画全部执行完之后,它才能执行一些事件.
    
        动画的底层都是包装到一个事务里面.
 
         开启一个事务
         [CATransaction begin];
         不需要隐式动画
         [CATransaction setDisableActions:YES];
         _layer.position = CGPointMake(arc4random_uniform(300), arc4random_uniform(400));
         _layer.cornerRadius = arc4random_uniform(50);
         _layer.borderColor = [self randomColor].CGColor;
         _layer.borderWidth = arc4random_uniform(15);
         [CATransaction commit];
 
         把所有的东西全部包装在一直事务里面.让这个事务不需要隐式动画,整体都没有动画
            
        还可以设置隐式动画执行的时长
        [CATransaction  setAnimationDuration:3.0];
 
    6.总结:
        1.只有非根层才有隐式动画
        2.只要一个属性有Animatable属性,它就会有隐式动画
 
 
 */

#import "ViewController.h"

@interface ViewController ()


@property(nonatomic,weak) CALayer *layer;
@property(nonatomic,weak) UIView *RedView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    //默认在(0,0)位置,如果不写也是在(0,0)位置
    layer.position = CGPointZero;
    layer.anchorPoint = CGPointMake(0, 0);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:layer];
    _layer = layer;
    
//    UIView *redView = [[UIView alloc] init];
//    redView.backgroundColor = [UIColor redColor];
//    //center默认点在(0,0)
//    redView.bounds = CGRectMake(0, 0, 100, 100);
//    //如果想要修改它的位置
//    redView.layer.anchorPoint = CGPointMake(0, 0);
//    redView.center = CGPointMake(100, 100);
//    [self.view addSubview:redView];
//    _RedView = redView;
    
}


- (UIColor *)randomColor{

    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{

    //隐式动画
//    _layer.bounds = CGRectMake(0, 0, 20, 20);
    
    //只有非根层才有隐式动画
//    _RedView.bounds =  CGRectMake(0, 0, 20, 20);
    
    //开启一个事务
    [CATransaction begin];
    //不需要隐式动画
//    [CATransaction setDisableActions:YES];
    [CATransaction  setAnimationDuration:3.0];
    _layer.position = CGPointMake(arc4random_uniform(300), arc4random_uniform(400));
    
    _layer.cornerRadius = arc4random_uniform(50);
    _layer.borderColor = [self randomColor].CGColor;
    _layer.borderWidth = arc4random_uniform(15);
    [CATransaction commit];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
