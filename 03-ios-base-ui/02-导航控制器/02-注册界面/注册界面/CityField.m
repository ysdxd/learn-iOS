//
//  CityField.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "CityField.h"

#import "Province.h"

#define YZDictArr(fileName) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]

@interface CityField ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *provinces;

@property (nonatomic, assign) NSInteger selProvinceIndex;

@end

@implementation CityField

- (NSMutableArray *)provinces
{
    if (_provinces == nil) {
    
        _provinces = [NSMutableArray array];
        
        NSArray *dictArr = YZDictArr(@"provinces.plist");
        
        for (NSDictionary *dict in dictArr) {
            
            Province *province = [Province provinceWithDict:dict];
            
            [_provinces addObject:province];
            
        }
    }
    
    return _provinces;
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

- (void)setUp
{
   
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    self.inputView = pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.provinces.count;
        
    }else{
        
        Province *p = self.provinces[_selProvinceIndex];
        
        return p.cities.count;
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.provinces[row] name];
    }else{
         Province *p = self.provinces[_selProvinceIndex];
        
        return p.cities[row];
        
        
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        _selProvinceIndex = row;
        
        [pickerView reloadComponent:1];
        
    }
    Province *p = self.provinces[_selProvinceIndex];
    NSString *proName = [p name];
    
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    
    NSString *cityName = p.cities[cityIndex];
    
    if ([_fieldDelegate respondsToSelector:@selector(cityField:didSelectCity:)]) {
        [_fieldDelegate cityField:self didSelectCity:[NSString stringWithFormat:@"%@ %@",proName,cityName]];
    }
    
}
- (void)initialText
{
    [self pickerView:nil didSelectRow:0 inComponent:0];
}

@end
