//
//  SPPersonalCenterViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//


#import "SPPersonalCenterViewController.h"
#import "PersonalMessageView.h"

#import "SPPersonalOrdersList.h"
#import "PersonalCollectionList.h"
#import "PersonalStationMessageList.h"
#import "DiscountCardList.h"
#import "RequestHelper.h"
#import "Member.h"
#import "GetMemberTopGoods.h"
#import "UIImageView+WebCache.h"
#import "AddressManagerList.h"
#import "LoginViewController.h"
#import "SPAppDelegate.h"
#import "SPGetMemberInfoAction.h"
#import "SingleRowScrollCell.h"
#import "SPPersonalInfomations.h"
@interface SPPersonalCenterViewController ()

@property (retain,nonatomic) NSArray *celltextarr;
@property (retain,nonatomic) NSArray *cellimagenamearr;
@property (retain,nonatomic) Member *member;
@property (retain,nonatomic) NSArray *indextopgoodsarr;
@property (retain,nonatomic) PersonalMessageView *personalmessageview;
@property (retain,nonatomic) UIScrollView *salerrecommendsv;
@property (retain,nonatomic) UITableView *personalcontrolview;
@property BOOL isPad;
@property (nonatomic,retain) SPPersonalAction *personalAction;
@property (nonatomic,retain) NSArray *dataArray;

@property (nonatomic,retain) SPPersonalInfomations *m_action_getUserInfo;

@property (nonatomic,assign) BOOL isLoad;
@end

@implementation SPPersonalCenterViewController
@synthesize celltextarr;
@synthesize cellimagenamearr;
@synthesize member;
@synthesize indextopgoodsarr;
@synthesize personalmessageview;
@synthesize salerrecommendsv;
@synthesize personalcontrolview;
@synthesize isPad;
@synthesize personalAction;
@synthesize dataArray;
@synthesize m_action_getUserInfo;
@synthesize isLoad;

- (void)dealloc
{
    [celltextarr release];
    [cellimagenamearr release];
    [indextopgoodsarr release];
    [personalmessageview release];
    [salerrecommendsv release];
    [personalcontrolview release];
    [personalAction release];
    [dataArray release];
    [m_action_getUserInfo release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (isPad) {
        self = [super initWithNibName:@"SPPersonalCenterPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initWithView];
    if ([self.entryArray count] == 0 && self.isLoad) {

              [personalAction requestCategoryListData];
    }
     
}


-(void)initWithView{
    if (![SPStatusUtility isUserLogin]) {//假如没登陆过
        KAppDelegate.loginModelViewMotherViewName = @"SPPersonal";
        [Go2PageUtility go2LoginViewNoAnimatedControllerWithSuccessBlock:^{
            [KAppDelegate.m_tabBarCtrl selectTab:3];
        }];
        
    }else{
        
        m_action_getUserInfo=[[SPPersonalInfomations alloc] init];
        self.m_action_getUserInfo.m_delegate_orderList=self;
        [m_action_getUserInfo requestPersonalInfomationData];
        
        Member *l_member=[[Member allObjects] objectAtIndex:0];
         
        PersonalMessageView *tempMessageView = nil;
        if (self.isPad) {
            tempMessageView= [[PersonalMessageView alloc] initWithFrame:OUO_RECT(0, 0, 768, 130) memberInfo:l_member];
        }else{
            tempMessageView =[[PersonalMessageView  alloc] initWithFrame:OUO_RECT(0, 0, 320, 65) memberInfo:l_member];
            
        }
        self.personalmessageview = tempMessageView;
        [tempMessageView release];
        
        self.personalcontrolview.tableHeaderView = personalmessageview;
        
        
    }

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
//     self.m_action_getUserInfo.m_delegate_orderList=nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"会员中心";
    self.UMStr =@"会员中心";
   
    
    [self setRightBarButton:@"注销" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(logOut:)];
    
    celltextarr = [[NSArray alloc] initWithObjects:@"我的订单",@"我的收藏",@"站内消息",@"我的优惠劵",@"地址管理",nil];
    cellimagenamearr = [[NSArray alloc] initWithObjects:@"我的订单logo",@"我的收藏logo",@"站内消息",@"我的优惠券logo",@"地址管理",nil];
    
   
    //会员操作的tableview
    UITableView *m_tableView = nil;
    
    if(self.isPad){
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768 , self.view.bounds.size.height-150)];
    }else{
        NSLog(@"-----self.view.frameHeight------ %f",self.view.bounds.size.height);
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320 , [SPStatusUtility getScreenHeight] - kTabbarHeight - kNavHeight - 20)];
 
    }
    self.personalcontrolview = m_tableView;
    [m_tableView release];
    
    personalcontrolview.delegate = self;
    personalcontrolview.dataSource = self;
    personalcontrolview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
 
    [self.view addSubview:personalcontrolview];
    
    [personalcontrolview release];
 
 
    
    personalAction = [[SPPersonalAction alloc] init];
    personalAction.m_delegate_categoryList = self;
    [personalAction requestCategoryListData];
    
    
}

- (void)logOut:(id)sender
{
    
    NSArray *array = [NSArray arrayWithObject:@"确定"];
    [UIAlertView showAlertViewWithTitle:nil message:@"是否注销登陆" cancelButtonTitle:@"取消" otherButtonTitles:array handler:^(UIAlertView *alert, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [SPActionUtility userLogout];
            KAppDelegate.loginModelViewMotherViewName = @"SPPersonal";
            [Go2PageUtility go2LoginViewControllerWithSuccessBlock:^{
                [KAppDelegate.m_tabBarCtrl selectTab:3];
            }];
        }
    }];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else
        return [self.dataArray count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        if (indexPath.section ==0) {
            return 84;
        }else
            return 200;
    }else{
        if (indexPath.section ==0) {
            return 43;
        }else
            return 128.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.0;
    }else{
        if (self.isPad) {
            return 50;
        }else{
            return 30;
        }
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else{
        UIImageView *salerrecommend = nil;
        UILabel *saletitlelabel = nil;
        if (isPad) {
            salerrecommend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 50)];
            saletitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 268, 30)];
            saletitlelabel.font = [UIFont boldSystemFontOfSize:26];
        }else{
            salerrecommend = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            saletitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 30)];
            saletitlelabel.font = [UIFont boldSystemFontOfSize:17];
        }
        salerrecommend.image = [UIImage imageNamed:@"顶部栏.png"];
        saletitlelabel.backgroundColor = [UIColor clearColor];
        saletitlelabel.textAlignment = NSTextAlignmentCenter;
        saletitlelabel.text = @"商家推荐";
        saletitlelabel.textColor = [UIColor whiteColor];
        [salerrecommend addSubview:saletitlelabel];
        [saletitlelabel release];
        
        return [salerrecommend autorelease];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        static NSString *cellID = @"SingleRowScrollCell";
        SingleRowScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            if (isPad) {
                NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"SingleRowScrollPadCell" owner:self options:nil];
                cell = [nibTableCells objectAtIndex:0];
                [cell.titleLabel.titleLabel setFont:[UIFont systemFontOfSize:19]];
            }else{
                cell = [SingleRowScrollCell loadFromNIB];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSUInteger row = indexPath.row;
        SPHomeItemData *hid = [self.dataArray objectAtIndex:row];
        [cell.titleLabel setTitle:hid.mName forState:UIControlStateNormal];
        [cell.scrollView setItemCount:hid.mGoodsArray.count withDataSource:^UIButton *(NSUInteger itemIndex) {
            SPHomeGoodData *hgd = [hid.mGoodsArray objectAtIndex:itemIndex];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 
            button.layer.masksToBounds = YES;
            button.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
            button.layer.borderWidth = 1;
            
            if (isPad) {
                button.frame = OUO_RECT(0., 0., 132., 120.);
            }else{
                button.frame = OUO_RECT(0., 0., 95., 91.);
            }
            [button setImageWithURL:URLImagePath(hgd.mImgFile) placeholderImage:kDefaultImage];
            
            UIView *bgView = nil;
            if (isPad) {
                bgView = [[UIView alloc] initWithFrame:OUO_RECT(0., 0., button.frameWidth, 35.)];
            }else{
                bgView = [[UIView alloc] initWithFrame:OUO_RECT(0., 0., button.frameWidth, 23.)];
            }
            bgView.backgroundColor = [UIColor clearColor];
            bgView.frameBottom = button.frameHeight;
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:bgView.bounds];
            priceLabel.textAlignment = UITextAlignmentCenter;
            priceLabel.textColor = [UIColor redColor];
            if (isPad) {
                priceLabel.font = OUO_FONT_BOLD(19.);
            }else{
                priceLabel.font = OUO_FONT_BOLD(17.);
            }
            priceLabel.text = OUO_STRING_FORMAT(@"%@元", hgd.mPrice);
            priceLabel.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.2];
            [bgView addSubview:priceLabel];
            OUOSafeRelease(priceLabel);
            [button addSubview:bgView];
            OUOSafeRelease(bgView);
            return button;
        }];
        [cell.scrollView setItemTappedHandler:^(NSUInteger itemIndex){
            SPHomeGoodData *hgd = [hid.mGoodsArray objectAtIndex:itemIndex];
            [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:hgd.mGoodsSN from:self];
        }];
        return cell;
    }else{
        
        static NSString *personalcontrolviewcell = @"personalcontrolviewcell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:personalcontrolviewcell];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personalcontrolviewcell] autorelease];
            
            
            
            UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:cell.bounds];
            backgroundview.image = [UIImage imageNamed:@"背景.png"];
            cell.backgroundView = backgroundview;
            [backgroundview release];
            
            UIImageView *leftimageview = nil;
            UILabel *centerlabel = nil;
            UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if(self.isPad){
                leftimageview = [[UIImageView alloc] initWithFrame:CGRectMake(39, 22, 40, 40)];
                centerlabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 22, 300, 40)];
                centerlabel.font = [UIFont boldSystemFontOfSize:26];
                rightbtn.frame = CGRectMake(700, 32, 12, 20);
            }else{
                leftimageview = [[UIImageView alloc] initWithFrame:CGRectMake(18, 13, 15, 15)];
                centerlabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 13, 100, 17)];
                centerlabel.font = [UIFont boldSystemFontOfSize:18];
                rightbtn.frame = CGRectMake(285, 15, 7, 11);
            }
            [cell.contentView addSubview:leftimageview];
            [leftimageview release];
            
            centerlabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:centerlabel];
            [centerlabel release];
            
            [rightbtn setImage:[UIImage imageNamed:@"小箭头.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:rightbtn];
        }
        NSInteger row = indexPath.row;
        
        UIImageView *leftimageview = [cell.contentView.subviews objectAtIndex:0];
        leftimageview.image = [UIImage imageNamed:[cellimagenamearr objectAtIndex:row]];
        
        UILabel *centerlabel = [cell.contentView.subviews objectAtIndex:1];
        centerlabel.text = [celltextarr objectAtIndex:row];
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc] init];//这个地方永远也不会执行到的
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        return;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            SPPersonalOrdersList *orderlistcontroller = [[SPPersonalOrdersList alloc] init];
            [self.navigationController pushViewController:orderlistcontroller animated:YES];
            [orderlistcontroller release];
            break;
        }
        case 1:
        {
            PersonalCollectionList *personalcoll = [[PersonalCollectionList alloc] init];
            [self.navigationController pushViewController:personalcoll animated:YES];
            [personalcoll release];
            break;
        }
        case 2:
        {
            PersonalStationMessageList *personalstation = [[PersonalStationMessageList alloc] init];
            [self.navigationController pushViewController:personalstation animated:YES];
            [personalstation release];
            break;
        }
        case 3:
        {
            [Go2PageUtility go2DiscountCardListViewControllerFrom:self pageName:@"personalCenter" fromWhere:nil];
            break;
        }
        case 4:
        {
            [Go2PageUtility go2AddressManagerViewControllerFrom:self isEdit:YES];
            //            AddressManagerList *addressmanager = [[AddressManagerList alloc] init];
            //            [self.navigationController pushViewController:addressmanager animated:YES];
            //            [addressmanager release];
            break;
        }
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark ===
#pragma mark 下载
-(NSMutableDictionary *)onResponseCategoryListAction{
    [self showHUD];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    return dict;
}
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList{
    [self hideHUD];
    self.isLoad = NO;
    self.dataArray = l_arr_categoryList;
    [personalcontrolview reloadData];
}
-(void)onResponseCategoryListDataFail{
    [self hideHUD];
    self.isLoad = YES;
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}


#pragma mark SSPOrderMemberActionDelegate
-(NSDictionary *)onRequestOrderMemberAction{
    return nil;
}

-(void)onResponseOrderMemberDataSuccess:(Member *)l_data_orderList{
    self.personalcontrolview.tableHeaderView = nil;
    
    Member *l_member=[[Member allObjects] objectAtIndex:0];
    if (self.isPad) {
        personalmessageview = [[PersonalMessageView  alloc] initWithFrame:OUO_RECT(0, 0, 768, 130) memberInfo:l_member];
    }else{
        personalmessageview = [[PersonalMessageView  alloc] initWithFrame:OUO_RECT(0, 0, 320, 65) memberInfo:l_member];
        
    }
    
    self.personalcontrolview.tableHeaderView = personalmessageview;
}

-(void)onResponseOrderMemberDataFail{
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

@end
