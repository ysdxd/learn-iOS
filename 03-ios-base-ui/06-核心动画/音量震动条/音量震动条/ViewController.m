//
//  ViewController.m
//  音量震动条
//
//  Created by Gavin on 15/7/26.
//  Copyright © 2015年 Gavin. All rights reserved.
//

/*
 
 1.演示界面
    分析,改它的缩放, 然后再还原
 
 2. 搭建界面
    宽度200,高度:200,拖线
    
 3.添加CALayer,振动条,设置尺寸,大小,
     CALayer *layer = [CALayer layer];
     设置背景色
     layer.backgroundColor = [UIColor redColor].CGColor;
     设置尺寸
     CGFloat barH  = 120;
     CGFloat barW = 30;
     CGFloat X = 0;
     CGFloat Y = _contentsView.bounds.size.height - barH;
     layer.frame = CGRectMake(X, Y, barW, barH);
     [_contentsView.layer addSublayer:layer];
 
 4.添加动画
    4.1添加高度缩小后,马上还原
        为什么选用核心动画?
        给图层做动画用核心动画,不需要与用户做交互.
 
    4.2采用哪一种核心动画?
 
        把它的缩放改成某个值就好了.选用CABasicAnimation
         CABasicAnimation *anim = [CABasicAnimation animation];
         动画时长
         anim.duration = 2;
         形变缩放动画
         anim.keyPath = @"transform.scale";
         改为0,让它缩小
         anim.toValue = @0;
         让动画一直执行
         anim.repeatCount = MAXFLOAT;
         反转回去
         anim.autoreverses = YES;
         [layer addAnimation:anim forKey:nil];
 
        运行发现:不是我们想要的上下进行缩放?它是绕着中心点去缩放?
          所以要设置锚点. 设置锚点就不能设置frame了, 要设置Position
 
         设置锚点
         layer.anchorPoint = CGPointMake(0, 1);
         设置position
         layer.position = CGPointMake(0, _contentsView.bounds.size.height);
          不能够再用frame,设置它的bounds
         layer.bounds = CGRectMake(0, 0, barW, barW);
         
        运行发现:是不是 x轴 和 Y轴一起缩放了
          不需要X轴缩放,所以更改动画的KeyPath
          anim.keyPath = @"transfrom.scale.y"
 
    5. 使用复制层
         复制层可以把它里面的所有子层给复制.
        
         添加复制层,首先先要让这个层显示出来.
         复制层必须加到一个层里面才能复制它的子层.
         不需要设置它的尺寸, 需要设置它的颜色.子层超过父层也能够显示,所以不用设置尺寸.
 
         CAReplicatorLayer *replicator = [CAReplicatorLayer  layer];
         将复制层添加到_contententView.layer
         [_contentsView.layer addSublayer:replicator];
 
         instanceCount:表示原来层中的所有子层复制的份数
         replicator.instanceCount = 2;

         在复制层中添加子层
         [replicator addSublayer:layer];
         
         运行发现没有两个,为什么?
         其实已经有两个了,两个的位置,尺寸都是一样的,所以看着只有一个.
         
         解决办法:让子层有偏移位置
         instanceTransform:复制出来的层,相对上一个子层的形变
         replicator.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
 
 
         现在复制出来的层,执行的动画,都一样, 怎么样才能有错乱的感觉?
 
         相对于上一个层的动画延时
         replicator.instanceDelay = 0.3;
 
         使用它,应该把原始层的颜色设置为白色
         replicator.instanceColor = [UIColor greenColor].CGColor;
 
 
 
 
 
 */





#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer  layer];
    //最好确定坐标系, 因为子层Lay的坐标系是根据父层决定的.
    replicator.frame = _contentsView.bounds;
    //将复制层添加到_contententView.layer
    
    //instanceCount:表示原来层中的所有子层 复制出来的总份数
    replicator.instanceCount = 4;
    //相对于上一个层的动画延时
    replicator.instanceDelay = 0.3;
    //instanceTransform:复制出来的层,相对上一个子层的形变
    replicator.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    //使用它,应该把原始层的颜色设置为白色
    replicator.instanceColor = [UIColor redColor].CGColor;
    
    [_contentsView.layer addSublayer:replicator];

    
    //创建音乐震动条
    CALayer *layer = [CALayer layer];
    //设置背景色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    //设置尺寸
    CGFloat barH  = 120;
    CGFloat barW = 30;
//    CGFloat X = 0;
//    CGFloat Y = _contentsView.bounds.size.height - barH;
    //设置锚点
    layer.anchorPoint = CGPointMake(0, 1);
    //设置position
    layer.position = CGPointMake(0, _contentsView.bounds.size.height);
//    layer.frame = CGRectMake(X, Y, barW, barH);
    layer.bounds = CGRectMake(0, 0, barW, barH);
//    [_contentsView.layer addSublayer:layer];
    //在复制层中添加子层
    [replicator addSublayer:layer];
    
    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    //动画时长
    anim.duration = 0.3;
    //形变缩放动画
//    anim.keyPath = @"transform.scale";
    anim.keyPath = @"transform.scale.y";
    //改为0,让它缩小
    anim.toValue = @0;
    //让动画一直执行
    anim.repeatCount = MAXFLOAT;
    //反转回去
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
