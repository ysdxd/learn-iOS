//
//  Province.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "Province.h"

@implementation Province
+ (instancetype)provinceWithDict:(NSDictionary *)dict
{
    Province *p = [[self alloc] init];
    
    [p setValuesForKeysWithDictionary:dict];
    
    return p;
}
@end
