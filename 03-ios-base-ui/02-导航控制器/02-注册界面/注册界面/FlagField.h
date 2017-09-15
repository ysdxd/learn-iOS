//
//  FlagField.h
//  注册界面
//
//  Created by yz on 15/7/27.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZTextField.h"
@class FlagField;
@protocol FlagFieldDelegate <NSObject>

@optional
- (void)flagField:(FlagField *)field didSelectCountry:(NSString *)country;

@end

@interface FlagField : UITextField

@property (nonatomic, weak) IBOutlet id<FlagFieldDelegate> fieldDelegate;



@end
