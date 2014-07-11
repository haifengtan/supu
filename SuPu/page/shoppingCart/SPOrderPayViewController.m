//
//  SPOrderPayViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPOrderPayViewController.h"
#import "PersonalOrderDetail.h"
#import "SPGetOrderSuccessAction.h"
#import "SPStatusUtility.h"
#import "SPActionUtility.h"
#import "SPPayTypeChooseViewController.h"
@interface SPOrderPayViewController ()

@property BOOL isPad;

@end

@implementation SPOrderPayViewController
@synthesize topview=_topview;
@synthesize bottomview=_bottomview;
@synthesize po = _po;
@synthesize topordersnlabel = _topordersnlabel;
@synthesize toppaymoney = _toppaymoney;
@synthesize bottomwebview = _bottomwebview;
@synthesize ticketdiscount;
@synthesize isPad;

-(void)viewDidUnload{
    [super viewDidUnload];
    self.topview=nil;
    self.bottomview=nil;
//    self.po = nil;
    self.topordersnlabel = nil;
//    self.toppaymoney = nil;
    self.bottomwebview = nil;
}
-(void)dealloc{
    [_topview release];
    [_bottomview release];
    [_po release];
    [_topordersnlabel release];
    [_toppaymoney release];
    [_bottomwebview release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPOrderPayPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SPGetOrderSuccessAction *spordersuccaction = [[SPGetOrderSuccessAction alloc] init];
    [spordersuccaction requestData:SP_URL_GETORDERSUCCESS methodName:SP_METHOD_GETORDERSUCCESS createParaBlock:^NSDictionary *{
        return [NSDictionary dictionaryWithObjectsAndKeys:self.po.OrderSN,@"ordersn", nil];
    } requestSuccessBlock:^(id resultdict) {
        if ([[resultdict objectForKey:@"ErrorCode"] isEqualToString:@"0"]) {
            DLog(@"货到付款------------ %@",[resultdict objectForKey:@"Data"]);
            
            
            NSMutableString *tempstr = [[NSMutableString alloc] initWithString:[resultdict objectForKey:@"Data"]];
            
            if ((self.po.PayName!= nil && [self.po.PayName isEqualToString:@"货到付款"])) {
                self.title = @"货到付款";
                self.UMStr = @"货到付款";
            }else{
                self.title=[NSString stringWithFormat:@"%@ 速普",self.po.PayName];
                
                if ([[NSString stringWithFormat:@"￥%.2f元",[self.po.OrderAmount floatValue]+[self.po.ShippingFee floatValue]] isEqualToString:@"￥0.00元"]) {
                    
                }else{
                    [self setRightBarButton:@"下一步" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(payMoney:)];
                }
                
                [tempstr replaceOccurrencesOfString:@"{PayType}" withString:self.po.PayName options:NSCaseInsensitiveSearch range:NSMakeRange(0, tempstr.length)];
            }
            if (self.isPad) {
                [tempstr replaceOccurrencesOfString:@"font-size:13" withString:@"font-size:22" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tempstr.length)];
            }
            [_bottomwebview loadHTMLString:(NSString *)tempstr baseURL:nil];
        }
    } requestFailureBlock:^(ASIHTTPRequest *request) {
        [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }];
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:@selector(poptorootview:)];

    _topordersnlabel.text = self.po.OrderSN;
    NSString *paymoneystr = [NSString stringWithFormat:@"￥%.2f元",[self.po.OrderAmount floatValue]+[self.po.ShippingFee floatValue]];
    _toppaymoney.text = paymoneystr;
}

#pragma mark 回到rootview
- (void)poptorootview:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 支付
-(void)payMoney:(id)sender{
     
    NSString *paymoneystr = [NSString stringWithFormat:@"%.2f",[self.po.OrderAmount floatValue]+[self.po.ShippingFee floatValue]];
    [Go2PageUtility go2PayTypeChooseViewControllerFrom:self orderNo:self.po.OrderSN orderAmount:paymoneystr];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger  section =indexPath.section;
    if (cell == nil) {
        cell = [[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        if (section==0){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:_topview];
        }else if (section == 1){
            [cell.contentView addSubview:_bottomview];
        }
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        if (indexPath.section==1){
            return 500;
        }
        return 130;
    }else{
        if (indexPath.section==1){
            return 250;
        }
        return 65;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
//        PersonalOrderDetail *pod = [[PersonalOrderDetail alloc] init];
//        pod.personalorder = self.po;
//        [self.navigationController pushViewController:pod animated:YES];
//        [pod release];
        [Go2PageUtility go2OrderDetailsViewController:self orderNo:self.po.OrderSN isBackStyle:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SP_NOTIFICATION_PAYRESULT object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
