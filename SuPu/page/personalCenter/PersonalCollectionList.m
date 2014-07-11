//
//  PersonalCollectionList.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalCollectionList.h"
#import "UITableViewPageing.h"
#import "RequestHelper.h"
#import "PageingMessage.h"
#import "GoodsObject.h"
#import "FavoritesObject.h"
#import "SPActionUtility.h"
#import "UITableView+NXEmptyView.h"
#define  KPAGESIZE  20
@interface PersonalCollectionList ()

@property (retain, nonatomic) UITableView *tableView;
 
 
@property BOOL isPad;
@property(nonatomic,assign) int page;
@property(nonatomic,assign) int recordCount;
@property(nonatomic,assign) int deleteRow;

@end

@implementation PersonalCollectionList
@synthesize tableView = tableView_;
  
@synthesize isPad;
@synthesize page;
@synthesize deleteRow;
@synthesize recordCount;
- (void)dealloc
{
    [tableView_ release];
 
    [collectAction release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.tableView  = nil;
 
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.UMStr = @"我的收藏";
    
    self.emptyMessage = @"没有收藏";
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    [self setRightBarButton:@"编辑" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(editCollection:)];
    
     
    self.isPad = iPad;
    UITableView *t_tableView = nil;
    if (self.isPad) {
        t_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 860) style:UITableViewStylePlain];
    }else{
        t_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        t_tableView.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;      
    }

    self.tableView = t_tableView;
    
    [t_tableView release];
    
    
    tableView_.delegate = self;
    tableView_.dataSource = self;
     
    [self.view addSubview:tableView_];
 
    [tableView_ release];
    
       self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = NO;
    
    self.page = 1;
    collectAction = [[SPCollectAction alloc] init];
    collectAction.m_delegate_collect = self;
    [collectAction requestCollectListData];

    [self showHUD];
}
-(NSDictionary *)onRequestCollectAction{
    NSMutableDictionary *requsetDic = [NSMutableDictionary dictionary];
    
    [requsetDic setObject:OUO_NUMBER_INT(self.page) forKey:@"Page"];
    [requsetDic setObject:OUO_NUMBER_INT(KPAGESIZE) forKey:@"PageSize"];
    
    return  requsetDic;
}
-(void)onResponseCollectDataSuccess:(SPPageInfoData *)pageInfo{
    [self hideHUD];
    
    [self.entryArray  addObjectsFromArray:pageInfo.mPageArray];
    
    if ([self.entryArray count]==0) {
        self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = YES;
        self.tableView.nxEV_emptyView = self.emptyView;
    }

    self.recordCount = [pageInfo.mRecordCount intValue];
 
    if ([self.entryArray count] == 0) {
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;        
    }
 
    [self.tableView reloadData];
}
-(void)onResponseCollectDataFail{
    [self hideHUD];
    if (self.page>1)
            self.page -- ;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isPad ? 144 : 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectIdentifier = @"collectioncell";
    CollectionListCell *cell = [tableView dequeueReusableCellWithIdentifier:collectIdentifier];
    if (cell == nil) {
        cell = [[[CollectionListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectIdentifier] autorelease];
    }
    cell.goodsobj = [self.entryArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsObject *goods = [self.entryArray objectAtIndex:indexPath.row];
    
    [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:goods.GoodsSN from:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark 删除表格的某一行的代理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.deleteRow = indexPath.row;
 
    GoodsObject *goods = [self.entryArray objectAtIndex:indexPath.row];
    if (goods) 
    [self deletePersonalCollection:goods.GoodsSN];
     

}

- (void)editCollection:(id)sender
{
    if (self.tableView.editing == NO) {
        [self.tableView setEditing:YES animated:YES];
        [((UIButton *)self.navigationItem.rightBarButtonItem.customView) setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        [self.tableView setEditing:NO animated:YES];
        [((UIButton *)self.navigationItem.rightBarButtonItem.customView) setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

#pragma mark 删除列表某条记录
- (void)deletePersonalCollection:(NSString *)goodssn
{
    NSMutableDictionary *deletepersonaldict = [NSMutableDictionary  dictionary];
    [deletepersonaldict setValue:goodssn forKey:@"GoodsSN"];
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_REMOVEFAVORITES methodName:(NSString *)SP_METHOD_REMOVEFAVORITES memberid:memberid];
    
    if ([SPActionUtility isNetworkReachable])
        [self showHUD];
    [rh RequestUrl:deletepersonaldict succ:@selector(deletePersonalCollectionSucc:) fail:@selector(deletePersonalCollectionFail:) responsedelegate:self];
    
    [rh release];
}

- (void)deletePersonalCollectionSucc:(ASIFormDataRequest *)request
{
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *message = [dict objectForKey:@"Message"];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    if ([errorcode isEqualToString:@"0"]) {
 
        [self.entryArray removeObjectAtIndex:deleteRow];
         
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:deleteRow inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
 
    }
    [self hideHUDWithCompletionMessage:message];
}

- (void)deletePersonalCollectionFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
     
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (([self.entryArray count] - 1 == indexPath.row )&&(indexPath.row < self.recordCount-1)) {
        
        [self showHUD];
        
        self.page ++ ;
      
        [collectAction requestCollectListData];
    }
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
