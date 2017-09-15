//
//  DrawView.m
//  08-画板涂鸦
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "DrawView.h"
#import "DrawPath.h"



@interface DrawView()

@property(nonatomic,strong)   UIBezierPath *path;

@property(nonatomic,strong) NSMutableArray *pathArray;

@property(nonatomic,assign) CGFloat Width;

@property(nonatomic,strong) UIColor *lineColor;


@end

@implementation DrawView




-(NSMutableArray *)pathArray{

    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}


//清屏
- (void)clear{
    //清楚所有的路径.
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}
//撤销
- (void)undo{
    //移除保存路径当中的最后一个元素
    [self.pathArray removeLastObject];
    [self setNeedsDisplay];
}
//橡皮擦
- (void)erase{
    [self choseColor:[UIColor whiteColor]];
}
//选择颜色
- (void)choseColor:(UIColor *)colore{
    
    self.lineColor = colore;

}
//设置线的宽度
- (void)setLineWidth:(CGFloat)width{
    
    self.Width = width;
}



-(void)setImage:(UIImage *)image{

    _image = image;
    [self.pathArray addObject:image];
    [self setNeedsDisplay];
    
}





-(void)awakeFromNib{
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    
    self.lineWidth = 1;
    self.lineColor = [UIColor blackColor];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{

    //获取当前点
    CGPoint curP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        DrawPath *path = [[DrawPath alloc] init];
        //设置路径的起点.
        [path moveToPoint:curP];
        //设置线宽度
        [path setLineWidth:self.Width];
        //设置颜色
        path.lineColor = self.lineColor;
        
        
        self.path = path;
        //保存路径
        [self.pathArray addObject:path];
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:curP];
        [self setNeedsDisplay];
    }
    
}

-(void)drawRect:(CGRect)rect{
    //取出所有的路径
    for (DrawPath *path in self.pathArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
         UIImage *image = (UIImage *)path;
            
            [image drawInRect:rect];

        }else{
            [path.lineColor set];
            [path stroke];
        }
        
    }

}



@end
