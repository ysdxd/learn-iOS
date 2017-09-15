//
//  ViewController.m
//  倒影
//
//  Created by Gavin on 15/7/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.演示界面,分析界面
        将一张图片绕着X轴旋转180度
        两个是一模一样的,可以用复制层
        图片加到控制器上面, 让控制器成为复制层
 
    2. 搭建界面, 拖入图片
       复制控制器的View里面的子层, 因此控制器的View它的层必须要是复制层.
       打印出控制器的层,是CALayer,CALayer不是复制层, 不能复制.
       如何让控制器的View是一个复制层?
       想要修改系统的东西,必须得要自定义View
 
      2.1在自定义的View中修改根层的类型
 
         修改这个View的图层类型为复制层
         返回的就是这个View根层的类型
         + (nonnull Class)layerClass{
            return [CAReplicatorLayer class];
         }
     2.2 在ViewDidLoad中添加复制层
 
         CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;
         repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
         repL.instanceCount = 2;
        运行发现中间有一个间隙
        原因:它是绕着父层的锚点旋转,
        验证:在StroyBoard中,把图片拖到View的中间,运行,看到两个图片正好重合
        解决办法:在StoryBoard中,用约束让它水平,垂直剧中,两个正好重合
                想要让它有倒影效果, 让它往上移动一段距离, 往上面移一半的高度
 
    3.让底部图片有倒影效果
        
        更改颜色通道
        每一个颜色通道减等于0.1
 
         更改每一个颜色通道
         repL.instanceRedOffset -= 0.1;
         repL.instanceBlueOffset -= 0.1;
         repL.instanceGreenOffset -= 0.1;
         repL.instanceAlphaOffset -= 0.1;
 */


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //复制控制器的View里面的子层, 因此控制器的View它的层必须要是复制层
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;
    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    repL.instanceCount = 2;
    //更改每一个颜色通道
    repL.instanceRedOffset -= 0.1;
    repL.instanceBlueOffset -= 0.1;
    repL.instanceGreenOffset -= 0.1;
    repL.instanceAlphaOffset -= 0.1;
    
    

    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
