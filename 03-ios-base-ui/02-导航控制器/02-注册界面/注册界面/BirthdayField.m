//
//  BirthdayField.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "BirthdayField.h"


@interface BirthdayField ()

@property (nonatomic, weak) UIDatePicker *datePicker;

@end

@implementation BirthdayField

- (void)awakeFromNib
{
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
        
    }
    return self;
}

- (void)initialText
{
    [self timeChange:_datePicker];
}

- (void)setUp
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    _datePicker = picker;
    picker.datePickerMode = UIDatePickerModeDate;
    
    picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    [picker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
    
    self.inputView = picker;
}

- (void)timeChange:(UIDatePicker *)datePicker
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    
    if ([_fieldDelegate respondsToSelector:@selector(birthdayField:didSelectDate:)]) {
        [_fieldDelegate birthdayField:self didSelectDate:dateStr];
    }
}



@end
