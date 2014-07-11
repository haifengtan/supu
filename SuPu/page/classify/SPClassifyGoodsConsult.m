//
//  SPClassifyGoodsConsult.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyGoodsConsult.h"
#import "UITableViewPageing.h"
#import "SVPullToRefresh.h"
#import "SPGoodsConsult.h"
#import "PageingMessage.h"
#import "SPStatusUtility.h"
#import "UITableView+NXEmptyView.h"
#define KPAGESIZE 20

@interface SPClassifyGoodsConsult ()

@property (retain, nonatomic) UITableView *tableView;
 
@property (nonatomic,assign) BOOL isPad;
@property (nonatomic,assign) int page;
@property (nonatomic,assign) int recordCount;
@end

@implementation SPClassifyGoodsConsult
@synthesize goodssn;
@synthesize tableView = tableView_;
@synthesize page;
@synthesize isPad;
@synthesize recordCount;
- (void)dealloc
{ 
    [tableView_ release];

    [consultAction release];
    [super dealloc];
}
-(void)viewDidUnload{
    [super viewDidUnload];
    self.tableView = nil;
 
     
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
	 
    self.title = @"商品咨询";
    self.UMStr = @"商品咨询";
    
    self.emptyMessage = @"没有咨询信息";
    
     
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮" target:self action:nil];
    UITableView *m_tableView = nil;
    if (isPad) {
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 860) style:UITableViewStylePlain];
    }else{
        m_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        m_tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    self.tableView = m_tableView;
    [m_tableView release];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView_];
    [tableView_ release];
    
    self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = NO;
    
    self.page = 1;
 
    consultAction = [[SPClassifyGoodsConsultAction alloc] init];
    consultAction.delegate =self;
    [consultAction requestData];
    [self showHUD];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

- (NSDictionary *)createGoodsConsultASIRequestPara
{
    return [NSDictionary dictionaryWithObjectsAndKeys:goodssn,@"GoodsSN",OUO_NUMBER_INT(self.page),@"Page",OUO_NUMBER_INT(KPAGESIZE),@"PageSize", nil];
}

- (void)responseGoodsConsultDataToViewSuccess:(SPPageInfoData *)pageInfo
{
    [self hideHUD];
     
    [self.entryArray addObjectsFromArray:pageInfo.mPageArray];
    
    if ([self.entryArray count]==0) {
        self.tableView.nxEV_hideSeparatorLinesWheyShowingEmptyView = YES;
        self.m_str_noresultText=@"没有咨询信息";
        self.tableView.nxEV_emptyView = self.emptyView;
    }
    
    self.recordCount = [pageInfo.mRecordCount intValue];
    
    [self.tableView reloadData];
}

- (void)responseGoodsConsultDataToViewFail
{
    [self hideHUD];
    if (self.page>1)
        self.page -- ;
    

    
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

#pragma mark 表格的数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.entryArray.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPGoodsConsult *spgc = [self.entryArray objectAtIndex:indexPath.row];
    int fontsize = isPad?24:13;
    int width = isPad?500:250;
    CGSize consultcontentsize = [spgc.ConsultContent sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    CGSize replycontentsize = [spgc.ReplyContent sizeWithFont:[UIFont boldSystemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    return (isPad?182:86) + consultcontentsize.height + replycontentsize.height - (isPad?46:23);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"cellidentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    SPGoodsConsult *spgc = [self.entryArray objectAtIndex:indexPath.row];
    int fontsize = isPad?24:13;
    int width = isPad?500:250;
    CGSize consultcontentsize = [spgc.ConsultContent sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    CGSize replycontentsize = [spgc.ReplyContent sizeWithFont:[UIFont boldSystemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *backgroundimage = [UIImage imageNamed:@"背景.jpg"];
        UIImageView *backgroundview = [[UIImageView alloc] initWithImage:backgroundimage];
        cell.backgroundView = backgroundview;
        [backgroundview release];
        
        UILabel *accountlabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 11, 150, 13)];
        if (isPad) {
            accountlabel.frame = CGRectMake(47, 26, 300, 26);
        }
        accountlabel.backgroundColor = [UIColor clearColor];
        [accountlabel setFont:[UIFont boldSystemFontOfSize:fontsize]];
        [cell.contentView addSubview:accountlabel];
        [accountlabel release];
        
        UILabel *consultcontentlabel = [[UILabel alloc] init];
        consultcontentlabel.backgroundColor = [UIColor clearColor];
        [consultcontentlabel setFont:[UIFont systemFontOfSize:fontsize]];
        consultcontentlabel.numberOfLines = 0;
        consultcontentlabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.contentView addSubview:consultcontentlabel];
        [consultcontentlabel release];
        
        UILabel *consulttime = [[UILabel alloc] initWithFrame:CGRectMake(240, 13, 70, 13)];
        if (isPad) {
            consulttime.frame = CGRectMake(626, 26, 130, 26);
        }
        consulttime.backgroundColor = [UIColor clearColor];
        [consulttime setFont:[UIFont systemFontOfSize:fontsize]];
        [cell.contentView addSubview:consulttime];
        [consulttime release];
        
        UILabel *supuresponsetiplabel = [[UILabel alloc] init];
        supuresponsetiplabel.backgroundColor = [UIColor clearColor];
        [supuresponsetiplabel setFont:[UIFont boldSystemFontOfSize:fontsize]];
        supuresponsetiplabel.textColor = [UIColor redColor];
        supuresponsetiplabel.text = @"速普回复:";
        [cell.contentView addSubview:supuresponsetiplabel];
        [supuresponsetiplabel release];
        
        UILabel *supuresponsetimelabel = [[UILabel alloc] init];
        supuresponsetimelabel.backgroundColor = [UIColor clearColor];
        [supuresponsetimelabel setFont:[UIFont systemFontOfSize:fontsize]];
        supuresponsetimelabel.hidden = YES;//客户提出回复时间不显示，由于下面会用到obejctatindex，所以这里不删除，直接隐藏
        [cell.contentView addSubview:supuresponsetimelabel];
        [supuresponsetimelabel release];
        
        UILabel *supuresponsecontentlabel = [[UILabel alloc] init];
        supuresponsecontentlabel.backgroundColor = [UIColor clearColor];
        [supuresponsecontentlabel setFont:[UIFont boldSystemFontOfSize:fontsize]];
        supuresponsecontentlabel.numberOfLines = 0;
        supuresponsecontentlabel.lineBreakMode = UILineBreakModeWordWrap;
        supuresponsecontentlabel.textColor = [UIColor redColor];
        [cell.contentView addSubview:supuresponsecontentlabel];
        [supuresponsecontentlabel release];
    }
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = [NSString stringWithFormat:@"%@:",spgc.Account];
    if (isPad) {
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).frame = CGRectMake(47, 54, 500, consultcontentsize.height);
    }else{
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).frame = CGRectMake(22, 25, 250, consultcontentsize.height);
    }
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).text = spgc.ConsultContent;
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:2]).text = [SPStatusUtility dateStringFromTimeIntervalByFormatterString:spgc.ConsultTime formatterstring:@"yyyy-MM-dd"];
    if (isPad) {
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:3]).frame = CGRectMake(47, 60+consultcontentsize.height, 200, 25);
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:4]).frame = CGRectMake(626, 60+consultcontentsize.height, 140, 25);
    }else{
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:3]).frame = CGRectMake(22, 30+consultcontentsize.height, 100, 13);
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:4]).frame = CGRectMake(240, 30+consultcontentsize.height, 70, 13);
    }
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:4]).text = [SPStatusUtility dateStringFromTimeIntervalByFormatterString:spgc.ReplyTime formatterstring:@"yyyy-MM-dd"];
    if (isPad) {
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:5]).frame = CGRectMake(47, 90+consultcontentsize.height, 500, replycontentsize.height);
    }else{
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:5]).frame = CGRectMake(22, 45+consultcontentsize.height, 250, replycontentsize.height);
    }
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:5]).text = spgc.ReplyContent;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (([self.entryArray count] - 1 == indexPath.row )&&(indexPath.row < self.recordCount-1)) {
        
        [self showHUD];
        
        self.page ++ ;
        
        [consultAction requestData];
    }
         
}

@end
