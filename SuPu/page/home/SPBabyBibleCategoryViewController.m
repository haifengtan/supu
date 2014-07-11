//
//  SPBabyBibleViewController.m
//  SuPu
//
//  Created by 杨福军 on 12-10-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBabyBibleCategoryViewController.h"
#import "UIImageView+WebCache.h"

@interface SPBabyBibleCategoryViewController ()

@property (retain, nonatomic) SPArticleCategoryListAction *clAction;
@property BOOL isPad;

@end

@implementation SPBabyBibleCategoryViewController
@synthesize clAction = clAction_;
@synthesize isPad;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(clAction_);
    [super dealloc];
}

- (void)viewDidUnload {
    self.clAction = nil;
    [super viewDidUnload];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad {
    self.isPad = iPad;
    [super viewDidLoad];
    
    self.title = @"孕婴宝典";
    self.UMStr = @"孕婴宝典";
  
    
    clAction_ = [[SPArticleCategoryListAction alloc] init];
    clAction_.m_delegate_categoryList = self;
    [clAction_ requestArticleCategoryListData];
    [self showHUD];
 
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

///////////////////////////////////////////////////////
#pragma mark -

- (NSUInteger)numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.dataArray.count;
    return count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 146;
    }else{
        return 73;
    }
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SPArticleCategoryListData *cld = [self.dataArray objectAtIndex:indexPath.row];
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = cld.mCategoryName;
    
    if (iPad) {
        
        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:1]) setImageWithURL:OUO_URL(cld.mPicUrl) placeholderImage:[UIImage imageNamed:@"95-91.png"]];
    }else{
        
        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:1]) setImageWithURL:OUO_URL(cld.mPicUrl) placeholderImage:[UIImage imageNamed:@"60-60.png"]];
    }
 
}

- (UITableViewCell *)createCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //内存警告13
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
    
    UIImageView *picimageview = [[UIImageView alloc] init];
    if (self.isPad) {
        picimageview.frame = CGRectMake(10, 28, 90, 90);
    }else{
        picimageview.frame = CGRectMake(5, 14, 45, 45);
    }
    [cell.contentView addSubview:picimageview];
    [picimageview release];
    return cell;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPArticleCategoryListData *cld = [self.dataArray objectAtIndex:indexPath.row];
    [Go2PageUtility go2BabyBibleArticleListViewControllerWithCateID:cld.mID from:self];
}

///////////////////////////////////////////////////////
#pragma mark - SPArticleCategoryListActionDelegate

-(NSDictionary*)onResponseCategoryListAction {
    return OUO_DICT(@"0", @"ParentId");
}

-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList {
    [self hideHUD];
    [self.tableView.pullToRefreshView stopAnimating];
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:l_arr_categoryList];
    [self.tableView reloadData];
}

-(void)onResponseCategoryListDataFail {
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}


@end
