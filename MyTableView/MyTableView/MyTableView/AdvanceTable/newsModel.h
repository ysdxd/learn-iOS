//
//  newsModel.h
//  advanceTable
//
//  Copyright (c) 2014年 芳仔小脚印. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NEWSReportType){
    NEWSReportOrdinary, // 普通新闻
    NEWSReportExclusive,// 独家新闻
    NEWSReportSpecial,  // 专题新闻
};

@interface newsModel : NSObject

@property (nonatomic, copy)NSString *       news_image;     //图片
@property (nonatomic, copy)NSString *       news_title;     //标题
@property (nonatomic, copy)NSString *       news_summary;   //摘要
@property (nonatomic, assign)NSInteger      news_replyNo;   //跟帖数量
@property (nonatomic, assign)NEWSReportType reportType;     //报道类型


@end
