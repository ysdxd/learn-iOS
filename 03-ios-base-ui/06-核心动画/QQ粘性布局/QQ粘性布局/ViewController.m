//
//  ViewController.m
//  QQ粘性布局
//
//  Created by Gavin on 15/8/4.
//  Copyright © 2015年 Gavin. All rights reserved.
/*
    介绍QQ粘性布局使用的场合
      QQ聊天TabBar里面,提醒数字是可以拖拽的
     这个东西是可以随着手指移动而移动.可而又能显示一个文字.有可能也能点击的. 有可能点击也有效果的.
        所以我们用一个按钮来做.按钮是不是可以显示文字,也可以现实其他的图片.
        按钮可以随着手指移动而移动啊.
 
    那这个粘性布局,我就帮你们封装出来这一套控件,以后如果有这样的效果,你就直接拿着这个控件用就好了.
    也就是说这个控件只要写一次,以后就不要在写了.每次写就没必要了.
    
    刚刚说了, 这是一个什么控件,是一个按钮吧, 那我是不是要自定义一个按钮啊.继承UIButton
    就给他起一个名字叫BageView
    
    先拖一个,保证能现实出来.
    类型弄成我自己的就好了.
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup  a fter loading the view, typically from a nib.
    
    //解决自动布局问题.
    //在自动布局的时候,它会自动转一个东西.
    //它会把你的auotSize转换成自动布局.
    //是不是告诉它不要将autosizing转换成自动布局就行了.
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
