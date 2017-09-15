//
//  FlagField.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "FlagField.h"

#import "Flag.h"

#import "FlageView.h"

#import "FlagField.h"

#define YZDictArr(fileName) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]

@interface FlagField ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *flags;

@end

@implementation FlagField

- (void)initialText
{
     [self pickerView:nil didSelectRow:0 inComponent:0];
}

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

- (NSMutableArray *)flags
{
    if (_flags == nil) {
        _flags = [NSMutableArray array];
        
        NSArray *dictArr = YZDictArr(@"flags.plist");
        
        for (NSDictionary *dict in dictArr) {
            
            Flag *flag = [Flag flagWithDict:dict];
            
            [_flags addObject:flag];
            
        }
        
    }
    
    return _flags;
}


- (void)setUp
{
    // 自定义键盘
    [self setUpFlagField];
}


#pragma mark - 自定义国旗键盘
- (void)setUpFlagField
{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    self.inputView = pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FlageView *flagView = [FlageView flagView];
    
    flagView.flag = self.flags[row];
    
    return flagView;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Flag *flag = self.flags[row];
    
    if ([_fieldDelegate respondsToSelector:@selector(flagField:didSelectCountry:)]) {
        [_fieldDelegate flagField:self didSelectCountry:flag.name];
    }
}

@end
