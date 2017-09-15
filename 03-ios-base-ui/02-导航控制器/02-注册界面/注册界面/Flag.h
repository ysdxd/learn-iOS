//
//  Flag.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Flag : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *icon;

+ (instancetype)flagWithDict:(NSDictionary *)dict;


@end
