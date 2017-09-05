//
//  BaseUITableViewController.m
//  MyTableView
//
//  Created by 云朽 on 2017/9/5.
//  Copyright © 2017年 云朽. All rights reserved.
//

#import "BaseUITableViewController.h"
#import "tableView.h"

@interface BaseUITableViewController ()
{
    tableView *table;
}
@end

@implementation BaseUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"第二个页面";
    
    // 初始化
    table = [[tableView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20) style:UITableViewStylePlain];
    
    // 设置数据源
    table.textLabelMArray  = [[NSMutableArray alloc] initWithObjects:@"南京市",@"南通市",@"淮安市",@"镇江市",@"扬州市",@"常州市", nil];
    
    
    NSMutableArray *images  = [NSMutableArray array];
    NSMutableArray *subtitle= [NSMutableArray array];
    
    for(NSInteger index = 0;index<[table.textLabelMArray count];index++){
        
        UIImage *image      = [UIImage imageNamed:@"2"];
        [images addObject:image];
        
        NSString *detail    = [NSString stringWithFormat:@"detail text %d", (int)index+1];
        [subtitle addObject:detail];
    }
    
    table.subtitleMArray   = [[NSMutableArray alloc] initWithArray:subtitle];
    
    table.imagesMArray     = [[NSMutableArray alloc] initWithArray:images];
    
    [self.view addSubview:table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
