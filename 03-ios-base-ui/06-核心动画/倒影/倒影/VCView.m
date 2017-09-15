//
//  VCView.m
//  倒影
//
//  Created by Gavin on 15/7/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "VCView.h"

@implementation VCView
//修改这个View的图层类型为复制层
//返回的就是这个View根层的类型
+ (nonnull Class)layerClass{
    return [CAReplicatorLayer class];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
