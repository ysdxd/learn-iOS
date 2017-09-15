//
//  ViewController.m
//  核心动画CABaseAnimation
//
//  Created by Gavin on 15/8/2.
//  Copyright © 2015年 Gavin. All rights reserved.
//

/*
    1.介绍核心动画的步骤
        1.第一步,一定要有图层,拖一个UIView进去.UIView默认有一个根层
        拿到这个View.给这个UIView人layer添加一些动画.
 
        2.假设一点击屏幕的时候就做一些动画
          比如说进行一个缩放
 
         CABasicAnimation *anim = [CABasicAnimation animation];
         直接这样写没有动画,动画的本质是干嘛?
         动画的本质是改图层的某一个属性.
         设置修改的属性.
         图层有那些属性,这里才能写那些属性. 我现在想做缩放,是不是改他的形变.
         anim.keyPath = @"transform.scale";
         设置修改的值,修改到哪
         anim.toValue = @0.5;
         缺什么,补什么
         [_redView.layer addAnimation:anim forKey:nil];
 
        运行后有动画,但是有还原了.怎么样让它不还原.
        设置一个取消反弹效果
        动画完成的时候不要移除
         告诉它动画完成的时候不要移除
         在动画完成是否需要移除,它默认会移除,是不是告诉他不要移除.
         anim.removedOnCompletion = NO;
         动画保存最新的效果
         最前面,也是最新的一个
         anim.fillMode = kCAFillModeForwards;
        这两行代码不要去记,像这样的代码,以后只要看一下就好了嘛.
 
 
        除了缩放还能把它给平移到某个位置
 
         anim.keyPath = @"position";
         这个地方是不是要来一个CGPoint的一个东西.它是一个结构体
         把这个结构体转成对象
         anim.toValue = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
     
        CABasicAnimation
        告诉我你要修改哪个属性.修改成什么值.

     
 */


#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}




-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    //直接这样写没有动画,动画的本质是干嘛?
    //动画的本质是改图层的某一个属性.
    //设置修改的属性.
    //图层有那些属性,这里才能写那些属性. 我现在想做缩放,是不是改他的形变.
//    anim.keyPath = @"transform.scale";
    
    anim.keyPath = @"position";
    //这个地方是不是要来一个CGPoint的一个东西.它是一个结构体
    //把这个结构体转成对象
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(400, 400)];
    
    //设置修改的值,修改到哪
//    anim.toValue = @0.5;
    
    //告诉它动画完成的时候不要移除
    //在动画完成是否需要移除,它默认会移除,是不是告诉他不要移除.
    anim.removedOnCompletion = NO;
    //动画保存最新的效果
    //最见面,也是最新的一个
    anim.fillMode = kCAFillModeForwards;
    
    //缺什么,补什么
    [_redView.layer addAnimation:anim forKey:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
