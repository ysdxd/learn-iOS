//
//  Flag.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "Flag.h"

@implementation Flag
+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    Flag *flag = [[self alloc] init];
    
    [flag setValuesForKeysWithDictionary:dict];
    
    return flag;
    
}

- (void)setIcon:(NSString *)icon
{
    _icon = [UIImage imageNamed:icon];
}
@end
