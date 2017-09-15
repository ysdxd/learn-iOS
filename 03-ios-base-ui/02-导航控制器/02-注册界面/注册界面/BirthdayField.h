//
//  BirthdayField.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZTextField.h"
@class BirthdayField;
@protocol BirthdayFieldDelegate <NSObject>

@optional
- (void)birthdayField:(BirthdayField *)field didSelectDate:(NSString *)date;

@end


@interface BirthdayField : UITextField

@property (nonatomic, weak) IBOutlet id<BirthdayFieldDelegate> fieldDelegate;

@end
