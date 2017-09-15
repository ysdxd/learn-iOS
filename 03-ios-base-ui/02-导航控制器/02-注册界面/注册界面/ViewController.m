//
//  ViewController.m
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ViewController.h"


#import "BirthdayField.h"
#import "FlagField.h"
#import "CityField.h"

@interface ViewController ()<UITextFieldDelegate,BirthdayFieldDelegate,FlagFieldDelegate,CityFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *flagField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;




@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    _flagField.delegate = self;
    _birthdayField.delegate = self;
    _cityField.delegate = self;
    
    
}

- (BOOL)textFieldShouldBeginEditing:(YZTextField *)textField
{
    
    [textField initialText];
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}


- (void)birthdayField:(BirthdayField *)field didSelectDate:(NSString *)date
{
    _birthdayField.text = date;
}

- (void)flagField:(FlagField *)field didSelectCountry:(NSString *)country
{
    _flagField.text = country;
}

- (void)cityField:(CityField *)field didSelectCity:(NSString *)city
{
    _cityField.text = city;
}


@end
