//
//  DiscountCardDetail.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "DiscountCardDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "RequestHelper.h"
#import "TicketDetail.h"
#import "SPActionUtility.h"
#define leftWidth 1
@interface DiscountCardDetail ()

@property (retain, nonatomic) UIView *discountdetailview;
@property BOOL isPad;

@end

@implementation DiscountCardDetail
@synthesize ticketobject;
@synthesize discountdetailview;
@synthesize isPad;

- (void)dealloc
{
    [ticketobject release];
    [discountdetailview release];
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
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *backgroundimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"背景" ofType:@"jpg"]];
    backgroundview.image = backgroundimage;

    [self.view addSubview:backgroundview];
    [backgroundview release];
    
    CGRect rect = CGRectZero;
    if (iPad) {
        rect = CGRectMake(40, 50, 680, 760);
    }else {
        rect = CGRectMake(8, 20, 304, [SPStatusUtility getScreenHeight] - 20 - kTabbarHeight - kNavHeight - 30);
    }
    
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    discountdetailview = [[UIView alloc] init];
    discountdetailview.layer.cornerRadius = 10;//调节圆角的大小，数值越大，圆角的拐弯越大
    discountdetailview.layer.masksToBounds = YES;
    discountdetailview.backgroundColor = [UIColor whiteColor];
    
    bgScrollView.layer.cornerRadius = 10;//调节圆角的大小，数值越大，圆角的拐弯越大
    bgScrollView.layer.masksToBounds = YES;
    bgScrollView.backgroundColor = [UIColor whiteColor];
   
    [bgScrollView addSubview:discountdetailview];
    [self.view addSubview:bgScrollView];
    [bgScrollView release];
    
    self.title =@"我的优惠劵";
    self.UMStr =@"我的优惠劵";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    [self discountCardDetailSelect];
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

#pragma mark 查询优惠劵具体信息
- (void)discountCardDetailSelect
{
    NSMutableDictionary *discountcarddict = [[NSMutableDictionary alloc] init];
    [discountcarddict setValue:self.ticketobject.TicketNo forKey:@"TicketNo"];
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETTICKET methodName:(NSString *)SP_METHOD_GETTICKET memberid:memberid];
    
    if ([SPActionUtility isNetworkReachable])
     [self showHUD];
    [rh RequestUrl:discountcarddict succ:@selector(discountCardDetailSelectSucc:) fail:@selector(discountCardDetailSelectFail:) responsedelegate:self];
    [discountcarddict release];
    [rh release];
}

- (void)discountCardDetailSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    if ([errorcode isEqualToString:@"0"]) {
        TicketDetail *td = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[TicketDetail class] keyPath:@"Data.Ticket" keyPathDeep:nil];
        
        CGSize contentsize;
        if (self.isPad) {
            contentsize = [td.TicketDescribe sizeWithFont:[UIFont boldSystemFontOfSize:28] constrainedToSize:CGSizeMake(460, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
            self.discountdetailview.frame = CGRectMake(10, 50, 680, 400+contentsize.height);
            UIScrollView *view = (UIScrollView *)[self.discountdetailview superview];
            view.contentSize = CGSizeMake( 680, 400+contentsize.height);
        }else{
            contentsize = [td.TicketDescribe sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(220, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
            self.discountdetailview.frame = CGRectMake(10, 25, 300, 200+contentsize.height);
            UIScrollView *view = (UIScrollView *)[self.discountdetailview superview];
            view.contentSize = CGSizeMake(300, 200+contentsize.height);
//            self.discountdetailview.frame = CGRectMake(10, 75, 300, 200+contentsize.height);
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSDate *begindate = [NSDate dateWithTimeIntervalSince1970:td.BeginTime.doubleValue];
        td.BeginTimeDate = [formatter stringFromDate:begindate];
        NSDate *enddate = [NSDate dateWithTimeIntervalSince1970:td.EndTime.doubleValue];
        td.EndTimeDate = [formatter stringFromDate:enddate];
        [formatter release];
        
        UILabel *ticketnametiplabel = nil;
        UILabel *ticketnamemessagelabel = nil;
        UILabel *ticketnotiplabel = nil;
        UILabel *ticketnomessagelabel = nil;
        UILabel *ticketcontenttiplabel = nil;
        UILabel *ticketcontentmessagelabel= nil;
        UILabel *ticketstarttimetiplabel = nil;
        UILabel *ticketstarttimemessagelabel = nil;
        UILabel *ticketendtimetiplabel =nil;
        UILabel *ticketendtimemessagelabel = nil;
        if (self.isPad) {
            ticketnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 20, 170, 40)];
            ticketnametiplabel.font = [UIFont boldSystemFontOfSize:28];
            ticketnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 20, 410, 40)];
            ticketnamemessagelabel.font = [UIFont boldSystemFontOfSize:28];
            ticketnotiplabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 66, 170, 40)];
            ticketnotiplabel.font = [UIFont boldSystemFontOfSize:28];
            ticketnomessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 66, 410, 40)];
            ticketnomessagelabel.font = [UIFont boldSystemFontOfSize:28];
            ticketcontenttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 112, 140, 40)];
            ticketcontenttiplabel.font = [UIFont boldSystemFontOfSize:28];
            ticketcontentmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 112, 500, contentsize.height+3)];
            ticketcontentmessagelabel.font = [UIFont boldSystemFontOfSize:28];
            ticketstarttimetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 112+contentsize.height+12, 140, 40)];  
            ticketstarttimetiplabel.font = [UIFont boldSystemFontOfSize:28];
            ticketstarttimemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 112+contentsize.height+12,440,40)];
            ticketstarttimemessagelabel.font = [UIFont boldSystemFontOfSize:28];
            ticketendtimetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 158+contentsize.height+12, 140, 40)];
            ticketendtimetiplabel.font = [UIFont boldSystemFontOfSize:28];
            ticketendtimemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(158, 158+contentsize.height+12,440,40)];
            ticketendtimemessagelabel.font = [UIFont boldSystemFontOfSize:28];
        }else{
            ticketnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, 20, 85, 20)];
            ticketnametiplabel.font = [UIFont boldSystemFontOfSize:14];
            ticketnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(95-7, 20, 205, 20)];
            ticketnamemessagelabel.font = [UIFont boldSystemFontOfSize:14];
            ticketnotiplabel = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, 43, 85, 20)];
            ticketnotiplabel.font = [UIFont boldSystemFontOfSize:14];
            ticketnomessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(95-7, 43, 205, 20)];
            ticketnomessagelabel.font = [UIFont boldSystemFontOfSize:14];
            ticketcontenttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, 66, 70, 20)];
            ticketcontenttiplabel.font = [UIFont boldSystemFontOfSize:14];
            ticketcontentmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(79-7, 66, 220, contentsize.height+3)];
            ticketcontentmessagelabel.font = [UIFont boldSystemFontOfSize:14];
            ticketstarttimetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, 66+contentsize.height+6, 70, 20)];
            ticketstarttimetiplabel.font = [UIFont boldSystemFontOfSize:14];
            ticketstarttimemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(79-7, 66+contentsize.height+6,220,20)];
            ticketstarttimemessagelabel.font = [UIFont boldSystemFontOfSize:14];
            ticketendtimetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(leftWidth, 89+contentsize.height+6, 70, 20)];
            ticketendtimetiplabel.font = [UIFont boldSystemFontOfSize:14];
            ticketendtimemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(79-7, 89+contentsize.height+6,220,20)];
            ticketendtimemessagelabel.font = [UIFont boldSystemFontOfSize:14];
        }
        ticketnametiplabel.backgroundColor = [UIColor clearColor];
        ticketnametiplabel.text = @"优惠劵名称：";
        [self.discountdetailview addSubview:ticketnametiplabel];
        [ticketnametiplabel release];
        
        ticketnamemessagelabel.backgroundColor = [UIColor clearColor];
        ticketnamemessagelabel.text = td.TicketName;
        [self.discountdetailview addSubview:ticketnamemessagelabel];
        [ticketnamemessagelabel release];
        
        ticketnotiplabel.backgroundColor = [UIColor clearColor];
        ticketnotiplabel.text = @"优惠劵编号：";
        [self.discountdetailview addSubview:ticketnotiplabel];
        [ticketnotiplabel release];
        
        ticketnomessagelabel.backgroundColor = [UIColor clearColor];
        ticketnomessagelabel.text = td.TicketNo;
        [self.discountdetailview addSubview:ticketnomessagelabel];
        [ticketnomessagelabel release];
        
        ticketcontenttiplabel.backgroundColor = [UIColor clearColor];
        ticketcontenttiplabel.text = @"优惠内容：";
        [self.discountdetailview addSubview:ticketcontenttiplabel];
        [ticketcontenttiplabel release];
        
        ticketcontentmessagelabel.backgroundColor = [UIColor clearColor];
        ticketcontentmessagelabel.text = td.TicketDescribe;
        ticketcontentmessagelabel.numberOfLines = 0;
        ticketcontentmessagelabel.lineBreakMode = UILineBreakModeWordWrap;
        [self.discountdetailview addSubview:ticketcontentmessagelabel];
        [ticketcontentmessagelabel release];
        
        ticketstarttimetiplabel.backgroundColor = [UIColor clearColor];
        ticketstarttimetiplabel.text = @"生效时间：";
        [self.discountdetailview addSubview:ticketstarttimetiplabel];
        [ticketstarttimetiplabel release];
        
        ticketstarttimemessagelabel.backgroundColor = [UIColor clearColor];
        ticketstarttimemessagelabel.text = td.BeginTimeDate;
        [self.discountdetailview addSubview:ticketstarttimemessagelabel];
        [ticketstarttimemessagelabel release];
        
        ticketendtimetiplabel.backgroundColor = [UIColor clearColor];
        ticketendtimetiplabel.text = @"截止时间：";
        [self.discountdetailview addSubview:ticketendtimetiplabel];
        [ticketendtimetiplabel release];
        
        ticketendtimemessagelabel.backgroundColor = [UIColor clearColor];
        ticketendtimemessagelabel.text = td.EndTimeDate;
        [self.discountdetailview addSubview:ticketendtimemessagelabel];
        [ticketendtimemessagelabel release];
        
 
    }
}

- (void)discountCardDetailSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

@end
