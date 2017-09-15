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
 
 
 
 
 
 
 
 */

#import "BageView.h"

@interface BageView()

@property(nonatomic,weak)UIView *smallCilcleView;

@end


@implementation BageView

-(void)awakeFromNib{
    [self setUP];
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
    
    
}

//计算两个圆之间的圆心距离.
- (CGFloat)distanceWithSmallCircleView:(UIView *)smallCircleView BigCircleView:(UIView *)bigCircleView{
    
    //获取x,y轴的偏移量.
    CGFloat offsetX = bigCircleView.center.x - smallCircleView.center.x;
    CGFloat offsetY = bigCircleView.center.y - smallCircleView.center.y;
    //下面要进行开根, 开根有一个函数, sqrt
    return sqrtf(offsetX * offsetX + offsetY * offsetY);
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
