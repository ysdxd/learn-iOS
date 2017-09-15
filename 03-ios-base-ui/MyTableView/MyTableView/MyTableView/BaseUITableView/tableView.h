//
//  general_table_view.h
//  TableView
//
//  Created by 芳仔小脚印 on 14-2-24.
//
//

#import <UIKit/UIKit.h>

@interface tableView : UITableView

// tableView的坐标
@property (nonatomic, assign) CGRect        tableViewFrame;

// 存放Cell上各行textLabel值
@property (nonatomic, copy)NSMutableArray * textLabelMArray;

// 存放Cell上各行imageView上图片
@property (nonatomic, copy)NSMutableArray * imagesMArray;

// 存放Cell上各行detailLabel值
@property (nonatomic, copy)NSMutableArray * subtitleMArray;

@end
