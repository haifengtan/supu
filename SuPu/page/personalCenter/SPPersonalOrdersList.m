//
//  SPPersonalOrdersList.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-20.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPPersonalOrdersList.h"
#import "SVPullToRefresh.h"
#import "RequestHelper.h"
#import "UITableViewPageing.h"
#import "PageingMessage.h"
#import "PersonalOrderDetail.h"

@interface SPPersonalOrdersList ()

@property (retain, nonatomic) UIButton *unfinishedbtn;
@property (retain, nonatomic) UIButton *allbtn;
@property (retain, nonatomic) UIButton *canceledbtn;
@property (retain, nonatomic) NSMutableArray *poarr;
@property (retain, nonatomic) UITableViewPageing *orderlisttableview;
@property (retain, nonatomic) UILabel *cautionlable;
@property BOOL isPad;
@property (retain, nonatomic)RequestHelper *rh;

@end

@implementation SPPersonalOrdersList
@synthesize unfinishedbtn;
@synthesize allbtn;
@synthesize canceledbtn;
@synthesize poarr;
@synthesize orderlisttableview;
@synthesize cautionlable;
@synthesize isPad;
@synthesize rh;

- (void)dealloc
{
    [unfinishedbtn release];
    [allbtn release];
    [canceledbtn release];
    [poarr release];
    [orderlisttableview release];
    [cautionlable release];
    [super dealloc];
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
    self.isPad = iPad;
    UIView *buttonview = nil;
    __block typeof (self)bself = self;
    self.unfinishedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.unfinishedbtn setExclusiveTouch:YES];
    self.allbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allbtn setExclusiveTouch:YES];
    self.canceledbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.canceledbtn setExclusiveTouch:YES];
    if (self.isPad) {
        buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 54)];
        self.unfinishedbtn.frame = CGRectMake(1, 1, 255, 52);
        [self.unfinishedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
        self.allbtn.frame = CGRectMake(257, 1, 255, 52);
        [self.allbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
        self.canceledbtn.frame = CGRectMake(513, 1, 255, 52);
        [self.canceledbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
        orderlisttableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, 55, 768,810) style:UITableViewStylePlain];
    }else{
        buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        self.unfinishedbtn.frame = CGRectMake(1, 1, 105, 28);
        [self.unfinishedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        self.allbtn.frame = CGRectMake(107, 1, 105, 28);
        [self.allbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        self.canceledbtn.frame = CGRectMake(213, 1, 105, 28);
        [self.canceledbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        orderlisttableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, 30, 320, [SPStatusUtility getScreenHeight] - kNavHeight - kTabbarHeight -20 -  30) style:UITableViewStylePlain];
    }
    
    [self.unfinishedbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮灰色.png"] forState:UIControlStateNormal];
    [self.unfinishedbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮.png"] forState:UIControlStateSelected];
    [self.unfinishedbtn setTitle:@"未完成" forState:UIControlStateNormal];
    [self.unfinishedbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.unfinishedbtn addTarget:self action:@selector(unfinishedselect:) forControlEvents:UIControlEventTouchUpInside];
    self.unfinishedbtn.selected = TRUE;
    [buttonview addSubview:self.unfinishedbtn];
    
    [self.allbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮灰色.png"] forState:UIControlStateNormal];
    [self.allbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮.png"] forState:UIControlStateSelected];
    [self.allbtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.allbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.allbtn addTarget:self action:@selector(allselect:) forControlEvents:UIControlEventTouchUpInside];
    [buttonview addSubview:self.allbtn];
    
    [self.canceledbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮灰色.png"] forState:UIControlStateNormal];
    [self.canceledbtn setBackgroundImage:[UIImage imageNamed:@"销量按钮.png"] forState:UIControlStateSelected];
    [self.canceledbtn setTitle:@"已完成" forState:UIControlStateNormal];
    [self.canceledbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.canceledbtn addTarget:self action:@selector(canceledselect:) forControlEvents:UIControlEventTouchUpInside];
    [buttonview addSubview:self.canceledbtn];
    
    [self.view addSubview:buttonview];
    [buttonview release];
    
    //tableview
    orderlisttableview.delegate = self;
    orderlisttableview.dataSource =self;
//    self.orderlisttableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    orderlisttableview.separatorColor = [UIColor grayColor];
    [self.view addSubview:orderlisttableview];
    
    self.title = @"我的订单";
    self.UMStr = @"我的订单";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    if ([SPActionUtility isNetworkReachable])
     [self showHUD];
    
    [self.orderlisttableview reloadPageingMessageBeforeSelect];
    [self personalOrdersListSelect];

    [self.orderlisttableview addInfiniteScrollingWithActionHandler:^{
 
        self.orderlisttableview.showsInfiniteScrolling = YES;
        [bself.orderlisttableview.infiniteScrollingView startAnimating];
    }];
 
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)unfinishedselect:(id)sender
{   
    if (self.unfinishedbtn.selected == NO) {
        self.unfinishedbtn.selected = !self.unfinishedbtn.selected;
    }
    if (self.unfinishedbtn.selected == YES) {
        [self.unfinishedbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.allbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.canceledbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.allbtn.selected = NO;
        self.canceledbtn.selected = NO;
        [self.orderlisttableview reloadPageingMessageBeforeSelect];
        [self personalOrdersListSelect];
    }
}

- (void)allselect:(id)sender
{  
    if (self.allbtn.selected == NO) {
        self.allbtn.selected = !self.allbtn.selected;
    }
    if (self.allbtn.selected == YES) {
        [self.allbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.unfinishedbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.canceledbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.unfinishedbtn.selected = NO;
        self.canceledbtn.selected = NO;
        [self.orderlisttableview reloadPageingMessageBeforeSelect];
        [self personalOrdersListSelect];
    }
}

- (void)canceledselect:(id)sender
{   
    if (self.canceledbtn.selected == NO) {
        self.canceledbtn.selected = !self.canceledbtn.selected;
    }
    if (self.canceledbtn.selected == YES) {
        [self.canceledbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.allbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.unfinishedbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.unfinishedbtn.selected = NO;
        self.allbtn.selected = NO;
        [self.orderlisttableview reloadPageingMessageBeforeSelect];
        [self personalOrdersListSelect];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.poarr.count == 0) {

        orderlisttableview.separatorStyle = UITableViewCellSelectionStyleNone;

    }else{
        self.orderlisttableview.separatorStyle = UITableViewCellSelectionStyleGray;
    }
    return self.poarr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 143.0f;
    }else{
        return 75;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *orderlistcellstr = @"orderlistcellstr";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:orderlistcellstr];
    if (cell == nil) {
        cell = [[[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderlistcellstr] autorelease];
    }
    NSInteger row = indexPath.row;
    cell.personalorderobj = [self.poarr objectAtIndex:row];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    int  totalPage = self.orderlisttableview.totalcount;
    if (([self.poarr count] - 1 == indexPath.row )&&(indexPath.row < totalPage-1)) {
        [self.orderlisttableview setShowsInfiniteScrolling:YES];
            if ([SPActionUtility isNetworkReachable])
        [self showHUD];
        [self performSelector:@selector(personalOrdersListSelect) withObject:nil afterDelay:0.5];
    }else{
        [self.orderlisttableview setShowsInfiniteScrolling:NO];
    }
}

#pragma -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.allbtn setUserInteractionEnabled:NO];
    [self.unfinishedbtn setUserInteractionEnabled:NO];
    [self.canceledbtn setUserInteractionEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.allbtn setUserInteractionEnabled:YES];
    [self.unfinishedbtn setUserInteractionEnabled:YES];
    [self.canceledbtn setUserInteractionEnabled:YES];
}



#pragma mark 查询列表的方法
- (void)personalOrdersListSelect
{
    if ([SPActionUtility isNetworkReachable])
     [self showHUD];
    NSMutableDictionary *personalordersdict = [NSMutableDictionary dictionary];
    [personalordersdict setValue:[self.orderlisttableview pageStringValue] forKey:@"Page"];
    [personalordersdict setValue:[self.orderlisttableview pageNumStringValue] forKey:@"PageSize"];
    if (self.allbtn.selected == YES) {
        
        [personalordersdict setValue:@"0" forKey:@"State"];//0是全部，1是未完成，2是已完成，默认值是0
    }
    if (self.unfinishedbtn.selected == YES) {
        
        [personalordersdict setValue:@"1" forKey:@"State"];//0是全部，1是未完成，2是已完成，默认值是0
    }
    if (self.canceledbtn.selected == YES) {// 已完成
        
        [personalordersdict setValue:@"2" forKey:@"State"];//0是全部，1是未完成，2是已完成，默认值是0
    }
    NSString *memberid = [self getMemberId:@"memberdata"];
    //内存警告5
    rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETORDERLIST methodName:(NSString *)SP_METHOD_GETORDERLIST memberid:memberid];
 
    [rh RequestUrl:personalordersdict succ:@selector(personalOrdersListSelectSucc:) fail:@selector(personalOrdersListSelectFail:) responsedelegate:self];
 
    
    [rh release];
}

- (void)personalOrdersListSelectSucc:(ASIFormDataRequest *)request
{
    DLog(@"%@",request.responseString);
    [self hideHUD];
    PageingMessage *pm = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[PageingMessage class] keyPath:@"Data.PageInfo" keyPathDeep:nil];
    NSArray *resulstarr = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[PersonalOrder class] keyPath:@"Data.OrderList" keyPathDeep:nil];
    self.poarr = [self.orderlisttableview setPageingMessage:pm.RecordCount.intValue tableviewarray:resulstarr];
    if (self.poarr.count == 0) {
        self.orderlisttableview.hidden = YES;
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
        if (self.isPad) {
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 55, 768, 900) title:@"没有订单"];
        }else{
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 30, 320, 480-130) title:@"没有订单"];
        }
        [self.view addSubview:self.cautionlable];
    }else{
        self.orderlisttableview.hidden = NO;
        [self.orderlisttableview reloadData];
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
    }
    [self.orderlisttableview.infiniteScrollingView stopAnimating];
    
   
}

- (void)personalOrdersListSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [self.orderlisttableview.infiniteScrollingView stopAnimating];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalOrder *personOrder = [self.poarr objectAtIndex:indexPath.row];

    [Go2PageUtility go2OrderDetailsViewController:self orderNo:personOrder.OrderSN isBackStyle:NO];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
