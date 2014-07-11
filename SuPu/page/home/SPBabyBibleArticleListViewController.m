//
//  SPBabyBibleArticleListViewController.m
//  SuPu
//
//  Created by 杨福军 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBabyBibleArticleListViewController.h"

@interface SPBabyBibleArticleListViewController ()

@property (copy, nonatomic) NSString *cateID;
@property (retain, nonatomic) SPArticleListAction *alAction;
@property BOOL isPad;

@end

@implementation SPBabyBibleArticleListViewController
@synthesize alAction = alAction_;
@synthesize cateID = cateID_;
@synthesize isPad;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(alAction_);
    OUOSafeRelease(cateID_);
    [super dealloc];
}

- (void)viewDidUnload {
    self.alAction = nil;
 
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithCategoryID:(NSString *)cateID {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.cateID = cateID;
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isPad = iPad;
    
    self.title = @"孕婴宝典";
    self.UMStr = @"孕婴宝典";
      
    alAction_ = [[SPArticleListAction alloc] init];
    alAction_.m_delegate_articleList = self;
    [alAction_ requestArticleListData];
    [self showHUD];
  
}

///////////////////////////////////////////////////////
#pragma mark - SPArticleListActionDelegate

-(NSDictionary*)onResponseArticleListAction {
 
    return OUO_DICT(
                    cateID_, @"categoryId",
                    @"1", @"page",
                    @"20", @"pageSize"
                    );
}

-(void)onResponseArticleListDataSuccess:(SPArticleListData *)l_data_articleList {
    [self hideHUD];
    [self.tableView.pullToRefreshView stopAnimating];

    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:l_data_articleList.mArticleListArray];
    [self.tableView reloadData];
}

-(void)onResponseArticleListDataFail {
    [self hideHUD];
}

///////////////////////////////////////////////////////
#pragma mark -

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.dataArray.count;
    return count;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SPArticleItemData *aid = [self.dataArray objectAtIndex:indexPath.row];
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = aid.mTitle;
}

- (UITableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER] autorelease];
    UILabel *categorylable = nil;
    if (self.isPad) {
        categorylable = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 500, 46)];
        [categorylable setFont:[UIFont boldSystemFontOfSize:28]];
    }else{
        categorylable = [[UILabel alloc] initWithFrame:CGRectMake(55, 26, 200, 25)];
        [categorylable setFont:[UIFont boldSystemFontOfSize:18]];
    }
    categorylable.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:categorylable];
    [categorylable release];
    return cell;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPArticleItemData *aid = [self.dataArray objectAtIndex:indexPath.row];
    [Go2PageUtility go2BabyBibleArticleDetailViewControllerWithArticleID:aid.mID from:self];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 146;
    }else{
        return 73;
    }
}

@end
