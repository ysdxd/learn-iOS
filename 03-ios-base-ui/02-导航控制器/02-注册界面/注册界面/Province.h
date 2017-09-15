//
//  Province.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *cities;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;

@end
