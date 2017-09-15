//
//  ViewController.m
//  08-转场动画
//
//  Created by Gavin on 15/8/2.
//  Copyright © 2015年 Gavin. All rights reserved.
//
/*
    1.什么是转场动画?
      是不是就是一个转换场景啊
    2.那我现在有一个需求,假设我现在想弄一个UIImageView展示几声图片.
      想点一下控制器的View 就切换一张图片.
      是不是就相当于转换一个场景了.
 
    3.导入素材
       看图片是不是有1,2,3这样的规律啊
        默认展示第1张.
 
     下面点击一下屏幕就切换一张图片在TouchBegain方法里面做
      想要切换这一张图片,所以要先拿到这张图片.
        
     可以弄一个静态变量记录当前点的次数
     加一个Static,只能在这个文件里面才好使.
     不能用Index,系统当中已经有index,所以不能用Index了
     一点的时候, 就让它是第二张, 可以初始化为2.
     static int  _i = 2;
 
     那里的图片名不能写死吧.是不是需要变啊.所以弄一个变量去记录它
     可以弄一个角标记录当前点击的次数,
     NSString *imageName = [NSString stringWithFormat:@"%d",_i];
     self.imageV.image = [UIImage imageNamed:imageName];
     _i++;
    
    运行发现,超过3的时候就不显示了,所以要加一下判断.
         if(_i > 3){
            _i = 1;
         }
 
    现在是不是已经可以转换一个场景了.
         
    4.添加转场动画.
     创建转场动画
     CATransition *anim = [CATransition animation];
     设置转场类型
     anim.type = @"cube";
     [_imageV.layer addAnimation:anim forKey:nil];
     
    执行转场动画的代码 转场代码
    如果把转场动画和转场代码分开的话, 是没有动画效果的.
 
    验证.把转场动画放到viewDidLoad
     - (void)viewDidLoad {
         [super viewDidLoad];
         // Do any additional setup after loading the view, typically from a nib.
         CATransition *anim = [CATransition animation];
         //设置转场类型
         anim.type = @"cube";
         [_imageV.layer addAnimation:anim forKey:nil];
         
     }
    一定要记住,转场动画一定要和转场代码放在一起.
    先添加转场动画,再写转场代码也是没有问题的.
    因为只要在一起,系统会自动判断有没有转场.
    要放到一个方法里面, 在另外一个方法里面就识别不了.
 
    PPT演示转场的类型.
    可以设置翻转的方向
    subtype.
    anim.subtype = kCATransitionFromLeft;
 
    anim.type = @"suckEffect";  
    可以给他添加一个View里面, 让它和UiImageView一样大小
 
    在游戏里面这些转场动画用到人比较多的.
    应用里面动画就没有那么多,应用一般都是越简洁越好.
     动画的开始进度
     anim.startProgress = 0.5;
     结束进度,有一段是没有动画的.
     anim.endProgress  =0.8;
 
 
 */
#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    CATransition *anim = [CATransition animation];
//    //设置转场类型
////    anim.type = @"cube";
//    anim.type = @"suckEffect";
//    [_imageV.layer addAnimation:anim forKey:nil];
    
}

//可以弄一个静态变量记录当前点的次数
//加一个Static,只能在这个文件里面才好使.
//不能用Index,系统当中已经有index,所以不能用Index了
//一点的时候, 就让它是第二张, 可以初始化为2.
static int  _i = 2;

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    //上面这一块叫做转场代码
    if(_i > 3){
        _i = 1;
    }
    //那里的图片名不能写死吧.是不是需要变啊.所以弄一个变量去记录它
    //可以弄一个角标记录当前点击的次数,
    NSString *imageName = [NSString stringWithFormat:@"%d",_i];
    self.imageV.image = [UIImage imageNamed:imageName];
    _i++;
    
    
    //创建转场动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
//    anim.type = @"cube";
    anim.duration = 1;
    //它是往它的父控件上面抽
    //可以给他添加一个View里面, 让它和UiImageView一样大小
    anim.type = @"suckEffect";
    anim.subtype = kCATransitionFromLeft;
    //动画的开始进度
    anim.startProgress = 0.5;
    //结束进度,有一段是没有动画的.
    anim.endProgress  =0.8;
    
    
    [_imageV.layer addAnimation:anim forKey:nil];
    
    //转场动画必须要和转场代码一起.
    //把它们分开的话, 就没有这个转场效果了.
    //验证
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
