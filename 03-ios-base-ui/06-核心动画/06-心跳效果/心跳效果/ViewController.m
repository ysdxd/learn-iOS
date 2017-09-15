//
//  ViewController.m
//  心跳效果
//
//  Created by Gavin on 15/8/2.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.回顾CABaseAnimation
        它可以做两个值之间的动画.
        那现在利用它一个心跳的效果.
        心跳效果是什么样的, 是不是一下缩小,双还原的效果.
 
    2.导入素材,搭建界面.
      就是让这个图片绕着中心点缩放.它的缩放也是绕着锚点去缩放.
      假设特会我点击屏幕就让它有心跳的感觉.
      拖线.
    3.在一点击屏幕的时候就让它创建一个核心动画.

     CABasicAnimation *anim =[CABasicAnimation  animation];
     想让哪一个图层做动画,就添加到哪一个图层上面.
     anim.keyPath = @"transform.scale";
     anim.toValue = @0;
     [self.heartView.layer addAnimation:anim forKey:nil];
    
    运行发现, 一点它会缩放一下, 是不是想让它还原,那怎么做.
    想让它一直跳一直跳.  
     
    可以设置一下动画的执行次数.
    anim.repeatCount = MAXFLOAT;
    
    运行一下看一下效果.
    是不是有心跳的效果了, 只不过跳的非常快嘛.
    它默认是绕着哪个点缩放的.是不是锚点缩放啊.
 
    这样是不是执行的非常快, 我一点它马上就还原了.
    可以设置一个动画的时长.
    anim.duration = 1;
 
    运行后是不是跳的变慢了啊, 那还有一个问题哦, 是不是一下子就闪过来了啊
    是不是回的太快了吧.如果想让它慢慢的回.我们有一个属性.
 
     anim.autoreverses = YES;
 
 
 */

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    CABasicAnimation *anim =[CABasicAnimation  animation];
    //想让哪一个图层做动画,就添加到哪一个图层上面.
    anim.keyPath = @"transform.scale";
    anim.toValue = @0;
    
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.25;
    //反转
    anim.autoreverses = YES;
    [self.heartView.layer addAnimation:anim forKey:nil];
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
