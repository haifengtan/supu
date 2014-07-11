//
//  PersonalStationMessageList.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalStationMessageList.h"
#import "PageingMessage.h"
#import "UserMessageObject.h"
#import "UITableViewPageing.h"
#import "SVPullToRefresh.h"
#import "RequestHelper.h"
#import "StationMessageDetail.h"
#import "DemoTableViewCell.h"
#import "SPActionUtility.h"
@interface PersonalStationMessageList ()

@property (retain, nonatomic) UIButton *unreadbtn;
@property (retain, nonatomic) UIButton *readbtn;
@property (retain, nonatomic) NSMutableDictionary *usermessagedict;
@property (retain, nonatomic) UITableViewPageing *messagetableview;
@property (retain, nonatomic) UserMessageObject *updateumo;
@property (retain, nonatomic) UILabel *cautionlable;
@property BOOL fristloadpage;
@property (retain, nonatomic) NSArray *allkeysarr;//保存排序后的dict的所有key
@property BOOL isPad;

@property BOOL requestfinished;

@end

@implementation PersonalStationMessageList
@synthesize unreadbtn;
@synthesize readbtn;
@synthesize usermessagedict;
@synthesize messagetableview;
@synthesize updateumo;
@synthesize cautionlable;
@synthesize fristloadpage;
@synthesize allkeysarr;
@synthesize isPad;

@synthesize requestfinished;
- (void)dealloc
{
    [unreadbtn release];
    [readbtn release];
    [usermessagedict release];
    [messagetableview release];
    [updateumo release];
    [cautionlable release];
    [allkeysarr release];
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

- (void)viewWillAppear:(BOOL)animated
{
    [self.messagetableview reloadPageingMessageBeforeSelect];
    [self userMessageListSelect];
    if (!fristloadpage) {
    if ([SPActionUtility isNetworkReachable])
        [self showHUD];
        fristloadpage = YES;
    }
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    self.isPad = iPad;
    requestfinished = YES;
    UIView *buttonview = nil;
    unreadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *backgroundimageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景.jpg"]];
    if (self.isPad) {
        messagetableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, 55, 768, 810) style:UITableViewStyleGrouped];
        backgroundimageview.frame = CGRectMake(0, 0, 768, 810);
        buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 54)];
        self.unreadbtn.frame = CGRectMake(1, 1, 383, 52);
        self.readbtn.frame = CGRectMake(385, 1, 383, 52);
        [self.unreadbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
        [self.readbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
    }else{
        messagetableview = [[UITableViewPageing alloc] initWithFrame:CGRectMake(0, 40, 320, self.view.bounds.size.height-120) style:UITableViewStyleGrouped];
        backgroundimageview.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-120);
        buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        self.unreadbtn.frame = CGRectMake(1, 1, 159, 38);
        self.readbtn.frame = CGRectMake(160, 1, 159, 38);
        [self.unreadbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [self.readbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    messagetableview.delegate = self;
    messagetableview.dataSource = self;
    messagetableview.backgroundView = backgroundimageview;
    [backgroundimageview release];
    [self.view addSubview:messagetableview];
    
    [self.unreadbtn setBackgroundImage:[UIImage imageNamed:@"按品类按钮2.png"] forState:UIControlStateNormal];
    [self.unreadbtn setBackgroundImage:[UIImage imageNamed:@"按品类按钮.png"] forState:UIControlStateSelected];
    [self.unreadbtn setTitle:@"未读" forState:UIControlStateNormal];
    [self.unreadbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.unreadbtn addTarget:self action:@selector(unreadselect:) forControlEvents:UIControlEventTouchUpInside];
    self.unreadbtn.selected = TRUE;
    [buttonview addSubview:self.unreadbtn];
    
    [self.readbtn setBackgroundImage:[UIImage imageNamed:@"按品类按钮2.png"] forState:UIControlStateNormal];
    [self.readbtn setBackgroundImage:[UIImage imageNamed:@"按品类按钮.png"] forState:UIControlStateSelected];
    [self.readbtn setTitle:@"已读" forState:UIControlStateNormal];
    [self.readbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.readbtn addTarget:self action:@selector(readselect:) forControlEvents:UIControlEventTouchUpInside];
    [buttonview addSubview:self.readbtn];
    
    [self.view addSubview:buttonview];
    [buttonview release];
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    self.title =@"站内消息";
    self.UMStr =@"站内消息";
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    
//    [self.messagetableview addPullToRefreshWithActionHandler:^{
        [self.messagetableview reloadPageingMessageBeforeSelect];
        [self userMessageListSelect];
//        [self.messagetableview.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
//    }];
    [self.messagetableview addInfiniteScrollingWithActionHandler:^{
        [self userMessageListSelect];
        [self.messagetableview.infiniteScrollingView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
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

- (void)unreadselect:(id)sender
{
    if (self.unreadbtn.selected == FALSE) {
        self.unreadbtn.selected = !self.unreadbtn.selected;
    }
    if (self.unreadbtn.selected == TRUE) {
        [self.unreadbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.readbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.readbtn.selected = FALSE;
        [self.messagetableview reloadPageingMessageBeforeSelect];
        [self userMessageListSelect];
    }
}

- (void)readselect:(id)sender
{
    if (self.readbtn.selected == FALSE) {
        self.readbtn.selected = !self.readbtn.selected;
    }
    if (self.readbtn.selected == TRUE) {
        [self.readbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.unreadbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.unreadbtn.selected = FALSE;
        [self.messagetableview reloadPageingMessageBeforeSelect];
        [self userMessageListSelect];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [self.allkeysarr objectAtIndex:section];
    NSArray *value = (NSArray *)[self.usermessagedict valueForKey:key];
    return value.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allkeysarr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.isPad) {
//        return 144;
//    }else{
//        return 65;
//    }
    NSString *key = [self.allkeysarr objectAtIndex:indexPath.section];
    NSArray *arr = [self.usermessagedict valueForKey:key];
    UserMessageObject *uo  = [arr objectAtIndex:indexPath.row];
    RTLabel *rtLabel = [DemoTableViewCell textLabel];
    [rtLabel setText:uo.MessageContent];
    CGSize optimumSize = [rtLabel optimumSize];
    float offHeight =0.0;
    if (iPad) {
        offHeight = 40.0;
    }else offHeight = 30.0;
    return optimumSize.height+offHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSString *cellstr = [NSString stringWithFormat:@"%dmessagecell",indexPath.section];
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (cell == nil) {
        cell = [[[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //加上聊天泡泡
//        UIImage *bubble = [UIImage imageNamed:@"bubbleSelf.png"];//44 31
//        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
//        UIImage *bubble = [UIImage imageNamed:@"白条2.png"];//44 31
//        UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:bubble];
//        RTLabel *textlabel = [[RTLabel alloc] init];
//        textlabel.tag = 888;
//        if (self.isPad) {
//            bubbleImageView.frame = CGRectMake(0, 10, 680, 110);
//            textlabel.frame = CGRectMake(30, 20, 540, 70);
//            [textlabel setFont:[UIFont boldSystemFontOfSize:26]];
//        }else{
//            bubbleImageView.frame = CGRectMake(0, 5, 300, 55);
//            textlabel.frame = CGRectMake(15, 15, 270, 35);
//            [textlabel setFont:[UIFont boldSystemFontOfSize:13]];
//        }
//        
////        [cell.contentView addSubview:bubbleImageView];
//        [bubbleImageView release];
//        //加上label
//        textlabel.lineBreakMode = UILineBreakModeWordWrap;
////        textlabel.numberOfLines = 0;
//        textlabel.backgroundColor = [UIColor clearColor];
//        [cell.contentView addSubview:textlabel];
//        [textlabel release];
//        //加上背景
//        UIImageView *backgroundview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景.jpg"]];
////        cell.backgroundView = backgroundview;
//        [backgroundview release];
    }
    
    //计算出字符高度
    NSString *key = [self.allkeysarr objectAtIndex:indexPath.section];
    NSArray *arr = [self.usermessagedict valueForKey:key];
    UserMessageObject *uo  = [arr objectAtIndex:indexPath.row];
//    CGSize size = [uo.MessageContent sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(260, 300) lineBreakMode:UILineBreakModeWordWrap];
    //设置泡泡的frame
//    UIImageView *bubbleImageView = [cell.contentView.subviews objectAtIndex:0];
//    bubbleImageView.frame = CGRectMake(10.0f, 5.0f, 300, size.height+30);//整个cell高度比字符多40，所以泡泡加30
    //设置lable的frame和text
//    RTLabel *textlabel = [cell.contentView.subviews objectAtIndex:0];
//    textlabel.frame = CGRectMake(30.0f, 20.0f, 260, size.height);
//    textlabel.text = uo.MessageContent;
//    textlabel.text = uo.MessageContent;
    cell.rtLabel.delegate = self;
    cell.rtLabel.text = uo.MessageContent;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.isPad){
        return 50.0f;
    }else{
        return 25.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageview = nil;
    UILabel *headlabel = nil;
    if (self.isPad) {
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 50)];
        headlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 680, 40)];
        [headlabel setFont:[UIFont boldSystemFontOfSize:28]];
    }else{
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
        headlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 20)];
        [headlabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    imageview.image = [UIImage imageNamed:@"背景.jpg"];
    
    headlabel.backgroundColor = [UIColor clearColor];
    headlabel.text = [self.allkeysarr objectAtIndex:section];
    headlabel.textColor = [UIColor redColor];
    [imageview addSubview:headlabel];
    [headlabel release];
    
    return [imageview autorelease];
}

#pragma mark 选中某条记录进入下一个页面的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.allkeysarr objectAtIndex:indexPath.section];
    NSArray *arr = [self.usermessagedict valueForKey:key];
    self.updateumo  = [arr objectAtIndex:indexPath.row];
    if (self.updateumo.IsSee!=nil && [self.updateumo.IsSee isEqualToString:@"0"]) {
        [self updateMessageStatus];
    }else{
        StationMessageDetail *smd = [[StationMessageDetail alloc] init];
        smd.messagecontent = self.updateumo.MessageContent;
        [self.navigationController pushViewController:smd animated:YES];
        [smd release];
    }
}

#pragma mark 更改未读消息为已读
- (void)updateMessageStatus
{
    NSMutableDictionary *messagesdict = [[NSMutableDictionary alloc] init];
    [messagesdict setValue:self.updateumo.RID forKey:@"Ids"];
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_USERMESSAGETOREAD methodName:(NSString *)SP_METHOD_USERMESSAGETOREAD memberid:memberid];
    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    
    [rh RequestUrl:messagesdict succ:@selector(updateMessageStatusSucc:) fail:@selector(updateMessageStatusFail:) responsedelegate:self];
    [messagesdict release];
    [rh release];
}

- (void)updateMessageStatusSucc:(ASIFormDataRequest *)request
{
        if ([SPActionUtility isNetworkReachable])
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    if (errorcode!=nil && [errorcode isEqualToString:@"0"]) {
        StationMessageDetail *smd = [[StationMessageDetail alloc] init];
        smd.messagecontent = self.updateumo.MessageContent;
        [self.navigationController pushViewController:smd animated:YES];
        [smd release];
    }else{
        [UIViewHealper helperBasicASIFailUIAlertView];
    }
}

- (void)updateMessageStatusFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}


#pragma mark 查询列表的方法
- (void)userMessageListSelect{
    if (requestfinished == NO) {
        return;
    }
    requestfinished = NO;
    NSMutableDictionary *usermessagesdict = [[NSMutableDictionary alloc] init];
    [usermessagesdict setValue:[self.messagetableview pageStringValue] forKey:@"Page"];
    [usermessagesdict setValue:[self.messagetableview pageNumStringValue] forKey:@"PageSize"];
    if (self.readbtn.selected == TRUE) {
        [usermessagesdict setValue:@"1" forKey:@"State"];
    }
    if (self.unreadbtn.selected == TRUE) {
        [usermessagesdict setValue:@"0" forKey:@"State"];
    }
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETUSERMESSAGE methodName:(NSString *)SP_METHOD_GETUSERMESSAGE memberid:memberid];

    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:usermessagesdict succ:@selector(userMessageListSelectSucc:) fail:@selector(userMessageListSelectFail:) responsedelegate:self];
    [usermessagesdict release];
    [rh release];
}

- (void)userMessageListSelectSucc:(ASIFormDataRequest *)request{
    [self hideHUD];
    requestfinished = YES;
    PageingMessage *pm = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[PageingMessage class] keyPath:@"Data.PageInfo" keyPathDeep:nil];
    NSArray *resulstarr = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[UserMessageObject class] keyPath:@"Data.MessageList" keyPathDeep:nil];
    resulstarr = [self.messagetableview setPageingMessage:pm.RecordCount.intValue tableviewarray:resulstarr];
    
    if (resulstarr.count == 0) {
        self.messagetableview.hidden = YES;
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
        if (self.isPad) {
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 54, 768, 904) title:@"没有消息"];
        }else{
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 40, 320, 480-130) title:@"没有消息"];
        }
        [self.view addSubview:self.cautionlable];
    }else{
        self.messagetableview.hidden = NO;
        [self reloadUserMessageDictionary:resulstarr];
        [self.messagetableview reloadData];
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
    }
}

- (void)userMessageListSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

- (void)reloadUserMessageDictionary:(NSArray *)resulstarr
{
    usermessagedict = [[NSMutableDictionary alloc] init];
    for (UserMessageObject *uo in resulstarr) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:uo.ReleaseTime.doubleValue];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *datestr = [formatter stringFromDate:date];
        [formatter release];
        uo.ReleaseDate = datestr;
        NSString *key = uo.ReleaseDate;
        if ([self.usermessagedict valueForKey:key]) {//假如已经存在这一天的数据
            NSMutableArray *arr = [self.usermessagedict valueForKey:uo.ReleaseDate];
            [arr addObject:uo];
            [self.usermessagedict setValue:arr forKey:uo.ReleaseDate];
        }else {//假如不存在这一天的数据
            NSMutableArray *arr = [NSMutableArray arrayWithObject:uo];
            [self.usermessagedict setValue:arr forKey:uo.ReleaseDate];
        }
    }
    self.allkeysarr = [self.usermessagedict allKeys];

    self.allkeysarr = [self.allkeysarr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1 = [formatter dateFromString:obj1];
        NSDate *date2 = [formatter dateFromString:obj2];
        [formatter release];

        
        if (date1.timeIntervalSince1970 > date2.timeIntervalSince1970) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if (date1.timeIntervalSince1970 < date2.timeIntervalSince1970) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
}

#pragma mark  rtLabel代理
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
//    [[UIApplication sharedApplication] openURL:url];
}
@end
