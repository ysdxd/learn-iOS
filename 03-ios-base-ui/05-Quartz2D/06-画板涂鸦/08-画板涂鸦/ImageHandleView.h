//
//  ImageHandleView.h
//  08-画板涂鸦
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageHandleView;
@protocol ImageHandleViewDelegate <NSObject>

@optional
- (void)imageHandleView:(ImageHandleView *)handView image:(UIImage *)image;


@end


@interface ImageHandleView : UIView

@property (nonatomic, strong) UIImage *image;

@property(nonatomic,weak) id<ImageHandleViewDelegate>delegate;


@end
