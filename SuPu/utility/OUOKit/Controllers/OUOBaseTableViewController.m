//
//  OUOBaseTableViewController.m
//
//  Created by user on 12-9-6.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

#import "OUOBaseTableViewController.h"

@interface OUOBaseTableViewController ()

@end

@implementation OUOBaseTableViewController
@synthesize pageInfo = pageInfo_;
@synthesize tableView = tableView_;
@synthesize dataArray = dataArray_;
@synthesize currentPageNumber = currentPageNumber_;
@synthesize clearsSelectionOnViewWillAppear = clearsSelectionOnViewWillAppear_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(pageInfo_);
    OUOSafeRelease(tableView_);
    OUOSafeRelease(dataArray_);
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        tableView_ = [[SPBaseTableView alloc] initWithFrame:CGRectZero style:style];
        tableView_.delegate = self;
        tableView_.dataSource = self;
        
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
        
        clearsSelectionOnViewWillAppear_ = YES;
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:tableView_];
    if (iPad) {
        tableView_.frame = CGRectMake(0, 0, 768, 860);
    }else{
        tableView_.frame = self.view.bounds;
        tableView_.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (clearsSelectionOnViewWillAppear_) {
        [tableView_ deselectRowAtIndexPath:[tableView_ indexPathForSelectedRow] animated:YES];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

///////////////////////////////////////////////////////
#pragma mark - Setters & Getters

- (void)setPageInfo:(SPPageInfoData *)pageInfo {
    if (pageInfo_ != pageInfo) {
        [pageInfo_ release];
        pageInfo_ = [pageInfo retain];
        
        if ([pageInfo_.mRecordCount intValue] == self.dataArray.count) {
            self.tableView.showsInfiniteScrolling = NO;
        } else {
            self.tableView.showsInfiniteScrolling = YES;
            currentPageNumber_ = [pageInfo_.mPageIndex intValue];
        }
    }
}

///////////////////////////////////////////////////////
#pragma mark -

- (NSUInteger)numberOfSections {
    return 1;
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    return [dataArray_ count];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.0;
    return height;
}

- (UITableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //内存释放11-------------------------------
    return [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER] autorelease];
}

- (void)dressUpCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)createAndConfigCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = CELL_IDENTIFIER;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [self createCellForRowAtIndexPath:indexPath];
        [self dressUpCell:cell atIndexPath:indexPath];
    }
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSString *)titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    return 0.;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    return 0.;
}

- (UIView *)viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

///////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource and UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self createAndConfigCellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didSelectRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self titleForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self viewForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self heightForFooterInSection:section];
}

@end
