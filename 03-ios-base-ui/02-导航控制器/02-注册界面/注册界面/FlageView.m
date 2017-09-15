//
//  FlageView.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//


#import "FlageView.h"

#import "Flag.h"

@implementation FlageView

- (void)setFlag:(Flag *)flag
{
    _flag = flag;
    
    _labelView.text = flag.name;
    
    _iconView.image = flag.icon;
    
}

+ (instancetype)flagView
{
    return [[NSBundle mainBundle] loadNibNamed:@"FlageView" owner:nil options:nil][0];
}

@end
