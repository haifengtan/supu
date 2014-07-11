//
//  SPProductCommentViewController.m
//  SuPu
//
//  Created by 杨福军 on 12-11-4.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductCommentViewController.h"
#import "SPProductCommentCell.h"
#import "UITableView+NXEmptyView.h"
@interface SPProductCommentViewController ()
@property (retain, nonatomic) SPProductCommentListAction *clAction;
@property BOOL isPad;
@property (retain, nonatomic) UILabel *cautionlable;
@end

@implementation SPProductCommentViewController
@synthesize goodsSN = goodsSN_;
@synthesize clAction = clAction_;
@synthesize isPad;
@synthesize cautionlable;
@synthesize tableView = tableView_;
@synthesize pageInfo = pageInfo_;
///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(tableView_);
    OUOSafeRelease(goodsSN_);
    OUOSafeRelease(clAction_);
    OUOSafeRelease(cautionlable);
    DLog(@"----------------delloce------------------------------");

    [super dealloc];
}

- (void)viewDidUnload {
   
    self.clAction = nil;
    self.cautionlable = nil;
    self.tableView = nil;
    [super viewDidUnload];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    clAction_.m_delegate_productCommentList = nil;
    [self hideHUD];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    clAction_.m_delegate_productCommentList = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self hideHUD];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)viewDidLoad
{
  
    [super viewDidLoad];
    
    self.isPad = iPad;
    
    self.title = @"购买评论";
    self.UMStr= @"购买评论";
    
    tableView_ = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    if(isPad){
        tableView_.frameHeight = self.view.frameHeight - 50;
    }
    tableView_.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    tableView_.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:tableView_];
    

    self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = YES;
    
    currentPageNumber = 1;
    clAction_ = [[SPProductCommentListAction alloc] init];
    clAction_.m_delegate_productCommentList = self;
    [clAction_ requestProductCommentListData];
    [self showHUD];
    
}

///////////////////////////////////////////////////////
#pragma mark -


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger count = self.entryArray.count;
     
    if (count==0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPProductCommentData *pcd = [self.entryArray objectAtIndex:indexPath.row];

    return [SPProductCommentCell heightForComment:pcd.content];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    SPProductCommentCell  *cell = (SPProductCommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        if (isPad) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SPProductCommentPadCell" owner:nil options:nil] objectAtIndex:0];
        }else{
            
            cell = [SPProductCommentCell loadFromNIB];
            
        }
    }
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
    
}
- (void)configCell:(SPProductCommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    SPProductCommentData *pcd = [self.entryArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = pcd.time;
    cell.commentLabel.text = pcd.content;
    cell.memberLabel.text = pcd.member.maccount;
    
    UIImage *imagelevel = [UIImage imageNamed:[NSString stringWithFormat:@"level-%d.gif",[pcd.member.mlevel intValue]]];
    CGRect rect = CGRectZero;
    
    if (iPad) {
        rect = CGRectMake(530, 12, imagelevel.size.width, imagelevel.size.height);
        
    }else {
        rect = CGRectMake(191, 10, imagelevel.size.width, imagelevel.size.height);
    }
    cell.levelimage.frame = rect;
    cell.levelimage.image = imagelevel;
    cell.ratingBar.rating = [pcd.goodsScore doubleValue];
    UIImageView *bgview = [[UIImageView alloc] initWithFrame:cell.bounds];
    bgview.image = [UIImage imageNamed:@"背景.png"];
    cell.backgroundView = bgview;
    [bgview release];
}
//
///////////////////////////////////////////////////////
#pragma mark - SPProductCommentListActionDelegate

- (NSDictionary*)onResponseProductCommentListAction {
    return OUO_DICT(
                    goodsSN_, @"GoodsSN",
                    @"9", @"PageSize",
                    OUO_STRING_FORMAT(@"%d", currentPageNumber), @"Page"
                    );
}

- (void)onResponseProductCommentListDataSuccess:(SPProductCommentListData *)l_data_productCommentList {
    
    [self hideHUD];

    if (currentPageNumber == 0) {      ///刷新
        [self.entryArray removeAllObjects];
        [self.entryArray addObjectsFromArray:l_data_productCommentList.comments];
    } else {                                    ///加载更多
        [self.entryArray addObjectsFromArray:l_data_productCommentList.comments];
    }
    
    if ([self.entryArray count]==0) {
        self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = YES;
        self.m_str_noresultText=@"没有评论信息";
        self.tableView.nxEV_emptyView = self.emptyView;
    }
    
//    if (self.entryArray.count == 0) {
//        if (self.cautionlable!=nil) {
//            [self.cautionlable removeFromSuperview];
//            self.cautionlable = nil;
//        }
//        if (isPad) {
//            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 0, 768, 854) title:@"没有评论信息"];
//        }else{
//            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 0, 320, 480-100) title:@"没有评论信息"];
//        }
//        [self.view addSubview:self.cautionlable];
//    }else{
//        if (self.cautionlable!=nil) {
//            [self.cautionlable removeFromSuperview];
//            self.cautionlable = nil;
//        }
//    }
    
    
    self.pageInfo = l_data_productCommentList.pageInfo;
    [self.tableView reloadData];
}

- (void)onResponseProductCommentListDataFail {
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    int  totalPage = [self.pageInfo.mRecordCount intValue];
    if (([self.entryArray count] - 1 == indexPath.row )&&(indexPath.row < totalPage-1)) {
        
        currentPageNumber ++ ;
        [self showHUD];
        [self.clAction requestProductCommentListData];
    }else{
        //        [self.orderlisttableview setShowsInfiniteScrolling:NO];
    }
    
    
}

@end
