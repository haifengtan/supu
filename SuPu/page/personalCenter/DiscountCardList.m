//
//  DiscountCardList.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "DiscountCardList.h"
#import "RequestHelper.h"
#import "SVPullToRefresh.h"
#import "UITableViewPageing.h"
#import "PageingMessage.h"
#import "TicketObject.h"
#import "DiscountCardDetail.h"
#import "CheckHelper.h"
#import "SPBalanceAccountViewController.h"
#import "SPGetTicketInfoAction.h"
#import "SPCouponsObject.h"
@interface DiscountCardList ()

@property (retain, nonatomic) UIButton *usedbtn;
@property (retain, nonatomic) UIButton *unusedbtn;
@property (retain, nonatomic) UITableViewPageing *discountcardtableview;
@property (retain, nonatomic) NSMutableArray *discountcardarr;
@property (retain, nonatomic) UITextField *adddiscountfield;
@property (retain, nonatomic) UILabel *cautionlable;
@property BOOL isPad;

@end

@implementation DiscountCardList
@synthesize usedbtn;
@synthesize unusedbtn;
@synthesize discountcardtableview;
@synthesize discountcardarr;
@synthesize adddiscountfield;
@synthesize cautionlable;
@synthesize parentcontrolname;
@synthesize delegate;
@synthesize isPad;
@synthesize fromWhereToThis;
- (void)dealloc
{
    [usedbtn release];
    [unusedbtn release];
    [discountcardtableview release];
    [discountcardarr release];
    [adddiscountfield release];
    [cautionlable release];
    [parentcontrolname release];
    [fromWhereToThis release];
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
    
    [super viewDidLoad];
    
    UIView *topview = nil;
    UIButton *adddiscountbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    usedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    unusedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [usedbtn setExclusiveTouch:YES];
    [unusedbtn setExclusiveTouch:YES];
    if (self.isPad) {
        topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 80)];
        adddiscountfield = [[UITextField alloc] initWithFrame:CGRectMake(40, 10, 500, 60)];
        [adddiscountfield setFont:[UIFont systemFontOfSize:26]];
        adddiscountbtn.frame = CGRectMake(600, 10, 120, 60);
        [adddiscountbtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
        self.usedbtn.frame = CGRectMake(384, 80, 384, 54);
        [self.usedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
        self.unusedbtn.frame = CGRectMake(0, 80, 384, 54);
        [self.unusedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
        discountcardtableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, self.unusedbtn.frame.origin.y+self.unusedbtn.frame.size.height, 768, 810-44-40) style:UITableViewStylePlain];
    }else{
        topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        adddiscountfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, 190, 30)];
        [adddiscountfield setFont:[UIFont systemFontOfSize:13]];
        adddiscountbtn.frame = CGRectMake(240, 5, 60, 30);
        [adddiscountbtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        self.usedbtn.frame = CGRectMake(160, 40, 160, 28);
        [self.usedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        self.unusedbtn.frame = CGRectMake(0, 40, 160, 28);
        [self.unusedbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        discountcardtableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, self.unusedbtn.frame.origin.y+self.unusedbtn.frame.size.height, 320, self.view.bounds.size.height-160) style:UITableViewStylePlain];
    }
    
    topview.backgroundColor = [UIColor redColor];
    
    adddiscountfield.placeholder = @"请输入优惠劵编号";
    adddiscountfield.borderStyle = UITextBorderStyleRoundedRect;
    adddiscountfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    adddiscountfield.delegate = self;
    adddiscountfield.returnKeyType = UIReturnKeyDone;
    [topview addSubview:adddiscountfield];
    
    if ([fromWhereToThis isEqualToString:@"fromSettlementCenter"]) {
        [adddiscountbtn setTitle:@"使用优惠劵" forState:UIControlStateNormal];
    }else
    [adddiscountbtn setTitle:@"添加优惠劵" forState:UIControlStateNormal];
    adddiscountbtn.titleLabel.textColor = [UIColor whiteColor];
    UIImage *adddiscountbtnimage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"顶部登录按钮" ofType:@"png"]];
    [adddiscountbtn setBackgroundImage:adddiscountbtnimage forState:UIControlStateNormal];
    [adddiscountbtnimage release];
    [adddiscountbtn addTarget:self action:@selector(adddiscount:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:adddiscountbtn];
    
    UIImage *normalimage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"按品类按钮2" ofType:@"png"]];
    UIImage *selectedimage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"按品类按钮" ofType:@"png"]];
    
    [self.usedbtn setBackgroundImage:normalimage forState:UIControlStateNormal];
    [self.usedbtn setBackgroundImage:selectedimage forState:UIControlStateSelected];
    [self.usedbtn setTitle:@"已使用" forState:UIControlStateNormal];
    [self.usedbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.usedbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.usedbtn addTarget:self action:@selector(usedselect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.usedbtn];
    
    [self.unusedbtn setBackgroundImage:normalimage forState:UIControlStateNormal];
    [self.unusedbtn setBackgroundImage:selectedimage forState:UIControlStateSelected];
    [self.unusedbtn setTitle:@"未使用" forState:UIControlStateNormal];
    [self.unusedbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.unusedbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.unusedbtn addTarget:self action:@selector(unusedselect:) forControlEvents:UIControlEventTouchUpInside];
    self.unusedbtn.selected = TRUE;
    [self.view addSubview:self.unusedbtn];
    
    [normalimage release];
    [selectedimage release];
    
    [self.view addSubview:topview];
    [topview release];
    
    discountcardtableview.delegate = self;
    discountcardtableview.dataSource = self;
    [self.view addSubview:discountcardtableview];
    [discountcardtableview release];
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
    self.title = @"我的优惠劵";
    self.UMStr= @"我的优惠劵";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:@selector(backToPopView:)];
//    
//    [self.discountcardtableview addPullToRefreshWithActionHandler:^{
        [self.discountcardtableview reloadPageingMessageBeforeSelect];
        [self discountCardListSelect];
//        [self.discountcardtableview.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
//    }];
    [self.discountcardtableview addInfiniteScrollingWithActionHandler:^{
//        [self discountCardListSelect];
        [self.discountcardtableview.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];
//    [self discountCardListSelect];
        if ([SPActionUtility isNetworkReachable])
    [self showHUD];
}

- (void)backToPopView:(id)sender
{
    if (self.parentcontrolname!= nil && [self.parentcontrolname isEqualToString:@"shoppingCart"]) {
        int count = [self.navigationController viewControllers].count;
        SPBalanceAccountViewController *spbavc = [[self.navigationController viewControllers] objectAtIndex:count-2];
        spbavc.ticketno = @"";
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
        UITableViewCell *cell = [spbavc.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"优 惠 劵："];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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

#pragma mark 查询优惠劵

- (void)usedselect:(id)sender
{
    if (self.usedbtn.selected == FALSE) {
        self.usedbtn.selected = !self.usedbtn.selected;
    }
    if (self.usedbtn.selected == TRUE) {
        self.unusedbtn.selected = FALSE;
        [self.discountcardtableview reloadPageingMessageBeforeSelect];
        [self discountCardListSelect];
    }
}

- (void)unusedselect:(id)sender
{
    if (self.unusedbtn.selected == FALSE) {
        self.unusedbtn.selected = !self.unusedbtn.selected;
    }
    if (self.unusedbtn.selected == TRUE) {
        self.usedbtn.selected = FALSE;
        [self.discountcardtableview reloadPageingMessageBeforeSelect];
        [self discountCardListSelect];
    }
}

#pragma mark 搜索的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma -
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [usedbtn setUserInteractionEnabled:NO];
    [unusedbtn setUserInteractionEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [usedbtn setUserInteractionEnabled:YES];
    [unusedbtn setUserInteractionEnabled:YES];
}

#pragma mark 表格的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discountcardarr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 145;
    }else{
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"discountcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        UIImageView *cellbackgroundview = [[UIImageView alloc] initWithFrame:cell.bounds];
        cellbackgroundview.image = [UIImage imageNamed:@"背景.png"];
        cell.backgroundView = cellbackgroundview;
        [cellbackgroundview release];
        
        UIImageView *detailpic= nil;
        UILabel *ticketnametiplabel = nil;
        UILabel *ticketnotiplabel= nil;
        UILabel *ticketstatustiplabel = nil;
        UILabel *ticketnamemessagelabel = nil;
        UILabel *ticketnomessagelabel = nil;
        UILabel *ticketstatusmessagelabel = nil;
        if (self.isPad) {
            detailpic = [[UIImageView alloc] initWithFrame:CGRectMake(730, 50, 14, 22)];
            ticketnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 400, 30)];
            ticketnametiplabel.font = [UIFont boldSystemFontOfSize:24];
            ticketnotiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 56, 80, 30)];
            ticketnotiplabel.font = [UIFont boldSystemFontOfSize:24];
            ticketstatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 180, 30)];
            ticketstatustiplabel.font = [UIFont boldSystemFontOfSize:24];
            ticketnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 440, 30)];
            ticketnamemessagelabel.font = [UIFont boldSystemFontOfSize:24];
            ticketnomessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 56, 610, 30)];
            ticketnomessagelabel.font = [UIFont boldSystemFontOfSize:24];
            ticketstatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 100, 610, 30)];
            ticketstatusmessagelabel.font = [UIFont boldSystemFontOfSize:24];
        }else{
            detailpic = [[UIImageView alloc] initWithFrame:CGRectMake(290, 27, 7, 11)];
            ticketnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 75, 15)];
            ticketnametiplabel.font = [UIFont boldSystemFontOfSize:12];
            ticketnotiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 28, 40, 15)];
            ticketnotiplabel.font = [UIFont boldSystemFontOfSize:12];
            ticketstatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 40, 15)];
            ticketstatustiplabel.font = [UIFont boldSystemFontOfSize:12];
            ticketnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, 220, 15)];
            ticketnamemessagelabel.font = [UIFont boldSystemFontOfSize:12];
            ticketnomessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 28, 255, 15)];
            ticketnomessagelabel.font = [UIFont boldSystemFontOfSize:12];
            ticketstatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 255, 15)];
            ticketstatusmessagelabel.font = [UIFont boldSystemFontOfSize:12];
        }
        
        detailpic.image = [UIImage imageNamed:@"小箭头.png"];
        [cell.contentView addSubview:detailpic];
        [detailpic release];
        
        ticketnametiplabel.backgroundColor = [UIColor clearColor];
        ticketnametiplabel.text = @"优惠劵名称：";
        [cell.contentView addSubview:ticketnametiplabel];
        [ticketnametiplabel release];
        
        ticketnotiplabel.backgroundColor = [UIColor clearColor];
        ticketnotiplabel.text = @"编号：";
        [cell.contentView addSubview:ticketnotiplabel];
        [ticketnotiplabel release];
        
        ticketstatustiplabel.backgroundColor = [UIColor clearColor];
        ticketstatustiplabel.text = @"状态：";
        [cell.contentView addSubview:ticketstatustiplabel];
        [ticketstatustiplabel release];
        
        ticketnamemessagelabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:ticketnamemessagelabel];
        [ticketnamemessagelabel release];
        
        ticketnomessagelabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:ticketnomessagelabel];
        [ticketnomessagelabel release];
        
        ticketstatusmessagelabel.backgroundColor = [UIColor clearColor];
        ticketstatusmessagelabel.textColor = [UIColor redColor];
        [cell.contentView addSubview:ticketstatusmessagelabel];
        [ticketstatusmessagelabel release];
    }
    TicketObject *to = [self.discountcardarr objectAtIndex:indexPath.row];
    ((UILabel *)[cell.contentView.subviews objectAtIndex:4]).text = to.TicketName;
    ((UILabel *)[cell.contentView.subviews objectAtIndex:5]).text = to.TicketNo;
//    券状态，1：正常，2：锁定，3：删除

    if (![to.IsUsed isEqualToString:@"False"]) {
        ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"已使用";
    }else if([self outTime:to.EndTime]){
         ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"过期";
    }else{
        ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"未过期";
    }
    
//    if (to.Status!=nil && [to.Status isEqualToString:@"1"]) {
//        ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"正常";
//    }
//    if (to.Status!=nil && [to.Status isEqualToString:@"2"]) {
//        ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"锁定";
//    }
//    if (to.Status!=nil && [to.Status isEqualToString:@"3"]) {
//        ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = @"删除";
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    int  totalPage = self.discountcardtableview.totalcount;
    if (([self.discountcardarr count] - 1 == indexPath.row )&&(indexPath.row < totalPage-1)) {
        [self.discountcardtableview setShowsInfiniteScrolling:YES];
        [self performSelector:@selector(discountCardListSelect) withObject:nil afterDelay:0.5];
    }else{
        [self.discountcardtableview.infiniteScrollingView stopAnimating];
        [self.discountcardtableview setShowsInfiniteScrolling:NO];
    }
}

-(BOOL)outTime:(NSString *)etime{
    double entime = [etime doubleValue];
    NSDate *datenow = [NSDate date];
    double ctime = [datenow timeIntervalSince1970];
    if (ctime>entime) {
        return YES;
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.parentcontrolname!= nil && [self.parentcontrolname isEqualToString:@"personalCenter"]) {
        DiscountCardDetail *dcd = [[DiscountCardDetail alloc] init];
        dcd.ticketobject = [self.discountcardarr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:dcd animated:YES];
        [dcd release];
    }
    if (self.parentcontrolname!= nil && [self.parentcontrolname isEqualToString:@"shoppingCart"]) {
        TicketObject *to = [self.discountcardarr objectAtIndex:indexPath.row];
        if (to.IsUsed!=nil && [to.IsUsed isEqualToString:@"True"]) {
            [UIViewHealper helperBasicUIAlertView:@"提示" message:@"该优惠劵已使用过，请重新选择"];
        }else{
            SPGetTicketInfoAction *tickerinfoaction = [[SPGetTicketInfoAction alloc] init];
            [tickerinfoaction requestData:SP_URL_GETTICKETINFO methodName:SP_METHOD_GETTICKETINFO createParaBlock:^NSDictionary *{
                return [NSDictionary dictionaryWithObjectsAndKeys:to.TicketNo,@"TicketNo", nil];
            } requestSuccessBlock:^(id ticketmessage) {
                NSDictionary *dict = (NSDictionary *)ticketmessage;
                if ([[dict valueForKey:@"ErrorCode"] isEqualToString:@"0"]) {
                    if ([[[dict valueForKey:@"Data"] valueForKey:@"ValidateResult"] isEqualToString:@"可使用此优惠券"]) {
                        if (self.delegate) {
                            float discounttempvalue = [[[[dict valueForKey:@"Data"] valueForKey:@"Ticket"] valueForKey:@"DiscountAmount"] floatValue];
                            [self.delegate tableViewPassTicketDiscount:to.TicketNo discount:discounttempvalue];
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [UIViewHealper helperBasicUIAlertView:@"速普提示" message:[[dict valueForKey:@"Data"] valueForKey:@"ValidateResult"]];
                    }
                }
            } requestFailureBlock:^(ASIHTTPRequest *request) {
                
            }];
            [tickerinfoaction release];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 查询列表的方法
- (void)discountCardListSelect
{
        if ([SPActionUtility isNetworkReachable])
     [self showHUD];
    NSMutableDictionary *discountcarddict = [[NSMutableDictionary alloc] init];
    [discountcarddict setValue:[self.discountcardtableview pageStringValue] forKey:@"Page"];
    [discountcarddict setValue:[self.discountcardtableview pageNumStringValue] forKey:@"PageSize"];
    if (self.unusedbtn.selected == TRUE) {
        [discountcarddict setValue:@"0" forKey:@"IsUsed"];
    }
    if (self.usedbtn.selected == TRUE) {
        [discountcarddict setValue:@"1" forKey:@"IsUsed"];
    }
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETTICKETLIST methodName:(NSString *)SP_METHOD_GETTICKETLIST memberid:memberid];
    [rh RequestUrl:discountcarddict succ:@selector(discountCardListSelectSucc:) fail:@selector(personalCollectionListSelectFail:) responsedelegate:self];
    [discountcarddict release];
    [rh release];
}

- (void)discountCardListSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    PageingMessage *pm = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[PageingMessage class] keyPath:@"Data.PageInfo" keyPathDeep:nil];
    NSArray *discountcardlist = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[TicketObject class] keyPath:@"Data.TicketList" keyPathDeep:nil];
    self.discountcardarr = [self.discountcardtableview setPageingMessage:pm.RecordCount.intValue tableviewarray:discountcardlist];
    
    if (self.discountcardarr.count == 0) {
        self.discountcardtableview.hidden = YES;
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
        if (self.isPad) {
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(220, 140, 320, 764) title:@"没有优惠劵"];
        }else{
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 70, 320, 480-170) title:@"没有优惠劵"];
        }
        [self.view addSubview:self.cautionlable];
    }else{
        self.discountcardtableview.hidden = NO;
        [self.discountcardtableview reloadData];
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
    }
     [self.discountcardtableview.infiniteScrollingView stopAnimating];
}

- (void)discountCardListSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
     [self.discountcardtableview.infiniteScrollingView stopAnimating];
}

#pragma mark 添加优惠劵
- (void)adddiscount:(id)sender
{
 
    
    SPUseCouponsAction *couponsAction = [[SPUseCouponsAction alloc] init];
    [couponsAction setM_delegate_orderList:self];
    [couponsAction requestPersonalInfomationData];
    //内存警告6
    [couponsAction release];
}

- (void)adddiscountSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    NSString *message = [dict objectForKey:@"Message"];
    [UIViewHealper helperBasicUIAlertView:@"提示" message:message];
    if ([errorcode isEqualToString:@"0"]) {
        [self.discountcardtableview reloadPageingMessageBeforeSelect];
        [self discountCardListSelect];
    }
    self.adddiscountfield.text = @"";
}

- (void)adddiscountFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

#pragma mark =======SPUseCouponsActionDelegate
-(NSDictionary *)onRequestUseCouponsAction{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:adddiscountfield.text,@"TicketNo", nil];
    
    return dict;
}
-(void)onResponseUseCouponsActionDataSuccess:(SPCouponsObject *)l_data_orderList{
    if([l_data_orderList.m_ErrorCode isEqualToString:@"0"]){
        if (self.delegate) {
            float discounttempvalue = [l_data_orderList.m_DiscountAmount floatValue];
            [self.delegate tableViewPassTicketDiscount:l_data_orderList.m_TicketNo discount:discounttempvalue];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    }
}
-(void)onResponseUseCouponsActionDataFail{

}
@end
