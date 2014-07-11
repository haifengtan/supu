//
//  SPPayTypeChooseViewController.m
//  SuPu
//
//  Created by cc on 13-1-5.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPPayTypeChooseViewController.h"
#import  "SPGetAliPayDataAction.h"
#import "SPActionUtility.h"
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "UPPayPlugin.h"
#import "SPGetUPPayDataAction.h"
#import "SPAppDelegate.h"
@interface SPPayTypeChooseViewController ()

@property (retain, nonatomic) UITableView *tableview;
@property BOOL isPad;

@end

@implementation SPPayTypeChooseViewController
@synthesize tableview;
@synthesize isPad;
@synthesize orderAmount,orderNo;

- (void)dealloc
{
    [tableview release];
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
    self.title = @"选择支付方式";
    self.UMStr = @"选择支付方式";
    self.isPad = iPad;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:backgroundview];
    [backgroundview  release];
    
    if (self.isPad) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 860) style:UITableViewStyleGrouped];
    }else{
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [SPStatusUtility getScreenHeight] - kNavHeight - kTabbarHeight - 20) style:UITableViewStyleGrouped];
    }
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.scrollEnabled = NO;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isPad) {
        return 140;
    }else{
        return 70;
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 86;
    }else{
        return 43;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = nil;
    UILabel *label = nil;
    if (self.isPad) {
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 80)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 500, 40)];
        [label setFont:[UIFont boldSystemFontOfSize:26]];
    }else{
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
        [label setFont:[UIFont boldSystemFontOfSize:13]];
    }
    label.text = @"温馨提示：订单生成后不能修改支付方式";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    [footer addSubview:label];
    [label release];
    footer.backgroundColor = [UIColor clearColor];
    return [footer autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellidentify";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify] autorelease];
        if (self.isPad) {
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:28]];
        }else{
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:15]];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"银联手机在线支付";
        }else{
            cell.textLabel.text = @"支付宝";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self UpPayMakeOrder];
    }
    else
    {
        [self payMoney];
    }
}

#pragma mark 银联支付
- (void)UpPayMakeOrder
{
    
    payPluginAction = [[SPUPPayPluginAction alloc] init];
    payPluginAction.m_delegate_payPlugin = self;
    [payPluginAction requestPayPluginListData];
    
    [self showHUDWithMessage:@"生成订单"];
    
}

-(NSDictionary*)onRequestPayPluginAction{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.orderNo,@"OrderSN", nil];
}
-(void)onResponsePayPluginSuccess:(NSString *)tradeNumber ServerMode:(NSString *)serverMode{
    [self hideHUD];
    
    [UPPayPlugin startPay:tradeNumber sysProvide:@"11564520" spId:@"0281" mode:serverMode viewController:self delegate:self];
    
    
}
-(void)onResponsePayPluginFail{
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}


-(void)UPPayPluginResult:(NSString*)result{
    
    if (result!=nil && ![result isEqualToString:@"cancel"]) {
         
        //    NSString *alertString = [NSString stringWithFormat:@"支付结果:%@",result];
        
        [Go2PageUtility go2OrderDetailsViewController:self orderNo:self.orderNo isBackStyle:YES];
        
    }
    else
    {
        
        [SPStatusUtility showAlert:@"提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        return;
        
    }
    
    [KAppDelegate.m_tabBarCtrl.firstbtn setSelected:NO];
    [KAppDelegate.m_tabBarCtrl.secondbtn setSelected:NO];
    [KAppDelegate.m_tabBarCtrl.thridbtn setSelected:YES];
    [KAppDelegate.m_tabBarCtrl.fourtybtn setSelected:NO];
    [KAppDelegate.m_tabBarCtrl.fivtybtn setSelected:NO];
    
}


#pragma mark 支付 ---------------------------------------
-(void)payMoney{
    //    [[NSNotificationCenter defaultCenter] removeAllActionsWithTarget:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResult:) name:SP_NOTIFICATION_PAYRESULT object:nil];
    
    [self  go2AlipayClientWithOrder:self.orderNo orderAmount:self.orderAmount];
}

-(void)go2AlipayClientWithOrder:(NSString*)orderID orderAmount:(NSString*)orderMoney{
    
	NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    
	if ([partner length] == 0 || [seller length] == 0)
	{
        
        [SPStatusUtility showAlert:@"提示" message:@"缺少partner或者seller" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		return;
	}
    
	AlixPayOrder *order = [[[AlixPayOrder alloc] init] autorelease];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = orderID; //订单ID（由商家自行制定）
	order.productName = @"速普商城"; //商品标题
    //	order.productDescription = @"卓越品质"; //商品描述
	order.amount =  orderMoney ;  //商品价格
	order.notifyURL = @"http://222.66.209.181:8889/mm/servlet/CallBack"; //回调URL
    
	NSString *appScheme = @"SuPu";
    
	NSString *orderSpec = [order description];
 	DLog(@"orderSpec = %@",orderSpec);
    //
    //    DLog(@"私钥 ----------  %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
    
    
    SPGetAliPayDataAction *alipayAction = [[SPGetAliPayDataAction alloc] init];
    [alipayAction requestData:SP_URL_GetAliPayData methodName:SP_METHOD_GetAliPayData createParaBlock:^NSDictionary *{
        return [NSDictionary dictionaryWithObjectsAndKeys:orderID,@"OrderSN", nil];
        
    } requestSuccessBlock:^(id resultdict) {
        
        AlixPay * alixpay = [AlixPay shared];
        NSString *orderString = [[resultdict objectForKey:@"Data"] objectForKey:@"AliPayData"];
        
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
         
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertViews = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                  message:@"您还没有安装支付宝钱包的客户端，请先装"
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil];
          
            [alertViews show];
            [alertViews release];
        }
        else if (ret == kSPErrorSignError)
        {
 
            [SPStatusUtility showAlert:@"提示" message:@"签名错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            return ;
        }
 
        
    } requestFailureBlock:^(ASIHTTPRequest *as) {
        
        
    }];
    
}
- (void)alertView:(UIAlertView *)alertViews clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //支付宝的url
    
    NSString * URLString = nil;
    if (iPad)
    {
        URLString = @"itms-apps://itunes.apple.com/cn/app/zhi-fu-bao-hd/id481294264?mt=8";
    }
    else
    {
        URLString = @"itms-apps://itunes.apple.com/cn/app/zhi-fu-bao-qian-bao-zhi-fu/id333206289?mt=8";
    }
     
    [[UIApplication sharedApplication] openURL:OUO_URL(URLString)];
    
 
}
#pragma -
#pragma mark 支付宝相关
- (void)payResult:(NSNotification*)notification
{
    AlixPayResult *result = notification.object;
  
    if (result.statusCode == 9000) {
        [UIAlertView showAlertViewWithTitle:@"" message:@"支付成功" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alert, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                [Go2PageUtility go2OrderDetailsViewController:self orderNo:self.orderNo isBackStyle:YES];                
            }
        }];

 
    }
    else
    {
        [UIAlertView showAlertViewWithTitle:@"" message:@"支付失败" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alert, NSInteger buttonIndex) {
             
        }];
    }
    
}

@end
