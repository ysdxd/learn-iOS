//
//  ViewController.m
//  08-画板涂鸦
//
//  Created by Gavin on 15/9/8.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "ImageHandleView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,ImageHandleViewDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

//清屏
- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
//撤销
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
//橡皮擦
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}

//照片
- (IBAction)photo:(id)sender {

    //弹出系统相册.
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    
    /*
     UIImagePickerControllerSourceTypePhotoLibrary,
     UIImagePickerControllerSourceTypeCamera,
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    //设置相片来源
    pick.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    
    pick.delegate = self;
    
    //让它modal出来
    [self presentViewController:pick animated:YES completion:nil];
    
    
}


-(void)imagePickerController:(nonnull UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //不是直接画上去.
    //在控制器上面添加了一个View.对这个View做平移,缩放.
    ImageHandleView *handleView = [[ImageHandleView alloc] init];
    handleView.frame = self.drawView.frame;
    handleView.image = image;
    handleView.delegate = self;
    [self.view addSubview:handleView];


//    self.drawView.image = image;
    //要自己手动去disMiss
    [self dismissViewControllerAnimated:picker completion:nil];
}


-(void)imageHandleView:(ImageHandleView *)handView image:(UIImage *)image{
    
    self.drawView.image = image;

}



//保存
- (IBAction)save:(id)sender {
    
    //把绘制在UIView上面的东西,生成一张图片保存到相册当中.
    
    //开启图片上下文,
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    //获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把画板上的东西渲染到上下文.
    [self.drawView.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    //把生成一张图片保存到相册当中.
    //保存成功调用的方法必须得- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError: contextInfo:), nil);

}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
     NSLog(@"保存成功");
}



//选择颜色
- (IBAction)choseColor:(UIButton *)sender{
    [self.drawView choseColor:sender.backgroundColor];
}

//设置线宽
- (IBAction)setLine:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
