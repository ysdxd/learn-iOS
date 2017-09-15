//
//  ViewController.m
//  时钟
//
//  Created by Gavin on 15/8/2.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.介绍时钟
        与系统时钟做对比,有一个背景图片,有一个时针,分针,秒针.
        是用CALayer绘制上去的,不需要与用户交互
    2.搭建界面
        导入素材,在界面上拖入一个UIImageView 进行托线
        添加秒针.
         CALayer *layer = [CALayer layer];
         layer.bounds = CGRectMake(0, 0, 1, 90);
         layer.backgroundColor = [UIColor blackColor].CGColor;
         [self.clockView.layer addSublayer:layer];
        做时钟之前要了解一个很重要人知识点
        默认一个图层,他是绕着什么点去旋转?
        PPT演示:
        画一个圆环.在上面添加一个秒针.这个秒针默认它是绕真中心点,也就是锚点旋转
        我们这个地方是要绕着最底部的中心进行旋转.
 
        让刚才添加的那个秒针进行一个旋转,看一下是不是,绕着锚点进行旋转.
        验证:是绕着锚点进行旋转的
 
        设置完锚点和Position
         layer.anchorPoint = CGPointMake(0.5, 1);
         layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
         
        运行后发现有问题
        是不是有了旋转了90,为什么?
        是不是因为上面做了一次旋转操作啊.
        现在不需要旋转,把它注释掉.
 
    3.让秒针进行旋转.
        1.让秒针旋转,是不是要看一下当前有多少秒?
        60秒转一圈360度
        360 除以60就是每一秒转多少度.
        最好抽出一个宏.
        是不是每秒6度.要把他转换成弧度.
        角度转弧度 6 / 180.0 * M_PI
    
        现在已经知道每秒转多少度,下面要获取下当前是多少秒
 
        2.获取当前的秒数
         创建日历类
         NSCalendar *calendar = [NSCalendar currentCalendar];
         把日历类转换成一个日期组件
         日期组件(年,月,日,时,分,秒)
         component:日期组件有哪些东西组成,他是一个枚举,里面有年月日时分秒
         fromDate:当前的日期
         NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond fromDate:[NSDate date]];
         我们的秒就是保存在日期组件里面,它里面提供了很多get方法.
         NSInteger second = cmp.second;
         
        拿到当前的秒数之后.计算出当前旋转的角度
        当前的秒数乘以每秒转多少度.
        second * perSecA
        计算出来的角度,要把它转换成弧度.
        
        3.让秒针旋转
         NSInteger second = cmp.second;
         秒针旋转多少度.
         CGFloat angel = angle2Rad(second * perSecA);
         旋转秒针
         layer.transform = CATransform3DMakeRotation(angel, 0, 0, 1);
         
        运行只旋转个一次.因为这个方法只能来一次
        想让他走,每隔一秒, 获取一下当前的秒数.
        可以给他添加一个定时器.
 
        4.创建定时器.
         创建一个定时器
         每个一秒,时长比较多,而且不是做绘图 直接用NSTime
         [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
 
         每个一秒就调用,旋转秒针
         - (void)timeChange{
         获取当前的秒数
         创建日历类
         NSCalendar *calendar = [NSCalendar currentCalendar];
         把日历类转换成一个日期组件
         日期组件(年,月,日,时,分,秒)
         component:日期组件有哪些东西组成,他是一个枚举,里面有年月日时分秒
         fromDate:当前的日期
         NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond fromDate:[NSDate date]];
         我们的秒就是保存在日期组件里面,它里面提供了很多get方法.
         NSInteger second = cmp.second;
         秒针旋转多少度.
         CGFloat angel = angle2Rad(second * perSecA);
         旋转秒针
         self.secondL.transform = CATransform3DMakeRotation(angel, 0, 0, 1);
         
         }
 
        运行发现他会一下只就调到某一个时间才开始旋转
        一开始的时候就要来到这个方法,获取当前的秒数把它定位好.
        要在添加定时器之后就调用一次timeChange方法.
 
        5.添加分针.
        快速拷贝一下,然后添加一个分针成员属性.
        修改宽度,修改颜色
        也得要让它旋转,
        要算出每分钟转多少度
        转60分钟刚好是一圈
        所以每一分钟也是转6度.
        
        获取当前多少分?
        同样是在日期组件里面获得
        里面有左移符号,右移符号.他就可以用一个并运算
        现在同时让他支持秒数和分 后面直接加上一个 |
         NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute fromDate:[NSDate date]];
 
        CGFloat minueteAngel = angle2Rad(minute * perMinuteA);
        self.minueL.transform = CATransform3DMakeRotation(minueteAngel, 0, 0, 1);
    
 
    6.添加时针
        同样复制之前的,添加一个小时属性
        小时转多少度
        当前是多少小时,再计算先每一小时转多少度.
        
        12个小时转一圈. 360除以12,每小时转30度
 
         时针旋转多少度
         CGFloat hourAngel = angle2Rad(hour * perHourA);
         旋转时针
         self.hourL.transform = CATransform3DMakeRotation(hourAngel, 0, 0, 1);
            
        直接这样写会有问题
        就是没转一分钟,小时也会移动一点点
        接下来要算出,每一分钟,小时要转多少度
        60分钟一小时.一小时转30度.
        30 除以60,就是每一分钟,时针转多少度.0.5
            
        时针旋转多少度
        CGFloat hourAngel = angle2Rad(hour * perHourA + minute * perMinuteHourA);
        旋转时针
        self.hourL.transform = CATransform3DMakeRotation(hourAngel, 0, 0, 1);
         
 
 
 
     */


#define angle2Rad(angle) ((angle) / 180.0 * M_PI)
//每一秒秒针转6度
#define perSecA 6
//每一分,分针转6度
#define perMinuteA 6
//每小时,时针转30度
#define perHourA 30

//每一分, 时针转0.5度
#define perMinuteHourA 0.5


#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
@property(weak,nonatomic) CALayer *secondL;
@property(weak,nonatomic) CALayer *minueL;
@property(weak,nonatomic) CALayer *hourL;
@end

@implementation ViewController
//注意,所以的控件或者图层都是绕着锚点进行旋转的
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加时针
    [self setUpHourLayer];
    //添加分针
    [self setUpMinuteLayer];
    //添加秒钟
    [self setUpSecLayer];
    //创建一个定时器
    //每个一秒,时长比较多,而且不是做绘图 直接用NSTime
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
}
//每个一秒就调用,旋转秒针
- (void)timeChange{
    
    //获取当前的秒数
    //创建日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //把日历类转换成一个日期组件
    //日期组件(年,月,日,时,分,秒)
    //component:日期组件有哪些东西组成,他是一个枚举,里面有年月日时分秒
    //fromDate:当前的日期
    
    //里面有左移符号,右移符号.他就可以用一个并运算
    //现在同时让他支持秒数和分 后面直接加上一个 |
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    //我们的秒就是保存在日期组件里面,它里面提供了很多get方法.
    NSInteger second = cmp.second;
    
    //获取当前是多少小时
    NSInteger hour = cmp.hour;
    
    
    
    
    //获取当前的多少分
    NSInteger minute = cmp.minute;
    
    //秒针旋转多少度.
    CGFloat secAngle = angle2Rad(second * perSecA);
    
//    //分针旋转多少度.
    CGFloat minueteAngel = angle2Rad(minute * perMinuteA);
    
    //时针旋转多少度
    CGFloat hourAngel = angle2Rad(hour * perHourA + minute * perMinuteHourA);
    
    
    //旋转秒针
    self.secondL.transform = CATransform3DMakeRotation(secAngle, 0, 0, 1);
    //旋转分针
    self.minueL.transform = CATransform3DMakeRotation(minueteAngel, 0, 0, 1);
    //旋转时针
    self.hourL.transform = CATransform3DMakeRotation(hourAngel, 0, 0, 1);
}


//添加秒针
- (void)setUpSecLayer{

    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 1, 80);
    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.secondL = layer;
    [self.clockView.layer addSublayer:layer];
    
  
}

//添加分针
- (void)setUpMinuteLayer{
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 4, 80);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.minueL = layer;
    [self.clockView.layer addSublayer:layer];
    
    
}


//添加时针
- (void)setUpHourLayer{
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 4, 60);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(_clockView.bounds.size.width * 0.5, _clockView.bounds.size.height * 0.5);
    self.hourL = layer;
    [self.clockView.layer addSublayer:layer];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
