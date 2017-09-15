//
//  ViewController.m
//  PickerView简单使用
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *datePicker;

@property (nonatomic, strong) NSArray *foods;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation ViewController

- (NSArray *)foods
{
    if (_foods == nil) {
        _foods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil]];
    }
    return _foods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *arr = self.foods[component];
    
    return arr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _labelView.text = self.foods[component][row];
}


@end
