//
//  ViewController.m
//  07-(图片抖动)-CAKeyFrameAnimation
//
//  Created by Gavin on 15/8/2.
//  Copyright © 2015年 Gavin. All rights reserved.
//

/*
    1.演示.当点击模拟器的时候,想要删除某一个应用.会有一个图标抖动效果.
        我一点,它就吓的发抖了.
    2.ppt演示, 图标左右摇摆.
        让它左边移一点, 往右边移一点
 
    3.搭建界面,弄一个图片,让图片发抖.
      点击屏幕, 就让图标发抖.
 
     //创建帧动画,多个值之间做动画 才需要用它.
     CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
     怎么样才能传动画,是不是改Layer某一个属性才能有动画吧
     设置修改的属性.
     CAKeyframeAnimation CABaseAnimaiton都是继承同一个父类.都是CAAnimation.所有他们都keyPath
     改旋转它才会发抖.二维的旋转
     anim.keyPath = @"transform.rotation";
     修改它的值.
     假设往左边转5度, 往右边转5度.
     要把角度 转换成弧度.
     CGFloat angle = (-5) / 180.0 * M_PI;
      转的是不是很长 所以要给它弄成珍上宏,
    #define angle2radio(angle) ((angle) / 180.0 * M_PI)
     数组里面要包装成对象
     anim.values = @[@(angle2radio(-5)),@(angle2radio(5))];
     执行次数
     anim.repeatCount = MAXFLOAT;
     [_imageView.layer addAnimation:anim forKey:nil];
 
    运行后发现是不是有抖动效果, 有点瘸的效果对不对, 那这是怎么回事呢?
    是因为从-5度到5度动画执行完毕之后, 它会突然回到-5度开始执行.
    解决办法:
    我们可以在动画执行参数里面多添加一条.
    让它从5度到-5度
    anim.values = @[@(angle2radio(-5)),@(angle2radio(5)),@(angle2radio(-5))];
    运行就有就没有瘸的效果了.
    
    4.帧动画还可以根据一个路径去走.
     让动画随着路径去走. 让它随着路径去走, 一般是改它的位置,position
     anim.keyPath = @"position";
     anim.path = [UIBezierPath  bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)].CGPath;

 
    如果路径更复杂.可以添加拼接更多的路径
     UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
     [path addLineToPoint:CGPointMake(200, 500)];
     anim.path = path.CGPath;
 
 */



#import "ViewController.h"

//#define angle2Radi(angle) ((angel) / 180.0 * M_PI)

//#define angle2radion(angle) ((angle) / 180 * M_PI)


#define angle2radio(angle) ((angle) / 180.0 * M_PI)


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    //创建帧动画,多个值之间做动画 才需要用它.
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //怎么样才能传动画,是不是改Layer某一个属性才能有动画吧
    //设置修改的属性.
//    CAKeyframeAnimation CABaseAnimaiton都是继承同一个父类.都是CAAnimation.所有他们都keyPath
    //改旋转它才会发抖.二维的旋转
//    anim.keyPath = @"transform.rotation";
   
    //修改它的值.
    //假设往左边转5度, 往右边转5度.
    //要把角度 转换成弧度.
//    CGFloat angle = (-5) / 180.0 * M_PI;
    //数组里面要包装成对象
//    anim.values = @[@(angle2radio(-5)),@(angle2radio(5)),@(angle2radio(-5))];
    //让动画随着路径去走. 让它随着路径去走, 一般是改它的位置,position
    anim.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    [path addLineToPoint:CGPointMake(200, 500)];
    
//    anim.path = [UIBezierPath  bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)].CGPath;
    anim.path = path.CGPath;
    anim.duration = 2;

    anim.autoreverses = YES;
    //执行次数
    anim.repeatCount = MAXFLOAT;
    
    
    [_imageView.layer addAnimation:anim forKey:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
