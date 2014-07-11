//
//  AddressManagerList.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "AddressManagerList.h"
#import "AddressObject.h"
#import "RequestHelper.h"

@interface AddressManagerList ()

@property (retain, nonatomic) UITableView *consigneelisttableview;
@property (retain, nonatomic) NSMutableArray *consigneearr;

@end

@implementation AddressManagerList
@synthesize consigneelisttableview;
@synthesize consigneearr;

- (void)dealloc
{
    [consigneelisttableview release];
    [consigneearr release];
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    consigneelisttableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-30) style:UITableViewStyleGrouped];
    consigneelisttableview.delegate = self;
    consigneelisttableview.dataSource = self;
    [self.view addSubview:consigneelisttableview];
    
    self.title =@"收货地址列表";
    self.UMStr =@"收货地址列表";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    [self setRightBarButton:@"新建" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(newAddress:)];
    
    [self consigneeListSelect];
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

#pragma mark tableview的代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.consigneearr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressObject *ao = [self.consigneearr objectAtIndex:indexPath.row];
    CGSize addresssize = [ao.Address sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(250, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    return 86-15+addresssize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"consigneecell";
    AddressObject *ao = [self.consigneearr objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        

        
        CGSize addresssize = [ao.Address sizeWithFont:[UIFont boldSystemFontOfSize:12] constrainedToSize:CGSizeMake(250, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
        
        UIImageView *detailpic = [[UIImageView alloc] initWithFrame:CGRectMake(285, 27, 7, 11)];
        detailpic.image = [UIImage imageNamed:@"小箭头.png"];
        [cell.contentView addSubview:detailpic];
        [detailpic release];
        
        UILabel *consigneetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 12, 50, 15)];
        consigneetiplabel.backgroundColor = [UIColor clearColor];
        consigneetiplabel.font = [UIFont boldSystemFontOfSize:12];
        consigneetiplabel.text = @"收件人：";
        [cell.contentView addSubview:consigneetiplabel];
        [consigneetiplabel release];
        
        UILabel *teltiplabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 30, 40, 15)];
        teltiplabel.backgroundColor = [UIColor clearColor];
        teltiplabel.font = [UIFont boldSystemFontOfSize:12];
        teltiplabel.text = @"电话：";
        [cell.contentView addSubview:teltiplabel];
        [teltiplabel release];
        
        UILabel *addresstiplabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 48, 40, 15)];
        addresstiplabel.backgroundColor = [UIColor clearColor];
        addresstiplabel.font = [UIFont boldSystemFontOfSize:12];
        addresstiplabel.text = @"地址：";
        [cell.contentView addSubview:addresstiplabel];
        [addresstiplabel release];
        
        UILabel *zipcodetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 66+addresssize.height -15, 40, 15)];
        zipcodetiplabel.backgroundColor = [UIColor clearColor];
        zipcodetiplabel.font = [UIFont boldSystemFontOfSize:12];
        zipcodetiplabel.text = @"邮编：";
        [cell.contentView addSubview:zipcodetiplabel];
        [zipcodetiplabel release];
        
        UILabel *consigneemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 240, 15)];
        consigneemessagelabel.backgroundColor = [UIColor clearColor];
        consigneemessagelabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:consigneemessagelabel];
        [consigneemessagelabel release];
        
        UILabel *telmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 240, 15)];
        telmessagelabel.backgroundColor = [UIColor clearColor];
        telmessagelabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:telmessagelabel];
        [telmessagelabel release];
        
        UILabel *addressmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 48, 250, 15)];
        addressmessagelabel.backgroundColor = [UIColor clearColor];
        addressmessagelabel.font = [UIFont boldSystemFontOfSize:12];
        addresstiplabel.numberOfLines = 0;
        addresstiplabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.contentView addSubview:addressmessagelabel];
        [addressmessagelabel release];
        
        UILabel *zipcodemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 66+addresssize.height -15, 240, 15)];
        zipcodemessagelabel.backgroundColor = [UIColor clearColor];
        zipcodemessagelabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:zipcodemessagelabel];
        [zipcodemessagelabel release];
    }

    ((UILabel *)[cell.contentView.subviews objectAtIndex:5]).text = ao.Consignee;
    ((UILabel *)[cell.contentView.subviews objectAtIndex:6]).text = [NSString stringWithFormat:@"%@ / %@",ao.Mobile,ao.Tel];
    ((UILabel *)[cell.contentView.subviews objectAtIndex:7]).text = ao.Address;
    ((UILabel *)[cell.contentView.subviews objectAtIndex:8]).text = ao.ZipCode;
    
    return cell;
}

#pragma mark 查询列表的方法
- (void)consigneeListSelect
{
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETCONSIGNEELIST methodName:(NSString *)SP_METHOD_GETCONSIGNEELIST memberid:memberid];
 
    [rh RequestUrl:nil succ:@selector(consigneeListSelectSelectSucc:) fail:@selector(consigneeListSelectFail:) responsedelegate:self];
    [rh release];
}

- (void)consigneeListSelectSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    self.consigneearr = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[AddressObject class] keyPath:@"Data.Consigneelist" keyPathDeep:nil];
    [self.consigneelisttableview reloadData];
}

- (void)consigneeListSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

#pragma mark 新建地址
- (void)newAddress:(id)sender
{
    
}

@end
