//
//  OUOBaseTableViewController.h
//
//  Created by user on 12-9-6.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPBaseTableView.h"
#import "SPPageInfoData.h"
#import "SVPullToRefresh.h"

#define CELL_IDENTIFIER @"CELL_IDENTIFIER"

@interface OUOBaseTableViewController : SPBaseViewController<UITableViewDelegate, UITableViewDataSource> {
 @private
    SPBaseTableView *tableView_;
    NSMutableArray *dataArray_;
}

@property (assign, nonatomic) NSUInteger currentPageNumber;
@property (retain, nonatomic) SPPageInfoData *pageInfo;

@property (retain, nonatomic) SPBaseTableView *tableView;
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;
@property (retain, nonatomic) NSMutableArray *dataArray;

- (id)initWithStyle:(UITableViewStyle)style;

///////////////////////////////////////////////////////
#pragma mark - 以下方法需要时可在子类中重载

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * 为Cell分配内存空间并初始化
 */
- (UITableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * 给Cell化妆
 */
- (void)dressUpCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 * 配置Cell上面显示的数据
 */
- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 * 创建并配置Cell
 * 当包含多种不同Cell时重载些方法，一般情况不用重载
 */
- (UITableViewCell *)createAndConfigCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)titleForFooterInSection:(NSInteger)section;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (CGFloat)heightForFooterInSection:(NSInteger)section;
- (UIView *)viewForFooterInSection:(NSInteger)section;

@end
