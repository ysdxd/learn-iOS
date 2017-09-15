//
//  CityField.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZTextField.h"
@class CityField;

@protocol CityFieldDelegate <NSObject>

@optional
- (void)cityField:(CityField *)field didSelectCity:(NSString *)city;

@end

@interface CityField : UITextField

@property (nonatomic, weak) IBOutlet id<CityFieldDelegate> fieldDelegate;


@end
