//
//  general_table_view.m
//  TableView
//
//  Created by 芳仔小脚印 on 14-2-24.
//
//

#import "tableView.h"


@interface tableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation tableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate   = self;
        self.dataSource = self;
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        self.delegate   = self;
        self.dataSource = self;
    }
    return self;
}

-(void)setTableViewFrame:(CGRect)tableViewFrame
{
    self.frame = tableViewFrame;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - table view data source

// tableView分区数量，默认为1，可为其设置为多个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// tableView每个分区的行数，可以为各个分区设置不同的行数，根据section的值判断即可
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_textLabelMArray count];
}

// tableView页眉的值，同理，可为不同的分区设置不同的页眉，也可不写此方法
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"页眉";
//}
//
//// 页脚
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"页脚";
//}

// 实现每一行Cell的内容，tableView是Cell重用机制
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 为其定义一个标识符，在重用机制中，标识符非常重要，这是系统用来匹配table各行cell的判断标准，在以后的学习中会体会到
    static NSString *cellIdentifier = @"cellIdentifier";
    
    // 从缓存队列中取出复用的cell
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // 如果队列中cell为空，即无复用的cell，则对其进行初始化
    if (cell==nil) {
        
        // 初始化
        cell                    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        // 定义其辅助样式
        cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;
    }
    // 设置cell上文本内容
    cell.textLabel.text         = [_textLabelMArray objectAtIndex:indexPath.row];
    
    // 设置每一行的图片
    cell.imageView.image        = [_imagesMArray objectAtIndex:indexPath.row];
    
    // 设置小标题
    cell.detailTextLabel.text   = [_subtitleMArray objectAtIndex:indexPath.row];
    
    return cell;
}
@end
