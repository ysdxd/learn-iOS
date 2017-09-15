//
//  FlageView.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Flag;

@interface FlageView : UIView

@property (nonatomic, strong) Flag *flag;

@property (weak, nonatomic) IBOutlet UILabel *labelView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

+ (instancetype)flagView;

@end
