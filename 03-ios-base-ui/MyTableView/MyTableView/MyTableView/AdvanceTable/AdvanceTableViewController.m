//
//  ViewController.m
//  advanceTable
//
//  Copyright (c) 2014年 芳仔小脚印. All rights reserved.
//

#import "AdvanceTableViewController.h"

#import "newsModel.h"


@interface AdvanceTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *sectionTitles; // 每个分区的标题
    NSArray *contentsArray; // 每行的内容
    
    NSMutableArray *news_MArray;// 新闻内容数据源
}

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation AdvanceTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    
    [self readySource];
   
}
/** @brief 准备数据源 在viewDidLoad方法中调用*/
- (void)readySource
{
    
    sectionTitles       = [[NSArray alloc] initWithObjects:
                           @"A",@"C",@"F",@"G",@"H",@"M",@"S",@"T",@"X",@"Z", nil];
    
    contentsArray       = [[NSArray alloc] initWithObjects:
                            @[@"阿伟",@"阿姨",@"阿三"],
                            @[@"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名"],
                            @[@"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟"],
                            @[@"郭靖",@"郭美美",@"过儿",@"过山车"],
                            @[@"何仙姑",@"和珅",@"郝歌",@"好人"],
                            @[@"妈妈",@"毛主席"],
                            @[@"孙中山",@"沈冰",@"婶婶"],
                            @[@"涛涛",@"淘宝",@"套娃"],
                            @[@"小二",@"夏紫薇",@"许巍",@"许晴"],
                            @[@"周恩来",@"周杰伦",@"张柏芝",@"张大仙"],nil];
    
    news_MArray = [[NSMutableArray alloc] init];
    for(NSInteger index =0; index<10; index++){
        newsModel *model    = [[newsModel alloc] init];
        model.news_image    = [NSString stringWithFormat:@"%d.jpg",index+1];
        model.news_title    = @"曾在月光之下望烟花";
        model.news_summary  = @"曾共看夕阳渐降下 我怎么舍得去放下 要怎么舍得去放下";
        model.news_replyNo  = index+196;
        model.reportType    = index%3;
        
        [news_MArray addObject:model];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate
/*
// 分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [contentsArray count];
}
 */
// 每个分区行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [[contentsArray objectAtIndex:section] count];
    return [news_MArray count];
}
/*
// 每个分区的页眉
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}
 */
/*
// 索引目录
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sectionTitles;
}
// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return index;
}
 */
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
// 每行的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cellIdentifier%d%d",indexPath.row,indexPath.section];
   
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*****自定义cell******/
    newsModel *model    = [news_MArray objectAtIndex:indexPath.row];
    
    UIImageView *   image_view;     //1.添加imageView
    UILabel *       title_label;    //2.添加标题Label
    UILabel *       summary_label;  //3.添加摘要Label
    UILabel *       replyNo_label;  //4.添加跟帖数量Label
    UIButton  *     extra_view;     //5.属于专题或者独家报道，进行标记
    /********************/
    
    // 如果队列中cell为空，即无复用的cell，则对其进行初始化
    if (cell==nil) {
        
        // 初始化
        cell                    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        // 定义其辅助样式
        cell.accessoryType      = UITableViewCellAccessoryNone;
        
        /*****自定义cell******/
        
        //1.添加imageView
        CGRect imageViewF   = CGRectMake(5, 5, 85, 65);
        image_view          = [[UIImageView alloc] initWithFrame:imageViewF];
        [cell addSubview:image_view];
        
        //2.添加标题Label
        CGRect titleLabelF  = CGRectMake(95, 5, 230, 24);
        title_label         = [[UILabel alloc] initWithFrame:titleLabelF];
        title_label.font    = [UIFont systemFontOfSize:16];//字体大小
        [cell addSubview:title_label];
        
        //3.添加摘要Label
        CGRect summaryLabelF  = CGRectMake(97, 27, 210, 40);
        summary_label         = [[UILabel alloc] initWithFrame:summaryLabelF];
        summary_label.font    = [UIFont systemFontOfSize:12];    // 字体大小
        summary_label.textColor     = [UIColor darkGrayColor];  // 文字颜色
        summary_label.numberOfLines = 2;
        [cell addSubview:summary_label];
        
        //4.跟帖数量Label
        CGRect replyNoLabelF  = CGRectMake(210, 45, 95, 24);
        replyNo_label         = [[UILabel alloc] initWithFrame:replyNoLabelF];
        replyNo_label.font    = [UIFont systemFontOfSize:12];    // 字体大小
        replyNo_label.textColor     = [UIColor darkGrayColor];  // 文字颜色
        replyNo_label.textAlignment = NSTextAlignmentRight;      // 文字右对齐
        
        //5.专题extraView
        CGRect extraViewF       = CGRectMake(270, 50, 28, 14);
        extra_view              = [[UIButton alloc] initWithFrame:extraViewF];
        extra_view.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        [extra_view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // 普通新闻，只添加跟帖数量
        if (model.reportType==NEWSReportOrdinary) {
           [cell addSubview:replyNo_label];
        }
        // 专题新闻，添加专题标志，并添加跟帖数量
        else if(model.reportType == NEWSReportSpecial){
            
            // 设置背景色
            extra_view.backgroundColor = [UIColor colorWithRed:120.0/255.0 green:170.0/255.0 blue:245.0/255.0 alpha:1.0];
            
            [extra_view setTitle:@"独家" forState:UIControlStateNormal];// 设置标题
            
            [cell addSubview:extra_view];                               // 添加
            
            replyNo_label.frame = CGRectMake(170, 45, 95, 24);          // 改变跟帖数量Label的坐标
            
            [cell addSubview:replyNo_label];                            // 添加跟帖数量Label
        }
        // 独家新闻，只添加独家标志
        else if(model.reportType == NEWSReportExclusive){
            
            extra_view.backgroundColor = [UIColor redColor];            // 设置背景颜色
            
            [extra_view setTitle:@"专题" forState:UIControlStateNormal]; // 设置标题
            
            [cell addSubview:extra_view];                               // 添加到cell
        }
        /********************/
    }
    
    /*****自定义cell******/
    [image_view setImage:[UIImage imageNamed:model.news_image]];// 设置图片
    title_label.text    = model.news_title;                     // 设置标题
    summary_label.text  = model.news_summary;                   // 设置小标题
    replyNo_label.text  = [NSString stringWithFormat:@"%d 跟帖",model.news_replyNo];// 设置跟帖数量
    /********************/
    
    //cell.textLabel.text = [[contentsArray objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取点击行的cell
    UITableViewCell *cell   = [tableView cellForRowAtIndexPath:indexPath];
    
    // 如果cell已经被标记
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        // 取消标记
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    
    // 如果cell未标记
    else{
        // 标记cell
        cell.accessoryType  = UITableViewCellAccessoryCheckmark;
    }
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
