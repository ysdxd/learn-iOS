//
//  ViewController.m
//  折叠效果
////  Created by Gavin on 15/7/26.
//  Copyright © 2015年 Gavin. All rights reserved.
//

/*
   1.分析图片折叠效果
      要用两个ImageView,演示一下只用一个imageView旋转会有什么效果
        得出结论: 一个图片不能做旋转效果,会整个图片都会旋转,
        我们想要的效果只是图片上部分在旋转,下部分没有在旋转 所以要用两个ImageView
 
   2. 如何让UIImageView只显示上部分内容?
    
        操作图层:让图层只显示部分内容
         //contentsRect:要显示的范围
         //x,y,w,h取值范围 0 - 1
         _topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
 
   3. 确定它是绕着哪个点旋转,上部分内容?
        绕着它的底部旋转,要修改锚点,
        3.1 默认是绕着锚点旋转,锚点默认是在中点
        修改锚点带来的问题? 图片的位置发生了变化
        解决问题:怎么把两张图片快速的组合成一张图片
            画图说明:
            1.首先让上下两个图片重合,锚点都在中心点
            2.设置上部分的图片锚点在底部(0.5,1),图片上移
            3.设置下部分的图片锚点在顶部(0.5,0),图片下移
 
   4. 图片折叠功能分析
        分析,整个拖动的范围是一个图片
        给一个控件添加Pan手势,在pan手势中添加旋转
        拖动范围,是上下两个图片的范围,可以弄个假像,做一个透明的View,覆盖两个图片 dragView
 
   5.给dragView添加手势
        带参数: 手指拖动多少,根据手指拖动多少,计算图片旋转多少度
     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
     [_dragView addGestureRecognizer:pan];
 
   6.手指拖动的时候就会触发,绕着X轴旋转上部分内容
    
        从0拖到200的时候,刚好拖动180度,是有一个比例
        获取当前拖动了多少, 乘上一个比例,就知道你旋转了多少度
        6.1.获取手指偏移量,相对于最原始
        CGPoint transP = [pan translationInView:_dragView];
        6.2.计算角度
            当我转200的时候,刚好是180度
            为什么200.0要加个点0,有可能除不了, 就一下等于0了
        CGFloat angle = transP.y * M_PI / 200.0;
        6.3. 绕着X轴旋转
            但是会发现一个问题,拖到下面的时候,就看不见了.为什么?
                原因:上面的View给底部的View挡住啦
                解决办法:让上部View最后添加
            还是有问题,还是看不见? 为什么?
                原因:往外是逆时,往内是顺时针
                解决办法: 将TransForm.y取返  CGFloat angle = -transP.y * M_PI / 200.0;
 
        _topView.layer.transform = CATransform3DMakeRotation(angle, 1, 0, 0);
        
        6.4 添加立体感,返大远小
            1.先弄一个空的TransFrom3D:
            CATransform3D transform = CATransform3DIdentity;
            2.设置 transform.m34 不要问我为什么, 我也是百度查的,你知道改m34有立体感就好了.
            200 与图片垂直距离,人的眼睛离手机的垂直距离
            transform.m34 = - 1 / 200.0;
            2.相对上一次改了m34的形变,再去旋转,返大, 选小,
                为什么不用Make,make会上m34清空,这个地方不能让m34清空
            transform = CATransform3DRotate(transform, angle, 1, 0, 0);
            3.修改transform的值
        
    7. 给下部分的View添加阴影效果,颜色渐变的效果,从无到黑色(透明到黑色的渐变)
             渐变层知识点:
             阴影效果:可以使用渐变层
             CAGradientLayer *gradientL = [CAGradientLayer layer];
 
             设置颜色的渐变:由什么颜色渐变到什么颜色
             数组当中让我们必须要传对象,欺骗编译器,强转成id,告诉你我是一个对象, 但本身是一个cgColor
              gradientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
 
             设置渐变方向
             默认方向为上下渐变为:
             gradientL.startPoint = CGPointMake(0, 0);
             gradientL.endPoint = CGPointMake(0, 1);
             设置左右渐变
             gradientL.startPoint = CGPointMake(0, 0);
             gradientL.endPoint = CGPointMake(1, 0);
             
             颜色开始渐变到下一个颜色的位置
             gradientL.locations = @[@0.3,@0.7];
            
            代码实现, 在ViewDidLoad中实现
             给下部分的View添加阴影效果 颜色渐变效果(透明->黑色渐变)
             阴影效果:可以使用渐变层
             CAGradientLayer *gradientL = [CAGradientLayer layer];
             gradientL.frame = _bottomView.bounds;
             设置渐变颜色
             gradientL.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
             设置不透明度,表示不透明
             gradientL.opacity = 0;
             [_bottomView.layer addSublayer:gradientL];
 
 
    8.设置不透明度  
        正好拖动到200的时候,opacity特于1,
        CGFloat opacity = transP.y / 200.0;
        
        设置阴影,要拿到渐变层去设置,把渐变层设为成员属性
 
    9.手指抬起时, 还原效果,带有弹簧效果
 
     Damping:弹性系数,越小, 弹性系数越明显
     Velocity:初始速度
     [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        执行带有弹簧的动画
     
     } completion:^(BOOL finished) {
        动画完成时做的一些事件
     }];
 */




#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *topView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *dragView;
@property (weak, nonatomic) CAGradientLayer *gradientL;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //让UiImageView只显示上部分内容
    //contentsRect:要显示的范围
    //x,y,w,h取值范围 0 - 1
    _topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    
    //让下面ImageView显示下部分内容
    _bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    
    //设置上部分的锚点
    _topView.layer.anchorPoint = CGPointMake(0.5, 1);
    //设置下部分的某点
    _bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    
     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_dragView addGestureRecognizer:pan];
    
    //给下部分的View添加阴影效果 颜色渐变效果(透明->黑色渐变)
    //阴影效果:可以使用渐变层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = _bottomView.bounds;
    //设置渐变颜色
    gradientL.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    //设置不透明度,表示不透明
    gradientL.opacity = 0;
    _gradientL = gradientL;
    [_bottomView.layer addSublayer:gradientL];

}

//手指拖动的时候就会触发,旋转上部分内容
//从0拖到200的时候,刚好拖动180度,是有一个比例
- (void)pan:(UIPanGestureRecognizer *)pan{
    //获取手指便宜量
    CGPoint transP = [pan translationInView:_dragView];
    //计算角度,逆时针旋转,取返
    CGFloat angle = -transP.y * M_PI / 200.0;
    //绕着X轴旋转
    
    CATransform3D transform = CATransform3DIdentity;
    //200 与图片垂直距离
    transform.m34 = -1/ 500.0;
    //相对上一次修改的M34旋转
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    
//1.    _topView.layer.transform = CATransform3DMakeRotation(angle, 1, 0, 0);
    //旋转上部分内容
    _topView.layer.transform = transform;
    
    //设置阴影不透明度
    //正好拖动到200的时候,opacity特于1,
    CGFloat opacity = transP.y / 200.0;
    _gradientL.opacity = opacity;

    
    if(pan.state == UIGestureRecognizerStateEnded){
        _gradientL.opacity= 0;
        //Damping:弹性系数,越小, 弹性系数越明显
        //Velocity:初始速度
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            _topView.layer.transform = CATransform3DIdentity;

        } completion:^(BOOL finished) {
           
        }];
    }
    
    CGPoint tranP = [pan translationInView:_dragView];
    
    NSLog(@"%@",NSStringFromCGPoint(tranP));

}



- (void)gradient{
    
    //阴影效果:可以使用渐变层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    gradientL.frame = _bottomView.bounds;
    //设置颜色的渐变:由什么颜色渐变到什么颜色
    gradientL.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    
    //设置渐变方向
    gradientL.startPoint = CGPointMake(0, 0);
    gradientL.endPoint = CGPointMake(1, 0);
    
    //颜色开始渐变到下一个颜色的位置
    gradientL.locations = @[@0.3,@0.7];
    
    [_bottomView.layer addSublayer:gradientL];
}

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        _topView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    }];
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
