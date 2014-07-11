//
//  UITableViewPageing.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PAGENUM 10
#define INITPAGE 1

@interface UITableViewPageing : UITableView

@property (assign,nonatomic) int totalcount;//总页数
@property (assign,nonatomic) int pagenum;//每页条数
@property (assign,nonatomic) int page;//第几页
@property (assign,nonatomic) int maxpage;//最大页数
@property (assign,nonatomic) int curpagenum;//当前页条数
@property (retain,nonatomic) NSMutableArray *tableviewarray;//tableview的显示结果

- (NSMutableArray *)setPageingMessage:(int)totalcount tableviewarray:(NSArray *)tableviewarray;

- (void)reloadPageingMessageBeforeSelect;

- (NSString *)totalCountStringValue;

- (NSString *)pageNumStringValue;

- (NSString *)pageStringValue;

- (NSString *)maxPageStringValue;

- (NSString *)curPagenumStringValue;

@end
