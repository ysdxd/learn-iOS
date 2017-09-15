//
//  ViewController.m
//  07-手势识别(掌握)
//
//  Created by apple on 15/7/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 捏合，缩放
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinch.delegate = self;
    
    [_imageView addGestureRecognizer:pinch];
    
    // 添加旋转手势
    [self setUpRotation];
    
    // 同时支持捏合和旋转手势

    
}

// Simultaneously：同时
// 如果返回yes，表示同时支持很多手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    // 获取相对于最原始的缩放比例
    CGFloat scale = pinch.scale;
    
    // x,y，x表示宽度缩放多少，y表示高度缩放
    _imageView.transform = CGAffineTransformScale(_imageView.transform, scale, scale);
    // 复位
    pinch.scale = 1;
    
    
}

- (void)setUpRotation
{
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    rotation.delegate = self;
    
    [_imageView addGestureRecognizer:rotation];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    NSLog(@"%f",rotationGestureRecognizer.rotation);
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotationGestureRecognizer.rotation);
    // 复位
    rotationGestureRecognizer.rotation = 0;
    NSLog(@"%s",__func__);
}


- (void)setUpPan
{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    
    [_imageView addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    // 获取手指偏移量，相对于最原始位置的偏移量
    CGPoint transP = [pan translationInView:_imageView];
    
    
    // 改imageView形变
    _imageView.transform = CGAffineTransformTranslate(_imageView.transform, transP.x, transP.y);
    
    // 复位，相对于上一次
    [pan setTranslation:CGPointZero inView:_imageView];
    
    NSLog(@"%@",NSStringFromCGPoint(transP));
}

- (void)setUpSwipe
{
    // 轻扫
    // 轻扫默认的方向：向右
    // 一个轻扫手势只能支持一个方向
    // 一个控件可以添加很多手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    [_imageView addGestureRecognizer:swipeRight];
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"%s",__func__);
    }
}

#pragma mark - 长按
- (void)setUpLongPress
{
    // 长按
    UILongPressGestureRecognizer *longPres = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    [_imageView addGestureRecognizer:longPres];
}

// 这个方法调用频率跟随手指的变化,最少调用2次
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"%ld",longPress.state);
        
    }
    
    
}
#pragma mark - 点按
- (void)setUpTap
{
    // 创建点按手势
    // 当触发点按手势的时候就会调用Target对象action方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    //    tap.delegate = self;
    
    // 点按
    [_imageView addGestureRecognizer:tap];

}

// 是否允许接收一个手指
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    
//    // 获取当前触摸点
//    CGPoint curP = [touch locationInView:_imageView];
//    
//    
//    // 如果在图片的左边，不允许接收这个手指
//    if (curP.x < _imageView.bounds.size.width * 0.5) {
//        // 左边
//        return NO;
//    }else{
//        return YES;
//    }
//    
//}

- (void)tap
{
    NSLog(@"%s",__func__);
}

@end
