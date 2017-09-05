//
//  SimpleViewController.m
//  MyTableView
//
//  Created by 云朽 on 2017/9/5.
//  Copyright © 2017年 云朽. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //列表的行数
    NSInteger count;
}

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    count = 50;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIColor redColor];
    title.text = [NSString stringWithFormat:@"第%ld行标题",indexPath.row];
    [cell.contentView addSubview:title];
    
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-220, 0, 200, 50)];
    content.font = [UIFont systemFontOfSize:12];
    content.textColor = [UIColor orangeColor];
    content.text = [NSString stringWithFormat:@"第%ld行内容",indexPath.row];
    content.numberOfLines = 0;
    content.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:content];
    
    return cell;
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
