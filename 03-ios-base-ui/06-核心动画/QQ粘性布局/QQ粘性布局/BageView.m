//
//  BageView.m
//  QQ粘性布局
//
//  Created by Gavin on 15/8/4.
//  Copyright © 2015年 Gavin. All rights reserved.
/*
 那我一开始的时候,你觉得在哪个方法里面去写.,是不是在AwakeFromeNib
 我既然封装一个控件,是不是有可能用纯代码.是不是在InitWithfrom里面也写好.以后你想要封装一个控件.最好这两个方法里面都写哦.
 下面是不是弄一个初始化方法.这个方法是不是转门做一些初始化用的.
 从代码 里面也要初始化.从NIb里面也来一个初始化.
 
    
    1.搭建界面.
      1.新建一个继承于UIButton的View.绑定UIView
    2.初始化
     //文字颜色
     [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     //设置背景色
     [self setBackgroundColor:[UIColor redColor]];
     //设置圆角,圆角半径是不是正好是控件宽度的一半.所以要获取控件的宽度.
     //获取控件的宽度.
     CGFloat badgeW = self.bounds.size.width;
     //设置圆角,运行看一下有没有好使.
     self.layer.cornerRadius = badgeW * 0.5;
        
     运行.发现尺寸太大了. 改一下它的尺寸.改成20,20,运行发现, 文字的字体太大了, 把文字字体也改小一点.
     //设置文字的字体
     self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    发现一个问题哦 就是当我长按它的时候,它有一个高亮状态?是不是要取消高亮状态.
    是不是要重写-(void)setHighlighted:(BOOL)highlighted{
 
   }
 
    3.让按钮随着手指拖动而拖动.
    手指拖动想让它移动,是不是可以给它弄一个手势就可以了.手势是不是只要添加一次, 就直接在初始化方法里面写就可以了.
     //添加手势.
     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
     [self addGestureRecognizer:pan];
 
     //当手指在按钮上移动的时候调用.
     - (void)pan:(UIPanGestureRecognizer*)pan{
     //让bageView随着手指移动而移动.是不是得要获取当前的手指移动多少
     //所要我们要获取手指的偏移量
     CGPoint tranP = [pan translationInView:self];
     //随着手指移动而移动有三种方式,可以改frame,transform.center. 我们这里用transform.
     //我这里用transform来做试一次, 是相对于最原始的, 还是相对于上一次, 想要监听手指的移动而移动,是不是相对于上一次
     self.transform = CGAffineTransformTranslate(self.transform, tranP.x, tranP.y);
     //是不是还要做一次复位操作,复位操作才能相对于上一次
     [pan setTranslation:CGPointZero inView:self];
     }
     
    运行后发现它能够随着手指移动而移动.
    现在已经实现手指移动的时候随着手指移动了.
    下面做什么呢, 是不是当我的手指移动的时候,注意看下面, 是不是也是有一个像小圆的东西.而且空上小圆的半径越来越小.
    在拖动的时候,让小圆的半径不断缩小.
    让小圆随着手指拖动,半径慢慢减小.拖的越远,小圆的半径越小.
    现在没有小圆,小圆是不是起始至终只有一个.是不是可以在初始化的时候就创建.
 
     //添加一个小圆,默认跟我们的大圆一样大.有几个相同的属性.frame,圆角半径,背景色.
     UIView *smallCilcleView = [[UIView alloc] init];
     smallCilcleView.backgroundColor = self.backgroundColor;
     smallCilcleView.layer.cornerRadius = self.layer.cornerRadius;
     smallCilcleView.frame = self.frame;
     
     //,那这个小圆你觉得哪个上面.是加到大圆上面?还是添加到哪?
     //你看这个小圆一直没有动,如果我把这个小圆添加到BageView上面会有什么问题?是不是会随着大圆拖动而拖动.
     //所以不能添加到大圆上面,那加到哪?是不是加到大圆的父控件上面.他们两个是同个层级.
     
     //小圆要添加到大圆的父控件上面.
     //不能直接addSubview:smallCilcleView,这样会把上面的大圆给覆盖.
     //self.superview addSubview:smallCilcleView
     //在插入在大圆的底下.
     [self.superview insertSubview:smallCilcleView belowSubview:self];
 
     运行看一下有没有效果.运行后面已经有这个样一个效果了.
 
     那接下来,再教你们一个知识点, 你看我小圆和大圆是不是有很多相同的属性.
     copy语法它就能,拷贝出一个有相同属性的新对象.
     UIView *smallCilcleView = [self copy];
     //在插入在大圆的底下.
     [self.superview insertSubview:smallCilcleView belowSubview:sel
     运行:发现它会崩掉.[BageView copyWithZone:]: unrecognized selector sent to instance 0x7feee3d12410
     原因:copy底层会调用copyWithZone
     现在没有这个方法, 所以它就会报这个错误.
     那现在就写这个copyWithZone方法, 那现在能写出来嘛, 写不出来吧.
     如果要用copy语法 必须要遵守它的协议,@interface BageView : UIButton<NSCopying>
     是告诉它我怎么去copy
     NSString默认就有这个协议.NSString对象已经帮你做好这个NSCoping的写法了.
     这里是我自己定义的, 系统不知道你怎么去copy,所以要自己写.
 
     UIView *smallCilcleView = [self copy];
     //告诉系统如何拷贝
     //这里要求返回一个对象, 就是返回自己的对象嘛.
     //有相同属性的新对象.所以要创建一个新对象.
     -(nonnull id)copyWithZone:(nullable NSZone *)zone{
         UIView *smallCilcleView = [[UIView alloc] init];
         smallCilcleView.backgroundColor = self.backgroundColor;
         smallCilcleView.layer.cornerRadius = self.layer.cornerRadius;
         smallCilcleView.frame = self.frame;
         return smallCilcleView;
     }
    
    运行发现还是好用的.
 
    
    下面是不是要做到手指往外拖动的时候, 你小圆的半径缩小.怎么做.
    是不是可把两个控件的距离做一个比较.拖动的时候, 两个控件之间是不是有一个距离.
    那怎么样获取这两个中心点的距离.
    现在是不是想要计算两个中心点的距离,去计算小圆的半径缩小多少.弄一个比例嘛,只有根据这个距离才能判断我是拖远还是拖近.
    PPT演示,两个小圆
    如果你数学学的好我们可以用勾股定理哦.
    当然你数学学的不好, 我们也是用勾股定理.这没办法.注意看.
    假设我现在有一个(x1,y1),(x2,y2),他们分别代表小圆和大圆的中心点.
    我问你, 这个小圆的中心点我能不能拿到, 能吧.
    那我是不是把这两个圆心的距离求了来就好了.
    那这个两个距离怎么求?
    是不是等于下边这条线的平方 + 右边这条线的平方,开根
    下面这条距离怎么求?
    x2 - x1
    右边这条线怎么求
    y2 - y1
    其实就是x轴的便宜量,y轴的偏移量.
 
     让小圆随着手指拖动,半径慢慢减小.拖的越远,小圆的半径越小.
     根据两个圆之间的圆心距离形成一段比例
     计算两个圆心之间的距离.
     代码可能有点长, 我就抽成一个方法.
     计算两个圆之间的圆心距离.
     - (CGFloat)distanceWithSmallCircleView:(UIView *)smallCircleView BigCircleView:(UIView *)bigCircleView{
         获取x,y轴的偏移量.
         CGFloat offsetX = bigCircleView.center.x - smallCircleView.center.x;
         CGFloat offsetY = bigCircleView.center.y - smallCircleView.center.y;
         下面要进行开根, 开根有一个函数, sqrt
         return sqrtf(offsetX * offsetX + offsetY * offsetY);
     }
 
     //小圆我现在是不是拿不到啊,想要拿到它怎么做, 是不是可以弄一个成员属性就可以拿到了
     CGFloat d = [self distanceWithSmallCircleView:self.smallCilcleView BigCircleView:self];
     //现在是不是计算出两个圆心的距离,是不是根据圆心的距离计算小圆半径,
     //小圆的半径是不是不断的减少到某个值.
     //让小圆的半径减少, 首先要获取小圆的半径.
     //最好不要用上一次的啊,最好用最原始的吧
     // CGFloat smallR = self.smallCilcleView.bounds.size.width * 0.5;
     CGFloat smallR = self.bounds.size.width * 0.5;
     //让小圆的半径在每次之前的基本上减去一段比例,这个比例就让它除以一个10.看看好不好
     smallR = smallR - d / 10.0;
     //重新设置小圆的尺寸.
     _smallCilcleView.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
     //圆角半径也要重新设置了.不设置是不是还是原来的圆角半径, 是不是有问题啊.
     _smallCilcleView.layer.cornerRadius = smallR;
     //运行发现, 怎么拖都没有反应.
     //因为我们修改transform,并不会改center,底层改的是frame,所以这里不能再用transform了吧.
     //修改transform,并不会改center,底层改的是frame,所以这里不能再用transform了吧.
     //    self.transform = CGAffineTransformTranslate(self.transform, tranP.x, tranP.y);
     //只能修改Center去修改大圆的位置.
     CGPoint center = self.center;
     center.x += tranP.x;
     center.y += tranP.y;
     self.center = center;
 
 
    接下来还差哪一步.
    是不是在两个圆之间画一个不规则的矩形就好了.
    那我们画这种不规则的矩形怎么画来, 是不是描述几个点就可以了.
    那这个是不是就是计算几个点的位置就好了.
    其实我们不用纠结哦, 我们怎么去画.那我们先来看一幅图, 看完这幅图,你们就明白了哦.  
    打开,看到两个圆没有?
    那我们干嘛.我们是不是要画一个这样的不规则的矩形啊.
    其实我们就算哪几个点就好了, 就是算a,b,c,d,o,p就好了.如果你把这6个点算出来,我跟你说.
    这个不规则矩形是不是就描述好了.描述好你是不是把它画出来就好了.这个没问题吧.
 
    是不是等下我创建一个路径,这个路径,假设我起点为A,我是不是添加一根线到B 这个点.是不是有一条横线啦.
    然后我是不是可以连接BC这个点,但是BC之间它是曲线吧.所以说它要一个东西,是不是一个控制点,那这个控制点,是不是就是这个p,也就说, 我在bc之间画一条曲线,然后cd之间再画一条线.然后da之间再画一条曲线,是不是描述好这样一个路径,然后我再把这个路径填充, 它是不是就变成一个不规则矩形了.
        对不对, so easy,哦, 不是so easy,算的还是很恶心的哦.
        那这个算,也不用纠结哦, 我是不是有这幅图就好
 
 
    那我们看一下, 先算哪个点,我们先看A点怎么去计算.你要算A点,我们看怎么算,,首先, A点怎么算,是不是等于X1,X1是哪个?
        我们算的时候跟坐标没有关于哦, 那我们算的时候是以数学坐标系哦.
        小圆的中心点是(x1,y1);
        x1,就是小圆的中心点x,
        减去什么?是不是要减去左上边这一段间距.这一段间距怎么做?
        你看这一段间距是不是有一个θ,
        注意哦, 你想要求点的时候,你要先把这个θ求出来.
        是不是cosθ,sinθ全部都要求出来.
        那首先看一下这个cosθ怎么求哦.
        我们看上面这个大角.我们只要把这个角的cosθ求出来.其它角度都是相等的哦, 
        你注意看哦, 我上面写的之要画的θ的,它的角度都是相等的哦.
        那我们继续看, 看这个cosθ怎么求.
        是不是等于竖着的这一边 比上一个两个圆心的距离,邻边比斜边.
        那这个邻边的距离是什么?是不是就是Y轴的偏移量.
        是不是就特于大圆的圆心y2 -小圆圆心的y1 就是(y2 - y1),圆心的距离我们也能求出来吧.刚才是不是写了一个两个圆心的方法.对不对,那现在这个cosθ是不是就可以求出来了,
        cosθ = y2 - y1 / d(圆心的距离)
        
        求出这个cosθ之后, 那我们看这个sinθ怎么求?
        sinθ等于什么?是不是等于对边比斜边啊,
        对边是什么, 是不是就是 x轴移动的便宜量. 斜边是不是还是这个圆心的距离,那这个sinθ也能求出来吧
        sinθ = x2 - x1 / d(圆心的距离)
 
        那这个cosθ和sinθ求出来之后, 那接下来我们就求A点.
        A点怎么求.A点是不是就等于x1减去上面的这个距离,那上面的这个距离怎么求?
        是不是就等于你这个小圆的半径 乘以 cosθ,那半径我们能不能知道.半径是不是就是你这个小圆宽度的一半.
 
        A点的y怎么求,是不是等于小圆的y1 加上A点的对边.a点的对边怎么求, 是不是就等于小圆的半径*sinθ
 
        还有, 为什么这两个角相等?
        是不是上面这个平行,它的对象相等,
        那这个角加上边上这个等于90度, A点旁边这个角加上这个角也等于90度, 是不是就这个两角相等了啊.
        好, 现在A点求出来了吧, 那我们来看一下B点.
 
        那现在B点的x,小圆的x1 +  r1 * cosθ
        那看它的Y等于多少,y1 - r1 * sinθ,现在是数学坐标系嘛, 越上面越大, 越下面越小.
 
        c点
        
 
 
 
 
 
 
 
    那我们看这个点怎么画呢?
 
 
        那我就把上面分析转换成代码,
        我们是不是可以这样, 你给我两个不规则的圆, 我就给你一个不规则的路径.
 
 
 //接下来是不是就把这个路径给填充就好了嘛, 但是我跟你说哦, 我们这里不能用画.画的东西,超出自己的范围内是显示不了的
 //你看哦, 我们的这个不规则图形是不是在这个大圆的外面.那你觉得能用画嘛.画不了吧.
 //这个时候我们又要学习一个新的类了, 我问你, 我现在是不是就想要根据一个路径描述一个这样一个不规则的矩形.
 //如果以后想根据一个路径描述一个图形,这时候你要学习一个新的图层, 这个图层,可以根据一个路径.描述一个图形.
 
 
 
 当手指拖的远的时候, 拖离了之前的位置.
当我的手指一松开, 离刚才的那个点很近, 没有超过刚才那个范围,它又回弹回去了.

 只要你拖开的时候,就让你一直拖.

 只有当手指松开的时候, 它才会回去.
 
 假设我现在拖的很远,拖远了, 它会播放一个动画.
 
 业务逻辑.
 
当我超出某个区域,小圆没有了, 不规则的矩形也没有了.
 
是不是可以当你的两个圆心大于某个值的时候, 我就让它消失.小圆消失, 不规则的矩形也消失.
 
 
 
 
 
 
 
 

 */

#import "BageView.h"

@interface BageView()

@property(nonatomic,weak)UIView *smallCilcleView;

@property(nonatomic,weak)CAShapeLayer *shapLayer;

@end


@implementation BageView

-(void)awakeFromNib{
    [self setUP];
}


-(CAShapeLayer *)shapLayer{
    
    if (_shapLayer == nil) {
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        
        //设置填充颜色
        shapLayer.fillColor = self.backgroundColor.CGColor;
        self.shapLayer = shapLayer;
        
        //不能用addsublayer,可能会遮住你上面的东西.
        //    [self.superview.layer addSublayer:shapLayer];
        
        //这样添加是不是就有好多不规则矩形.我只想保证只有一个.我只要创建一次, 到时候只要改它的路径就好了se吧.
        //添加形状图层到父控件图层的最底部.
        [self.superview.layer insertSublayer:shapLayer atIndex:0];
    }
    return _shapLayer;

}

- (nonnull instancetype)initWithFrame:(CGRect)frame{

    
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}


- (void)setUP{
    
    //文字颜色
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置文字的字体
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    //设置背景色
    [self setBackgroundColor:[UIColor redColor]];
    //设置圆角,圆角半径是不是正好是控件宽度的一半.所以要获取控件的宽度.
    //获取控件的宽度.
    CGFloat badgeW = self.bounds.size.width;
    //设置圆角,运行看一下有没有好使.
    self.layer.cornerRadius = badgeW * 0.5;
    
    //添加手势.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    /*第一种*/
    //添加一个小圆,默认跟我们的大圆一样大.有几个相同的属性.frame,圆角半径,背景色.
//    UIView *smallCilcleView = [[UIView alloc] init];
//    smallCilcleView.backgroundColor = self.backgroundColor;
//    smallCilcleView.layer.cornerRadius = self.layer.cornerRadius;
//    smallCilcleView.frame = self.frame;
    
    //,那这个小圆你觉得哪个上面.是加到大圆上面?还是添加到哪?
     //你看这个小圆一直没有动,如果我把这个小圆添加到BageView上面会有什么问题?是不是会随着大圆拖动而拖动.
    //所以不能添加到大圆上面,那加到哪?是不是加到大圆的父控件上面.他们两个是同个层级.

    //小圆要添加到大圆的父控件上面.
    //不能直接addSubview:smallCilcleView,这样会把上面的大圆给覆盖.
    //self.superview addSubview:smallCilcleView
    //在插入在大圆的底下.
//    [self.superview insertSubview:smallCilcleView belowSubview:self];
    /*第二种copy语法写法*/
    //copy:语法它就能,拷贝出一个有相同属性的新对象.
    UIView *smallCilcleView = [self copy];
    self.smallCilcleView = smallCilcleView;
    //在插入在大圆的底下.
    [self.superview insertSubview:smallCilcleView belowSubview:self];
    
    //形状图层,根据一个路径生成一个图层.
    //待会你猜一下我把这个图层加到哪个上面.
    //是不是加到大圆父控件的layer上面.
//    CAShapeLayer *shapLayer = [CAShapeLayer layer];
//   
//    //设置填充颜色
//    shapLayer.fillColor = self.backgroundColor.CGColor;
//    self.shapLayer = shapLayer;
//    
//    //不能用addsublayer,可能会遮住你上面的东西.
////    [self.superview.layer addSublayer:shapLayer];
//    
//    //这样添加是不是就有好多不规则矩形.我只想保证只有一个.我只要创建一次, 到时候只要改它的路径就好了se吧.
//    //添加形状图层到父控件图层的最底部.
//    [self.superview.layer insertSublayer:shapLayer atIndex:0];
}

//告诉系统如何拷贝
//这里要求返回一个对象, 就是返回自己的对象嘛.
//有相同属性的新对象.所以要创建一个新对象.
-(nonnull id)copyWithZone:(nullable NSZone *)zone{
    UIView *smallCilcleView = [[UIView alloc] init];
    smallCilcleView.backgroundColor = self.backgroundColor;
    smallCilcleView.layer.cornerRadius = self.layer.cornerRadius;
    smallCilcleView.frame = self.frame;
    return smallCilcleView;
}

//当手指在按钮上移动的时候调用.
- (void)pan:(UIPanGestureRecognizer*)pan{
    //让bageView随着手指移动而移动.是不是得要获取当前的手指移动多少
    //所要我们要获取手指的偏移量
    CGPoint tranP = [pan translationInView:self];
    //随着手指移动而移动有三种方式,可以改frame,transform.center. 我们这里用transform.
    //我这里用transform来做试一次, 是相对于最原始的, 还是相对于上一次, 想要监听手指的移动而移动,是不是相对于上一次
    //修改transform,并不会改center,底层改的是frame,所以这里不能再用transform了吧.
//    self.transform = CGAffineTransformTranslate(self.transform, tranP.x, tranP.y);
    //只能修改Center去修改大圆的位置.
    CGPoint center = self.center;
    center.x += tranP.x;
    center.y += tranP.y;
    self.center = center;
    
    
    
    
    
    //是不是还要做一次复位操作,复位操作才能相对于上一次
    [pan setTranslation:CGPointZero inView:self];
    
    //让小圆随着手指拖动,半径慢慢减小.拖的越远,小圆的半径越小.
    //根据两个圆之间的圆心距离形成一段比例
    //计算两个圆心之间的距离.
    //代码可能有点长, 我就抽成一个方法.
    
    //大圆就是我们self
    //小圆我现在是不是拿不到啊,想要拿到它怎么做, 是不是可以弄一个成员属性就可以拿到了
    CGFloat d = [self distanceWithSmallCircleView:self.smallCilcleView BigCircleView:self];
    //现在是不是计算出两个圆心的距离,是不是根据圆心的距离计算小圆半径,
    //小圆的半径是不是不断的减少到某个值.
    //让小圆的半径减少, 首先要获取小圆的半径.
    
    
    //最好不要用上一次的啊,最好用最原始的吧
//    CGFloat smallR = self.smallCilcleView.bounds.size.width * 0.5;
    
    CGFloat smallR = self.bounds.size.width * 0.5;
    
    
    //让小圆的半径在每次之前的基本上减去一段比例,这个比例就让它除以一个10.看看好不好
    smallR = smallR - d / 10.0;
    //重新设置小圆的尺寸.
    _smallCilcleView.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
    //圆角半径也要重新设置了.不设置是不是还是原来的圆角半径, 是不是有问题啊.
    _smallCilcleView.layer.cornerRadius = smallR;
    //运行发现, 怎么拖都没有反应.
    //因为我们修改transform,并不会改center,底层改的是frame,所以这里不能再用transform了吧.

    
    UIBezierPath *path = [self pathWithSmallCircleView:self.smallCilcleView BigCircleView:self];
    
    //这个方法不能乱调, 小圆显示的时候才需要描述
    if(self.smallCilcleView.hidden == NO){
            self.shapLayer.path = path.CGPath;
    }

    
    
    //业务逻辑处理
    //判断下圆心的距离,如果大于60, 隐藏小圆, 不规则矩形.
    if(d > 60){
        self.smallCilcleView.hidden = YES;
//        _shapLayer.hidden = YES;
        [_shapLayer removeFromSuperlayer];
    }
    //但是你会发现一个不好的效果.是不是没有那种吸附效果一样.吸附过来吧.
    //这个shape你只要移除父控件它就有这种效果了.
    //[_shapLayer removeFromSuperlayer];
    
    
    //接下来是不是手指抬起来的时候做事情.判断你这个东西有没有拖远.
    
    if(pan.state == UIGestureRecognizerStateEnded){
        //判断下当前圆心的距离是否大于60,大于60就播放gif图片
        if(d > 60){
            
            
            UIImageView *imageView = [[UIImageView alloc] init];
            
            imageView.frame = self.bounds;
            
            
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 1; i <= 8 ; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
                [array addObject:image];
            }
            imageView.animationImages = array;
            imageView.animationDuration = 1;
            //开始动画
            [imageView startAnimating];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                [self removeFromSuperview];
            });
            
            
            
            [self addSubview:imageView];
            
            
        }else{//还原
            [_shapLayer removeFromSuperlayer];
            //就是还原到大圆的原来位置,那大圆的原来位置有记录嘛, 没有吧.
            //是不是一开始的时候把Center位置给记录住就好了.因为我现在是不是一直改center
            //我是不是把之前的位置给记录住,还原到之前的位置.
            //你看我上面是不是记录一个小圆的,那小圆的位置
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                self.center = self.smallCilcleView.center;
                
                //设完后发现有个Bug,是不是还原时候也要把这个不规则的矩形也给干掉.
                
                //还有一个问题,我把它移除后,它再也没有了.
                //如果还原的时候, 是不是再把它添加上去啊.
                
                //那我采取什么方法呢, 采取懒加载的方法, 懒加载是不是发现没有了, 再去执行一次.
                
            } completion:^(BOOL finished) {
                
                self.smallCilcleView.hidden = NO;
            }];
            
            
     
        }
        
    
    }
    
    
}

//计算两个圆之间的圆心距离.
- (CGFloat)distanceWithSmallCircleView:(UIView *)smallCircleView BigCircleView:(UIView *)bigCircleView{
    
    //获取x,y轴的偏移量.
    CGFloat offsetX = bigCircleView.center.x - smallCircleView.center.x;
    CGFloat offsetY = bigCircleView.center.y - smallCircleView.center.y;
    //下面要进行开根, 开根有一个函数, sqrt
    return sqrtf(offsetX * offsetX + offsetY * offsetY);
}



//根据两个圆描述一个不规则的矩形
//返回的是一个路径吧, 路径是什么, UIBezier
- (UIBezierPath *)pathWithSmallCircleView:(UIView *)smallCircleView BigCircleView:(UIView *)bigCircleView{
    
    //获取x1,y1,r1 小圆
    CGFloat x1 = smallCircleView.center.x;
    CGFloat y1 = smallCircleView.center.y;
    CGFloat r1 = smallCircleView.bounds.size.width * 0.5;
    
    //获取大圆x2,y2,r2 大圆
    CGFloat x2 = bigCircleView.center.x;
    CGFloat y2 = bigCircleView.center.y;
    CGFloat r2 = bigCircleView.bounds.size.width * 0.5;
//
//    //现在要干什么,是不是先要把你的这个两个圆心的距离,
//    //计算两个圆心的距离.
    CGFloat d = [self distanceWithSmallCircleView:self.smallCilcleView BigCircleView:self];
//
//    if(d <= 0) return nil;
//    
//    
//    //cosθ
    CGFloat cosθ = (y2 - y1) / d;
//    //sinθ
    CGFloat sinθ = (x2 - x1) / d;
//
//    //A点
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
//    //B点
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
//    //C点
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
//    //D点
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
//    //O点
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
//    //P点
//    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    //描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    // 计算两个圆之间的圆心距离
    
    if (d <= 0) return nil;
    // P
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);

    // AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    // BC
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    // CD
    [path addLineToPoint:pointD];
    //DA
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
}


//取消高亮时候做的事件
-(void)setHighlighted:(BOOL)highlighted{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
