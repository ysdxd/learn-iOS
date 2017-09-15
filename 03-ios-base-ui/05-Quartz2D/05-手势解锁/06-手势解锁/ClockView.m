//
//  ClockView.m
//  06-手势解锁
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "ClockView.h"

@interface ClockView()

//保存选中的按钮
@property(nonatomic,strong)NSMutableArray *selectArray;

//手指当前的点
@property(nonatomic,assign)CGPoint curP;

@end

@implementation ClockView

-(NSMutableArray *)selectArray{

    
    if (_selectArray ==nil) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
    
}


-(void)awakeFromNib{
    [self setUP];

}


-(nonnull instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUP];
    }
    return self;
    
}


//获取手指当前点
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}


//判断当前点在不在按钮上.
- (UIButton *)rectContainsPoint:(CGPoint)point{

    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            
            return btn;
        }
    }
    return nil;
}


//开始点击
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    //获出当前手指点
    CGPoint curP = [self getCurrentPoint:touches];
    
    //判断当前点在不在按钮上.
    UIButton *btn = [self rectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectArray addObject:btn];
    }
    
}

//开始移动
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    //获出当前手指点
    CGPoint curP = [self getCurrentPoint:touches];
    
    //判断当前点在不在按钮上.
    UIButton *btn = [self rectContainsPoint:curP];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectArray addObject:btn];
     
    }
    self.curP = curP;
    [self setNeedsDisplay];
}

//离开屏幕

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    //每一个让按钮取消选中状态
    
    
    NSMutableString *str = [NSMutableString string];
    
    for (UIButton *btn in self.selectArray) {
        
        [str appendFormat:@"%d",(int)btn.tag];
        
        btn.selected = NO;
    }
    
    NSLog(@"str===%@",str);
    
    //清空所有的选中按钮
    [self.selectArray removeAllObjects];
    
    [self setNeedsDisplay];
    
}


//初始化
-(void)setUP{
    
    for(int i =0; i < 9; i++){
        //添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        [self addSubview:btn];
        
    }
}

-(void)layoutSubviews{
    //一定要加上[super layoutSubviews];
    [super layoutSubviews];
    int colum = 3;
    CGFloat btnWH = 74;
    CGFloat margin = (self.bounds.size.width - colum * btnWH) / (colum + 1);
    for(int i = 0; i < self.subviews.count; i++ ){
        
        int curColum = i % colum;
        int curRow = i / colum;
        
        CGFloat x = margin + (btnWH + margin) * curColum;
        CGFloat y = (btnWH + margin) * curRow;
        
        //取出所有的子控件
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    
    
    }
}



-(void)drawRect:(CGRect)rect{
    
    if (self.selectArray.count) {
        
        //创建路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        
        for (int i = 0; i< self.selectArray.count; i++) {
            UIButton *btn = self.selectArray[i];
            if (i == 0) {
                //设置路径的起点
                [path moveToPoint:btn.center];
            }else{
                [path addLineToPoint:btn.center];
            }

        }
        
        //添加一根线到手指当前的位置
        [path addLineToPoint:self.curP];
        
        
        //设置线宽
        [path setLineWidth:10];
        
        //设置线的颜色
        [[UIColor redColor] set];
        
        //设置连接样式
        [path setLineJoinStyle:kCGLineJoinRound];
        
        //绘制
        [path stroke];
        
    }
    
    
}


@end
