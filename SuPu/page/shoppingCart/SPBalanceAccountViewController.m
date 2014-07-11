//
//  SPBalanceAccountViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBalanceAccountViewController.h"
#import "SPOrderPayViewController.h"
#import "SPShippingFeeAction.h"
#import <QuartzCore/QuartzCore.h>
#import "Member.h"
#import "SPGetMemberInfoAction.h"
#import "SPGetTicketInfoAction.h"
#import "InvoiceSelectController.h"
#define PRICETEXT 555
#define DISCOUNTCARTEXT 666
#define INVOICETEXT 777
@interface SPBalanceAccountViewController ()<InvoiceSelectDelegate>
@property (nonatomic,retain) NSString *cashString;//账户输入的现金额度

@property (retain, nonatomic) NSIndexPath *lastindexpath;
@property (retain, nonatomic) Member *member;
@property (retain, nonatomic) UITextField *pricetext;
@property (retain, nonatomic) NSString *paymentname;
@property (retain, nonatomic) NSString *shippingName;
@property float ticketdiscount;
@property BOOL isPad;
@property (retain,nonatomic) NSString *invoiceID;
@property (retain,nonatomic) NSString *invoiceName;
@property (retain,nonatomic) NSString *invoiceHead;

@property (nonatomic,retain)UITableViewCell *selectedCell;
@property (nonatomic,retain)UIButton *delete_coupoons;
@end

@implementation SPBalanceAccountViewController
@synthesize tableView=_tableView;
@synthesize saddressedView=_saddressedView;
@synthesize spriceView=_spriceView;
@synthesize shopCartData=_shopCartData;
@synthesize totalPayLabel=_totalPayLabel;//您共需支付
@synthesize productTotalLabel=_productTotalLabel;//商品小计
@synthesize discountAmountLabel=_discountAmountLabel;//商品优惠金额
@synthesize feeLabel=_feeLabel;//运费
@synthesize moneyAccountLabel=_moneyAccountLabel;//现金账户
@synthesize zipCodeLabel=_zipCodeLabel;
@synthesize phoneLabel=_phoneLabel;
@synthesize consigneeLabel=_consigneeLabel;
@synthesize addressLabel=_addressLabel;
@synthesize paymentID=_paymentID;//支付方式id
@synthesize shippingID=_shippingID;//物流方式id
@synthesize ticketno=_ticketno;//优惠劵号码
@synthesize addressobject = _addressobject;
@synthesize lastindexpath = _lastindexpath;
@synthesize member = _member;
@synthesize pricetext = _pricetext;//现金账户输入框
@synthesize remark = _remark;//备注
@synthesize lastaccount = _lastaccount;//最后一次账户id，用来记录上次支付的时候该页面的账户，避免用户重新登陆造成信息保留
@synthesize paymentname = _paymentname;
@synthesize shippingName = _shippingName;
@synthesize discountcardtext = _discountcardtext;
@synthesize ticketdiscount;//优惠劵优惠金额
@synthesize isPad;
@synthesize cashString;
@synthesize selectedCell;
@synthesize delete_coupoons;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPBalanceAccountPadViewController" bundle:nil];
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
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"结算中心";
    self.UMStr = @"结算中心";
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.jpg"]];
    stitleArray=[[NSMutableArray alloc] initWithObjects:@"",@"支付方式：",@"现金账户：",@"配送方式：",@"发票信息：", @"优 惠 劵：",@"",@"留  言：",nil];
    
    [self setRightBarButton:@"提交订单" backgroundimagename:@"barButton.png" target:self action:@selector(submitOrderPay)];
    
    //页面加载没有选择任何优惠劵，所以先是为0.
    ticketdiscount = 0.0;
    //页面首次加载的时候，总支付金额就是共需支付
    _totalPayLabel.text=OUO_STRING_FORMAT(@"￥%.2f",[_shopCartData.mSumAmount floatValue]);
    //页面首次加载的时候，商品小计则是传过来的需要支付金额+折扣金额
    _productTotalLabel.text=[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue] + [_shopCartData.mDiscountAmount floatValue]];
    //优惠金额
    _discountAmountLabel.text=[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mDiscountAmount floatValue]];
    //开始运费显示为空
    _feeLabel.text = @"￥0.00";
    //现金账户
    _moneyAccountLabel.text = @"￥0.00";
    
    //页面加载的时候，先给账户赋值，用来记录该页面本次使用的哪个账户(如果用户进入了结算界面，又切换到其他页面注销了，重新登陆，则会造成账户不一致的情况，所以这里做此记录)
    //    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    //    NSData *memberdata = [userdefault objectForKey:@"memberdata"];
    //    Member *member = [NSKeyedUnarchiver unarchiveObjectWithData:memberdata];
    if ([SPStatusUtility isUserLogin]) {
        
        Member *member = [[Member allObjects] objectAtIndex:0];
        self.lastaccount = member.maccount;
    }
    
    
    //请求到默认地址
    defaultAddressAction=[[SPSetDefaultAddressAction alloc] init];
    defaultAddressAction.m_delegate_setDefault=self;
    [defaultAddressAction requestAddressSetDefault];
    [self showHUD];
    
    //请求个人信息
    SPGetMemberInfoAction *infoaction = [[SPGetMemberInfoAction alloc] init];
    [infoaction requestData:SP_URL_GETMEMBERINFO methodName:SP_METHOD_GETMEMBERINFO createParaBlock:^NSDictionary
     *{
         return nil;
     } requestSuccessBlock:^(id returnmember) {
         self.member = returnmember;
         _pricetext.placeholder = [NSString stringWithFormat:@"当前余额为%.2f",self.member.mprice.floatValue];
     } requestFailureBlock:^(ASIHTTPRequest *request) {
         _pricetext.placeholder = [NSString stringWithFormat:@"当前余额为%.2f",self.member.mprice.floatValue];
     }];
    [infoaction release];
}

-(void)viewWillAppear:(BOOL)animated
{
    //这里之所以这样写，是因为假设我们将页面停留在结算中心，然后切换到了会员中心，注销了账户，然后重新进行了登陆，那么账户会变更，所以这里重新拿一次，比较两个的account，如果不同，则回到rootview(购物车界面)
    if ([SPStatusUtility isUserLogin]) {
        
        Member *member = [[Member allObjects] objectAtIndex:0];
        _lastaccount = member.maccount;
        if (_lastaccount != nil && ![_lastaccount isEqualToString:member.maccount]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
    
    
    [super viewWillAppear:animated];
}

#pragma mark tableview的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        if (indexPath.section == 0) return 170;
        if (indexPath.section == 6)  return 174;
        return 80;
    }else{
        if (indexPath.section == 0) return 85;
        if (indexPath.section == 6)  return 87;
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.layer.borderColor = [[UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.00] CGColor];
        
        
        
        if (section == 2) {
            if (self.isPad) {
                cell.textLabel.frame = CGRectMake(16, 20, 140, 44);
                _pricetext = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, 450, 80)];
                [_pricetext setFont:[UIFont boldSystemFontOfSize:26]];
            }else{
                cell.textLabel.frame = CGRectMake(8, 10, 70, 22);
                _pricetext = [[UITextField alloc] initWithFrame:CGRectMake(75, 0, 225, 40)];
                [_pricetext setFont:[UIFont boldSystemFontOfSize:14]];
            }
            _pricetext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _pricetext.keyboardType = UIKeyboardTypeDecimalPad;
            _pricetext.tag = PRICETEXT;
            _pricetext.delegate =self;
            [cell.contentView addSubview:_pricetext];
        }
        if (section == 4) {
            if (self.isPad) {
                cell.textLabel.frame = CGRectMake(16, 20, 140, 44);
                _invoicetext = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 300, 60)];
                [_invoicetext setFont:[UIFont boldSystemFontOfSize:26]];
            }else{
                cell.textLabel.frame = CGRectMake(8, 10, 70, 2);
                _invoicetext = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 200, 30)];
                [_invoicetext setFont:[UIFont boldSystemFontOfSize:14]];
            }
            
            _invoicetext.tag = INVOICETEXT;
            _invoicetext.adjustsFontSizeToFitWidth =YES;
            _invoicetext.minimumFontSize = 6;
            _invoicetext.text = @"选择发票信息";
            _invoicetext.textColor = [UIColor blueColor];
            
            [cell.contentView addSubview:_invoicetext];
        }
        if (section == 5) {
            if (self.isPad) {
                cell.textLabel.frame = CGRectMake(16, 20, 140, 44);
                _discountcardtext = [[UITextField alloc] initWithFrame:CGRectMake(150, 10, 300, 60)];
                [_discountcardtext setFont:[UIFont boldSystemFontOfSize:26]];
            }else{
                cell.textLabel.frame = CGRectMake(8, 10, 70, 2);
                _discountcardtext = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 150, 30)];
                [_discountcardtext setFont:[UIFont boldSystemFontOfSize:14]];
            }
            _discountcardtext.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _discountcardtext.tag = DISCOUNTCARTEXT;
            _discountcardtext.delegate = self;
            _discountcardtext.enabled = NO;
            _discountcardtext.borderStyle = UITextBorderStyleNone;
            _discountcardtext.layer.borderColor = [[UIColor grayColor] CGColor];
            [cell.contentView addSubview:_discountcardtext];
        }
        cell.textLabel.text=[stitleArray objectAtIndex:section];
        NSLog(@"%@",cell.textLabel.text);
    }
    
    if (section!=6&&section!=2){
        
        if (section == 5) {
            
            
            if (![strOrEmpty(self.discountcardtext.text) isEqualToString:@""]) {
                
                delete_coupoons = [UIButton buttonWithType:UIButtonTypeCustom];
                [delete_coupoons setBackgroundImage:[UIImage imageNamed:@"coupons-delete"] forState:UIControlStateNormal];
                [delete_coupoons setBackgroundImage:[UIImage imageNamed:@"coupons-delete"] forState:UIControlStateHighlighted];
                [delete_coupoons addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
                [delete_coupoons setFrame:CGRectMake(0, 0, 25, 25)];
                cell.accessoryView=delete_coupoons;
            }else{
                cell.accessoryView=nil;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }
        }else
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//现金账户和金额显示的section不需要深入到子页面
    }
    if (section==0) [cell.contentView addSubview:_saddressedView];
    if (section==6) [cell.contentView addSubview:_spriceView];
    if (section==2) cell.textLabel.textColor=[UIColor redColor];
    if (self.isPad) {
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:26]];
    }else{
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lastindexpath = indexPath;
    switch (indexPath.section) {
        case 0:{
            [Go2PageUtility  go2AddressManagerViewControllerFrom:self isEdit:NO];
            break;
        }
        case 1:{
            
            if (requsetData == nil || requsetData.mAreaId == nil ||[requsetData.mAreaId isEqualToString:@""]) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"收货地址不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                
                return;
            }
            
            if (self.cashString.floatValue>self.member.mprice.floatValue) {
                self.selectedCell  = [tableView cellForRowAtIndexPath:indexPath];
                self.selectedCell.selected = NO;
                return;
            }
            //            if (requsetData == nil || requsetData.mAreaId == nil ||[requsetData.mAreaId isEqualToString:@""]) {
            //                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            //                [UIViewHealper helperBasicUIAlertView:nil message:@"您还没有填写任何收货地址"];
            //                return;
            //            }
            
            [Go2PageUtility go2wayViewController:self withTitle:@"支付方式" state:NO areaId:requsetData.mAreaId paymentId:nil lastselectname:self.paymentname];
            break;
        }
        case 3:{
            if (requsetData == nil || requsetData.mAreaId == nil ||[requsetData.mAreaId isEqualToString:@""]) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"收货地址不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
               
                return;
            }
            if (self.paymentID == nil || [self.paymentID isEqualToString:@""]) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                   [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"支付方式不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [UIViewHealper helperBasicUIAlertView:nil message:@"支付方式不能为空"];
                return;
            }
            
            if (self.cashString.floatValue>self.member.mprice.floatValue) {
                self.selectedCell  = [tableView cellForRowAtIndexPath:indexPath];
                self.selectedCell.selected = NO;
                return;
            }else{
                if(self.paymentID == nil || [self.paymentID isEqualToString:@""]){
                       [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"支付方式未填写" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                    [UIViewHealper helperBasicUIAlertView:nil message:@"支付方式未填写"];
                    self.navigationItem.rightBarButtonItem.enabled = YES;
                    self.selectedCell  = [tableView cellForRowAtIndexPath:indexPath];
                    self.selectedCell.selected = NO;
                    return;
                }
            }
            
            [Go2PageUtility go2wayViewController:self withTitle:@"配送方式" state:YES areaId:requsetData.mAreaId paymentId:self.paymentID lastselectname:self.shippingName];
            break;
        }
        case 4:{
            InvoiceSelectController *vc = [[InvoiceSelectController alloc] init];
            vc.delegate = self;
            vc.invoiceHead = self.invoiceHead;
            vc.invoiceID = self.invoiceID;
            
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:{
            [Go2PageUtility go2DiscountCardListViewControllerFrom:self pageName:@"shoppingCart" fromWhere:@"fromSettlementCenter"];
            break;
        }
        case 7:{
            [Go2PageUtility go2messageViewController:self userId:nil remark:self.remark];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 从子页面传支付方式过来
-(void)tableViewPassPaymentId:(NSString *)paymentId paymentName:(NSString *)paymentName
{
    [self.navigationController popViewControllerAnimated:YES];
    //这里有2种情况，第一种是第一次选择支付方式，第二种是第二次选择支付方式，当第二种的情况下，且我们的支付方式有变换的时候，我们需要修改运费（设置成空），总支付价格（总价格减去现金账户金额减去优惠劵优惠，运费已经为空了，所以不需要加）
    if(self.paymentID != nil && ![self.paymentID isEqualToString:paymentId]){
        NSIndexPath *shippingindexPath = [NSIndexPath indexPathForRow:0 inSection:3];
        UITableViewCell *shippingcell = [self.tableView cellForRowAtIndexPath:shippingindexPath];
        if (shippingcell!= nil) {
            shippingcell.textLabel.text = @"配送方式:";
        }
        _feeLabel.text = @"￥0.00";//运费清成空
         
        if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {//如果输入过现金账户
            float price = [self getMoneyFloatValue:_pricetext.text];
            //您共需支付的
           _totalPayLabel.text = [self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-ticketdiscount-price]];//支付的费用改为总价格
            
        }else{//如果没有输入现金账户
            
            _totalPayLabel.text = [self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-ticketdiscount]];
         
              
        }
    }
    self.paymentID=paymentId;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastindexpath];
    cell.textLabel.text = [NSString stringWithFormat:@"支付方式:%@",paymentName];
    self.paymentname = paymentName;
}

#pragma mark 从子页面传运送方式过来
-(void)tableViewPassShippingID:(NSString *)shippingId  shippingName:(NSString *)shippingName
{
    [self.navigationController popViewControllerAnimated:YES];
    self.shippingID=shippingId;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastindexpath];
    cell.textLabel.text = [NSString stringWithFormat:@"配送方式:%@",shippingName];
    self.shippingName = shippingName;
    [self requestShippingFee];
}
//删除优惠劵的操作
-(void)clear{
    
    self.discountcardtext.text = @"";
    self.discountAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mDiscountAmount floatValue]];//优惠金额
    self.ticketdiscount = 0.0;
    float price = [self getMoneyFloatValue:_pricetext.text];
    float feed = [self getMoneyFloatValue:_feeLabel.text];
    _totalPayLabel.text =[self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]+feed-price ]];
    [self refurbish];
}
-(void)refurbish{
    
    [_tableView reloadData];
}
#pragma mark 从子页面传优惠劵信息过来
- (void)tableViewPassTicketDiscount:(NSString *)ticketno discount:(float)discount
{
    self.ticketno = ticketno;
    self.discountcardtext.text = self.ticketno;
    self.ticketdiscount = [[NSString stringWithFormat:@"%.2f",discount] floatValue];
    _discountAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",self.ticketdiscount+[_shopCartData.mDiscountAmount floatValue]];
    float feetempvalue = 0.0;//得到运费
    if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@""]){
        feetempvalue = [self getMoneyFloatValue:_feeLabel.text];
    }
    float pricetempvalue = 0.0;//得到现金账户
    if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
        pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
        if(pricetempvalue!=0&&pricetempvalue>=ticketdiscount){
//            pricetempvalue=pricetempvalue-ticketdiscount;
            if (pricetempvalue>=([_shopCartData.mSumAmount floatValue]-ticketdiscount)){
                pricetempvalue=[_shopCartData.mSumAmount floatValue]-ticketdiscount;
            }
            _pricetext.text=[NSString stringWithFormat:@"￥%.2f",pricetempvalue];
//            self.cashString=[NSString stringWithFormat:@"%.2f",pricetempvalue];
            self.moneyAccountLabel.text = _pricetext.text;
        }
    }
    
//    if(pricetempvalue>0){
//        _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue];
//        
//    }else{
        float incomCash = [_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-ticketdiscount;
        if (incomCash<0) {
            _pricetext.text = [NSString stringWithFormat:@"￥%.2f",pricetempvalue+incomCash];
            self.moneyAccountLabel.text = [NSString stringWithFormat:@"￥%.2f",pricetempvalue+incomCash];
            _totalPayLabel.text = @"￥0.00";
        }else  _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",incomCash];
//    }
    
    //共需支付=共需支付-现金账户+运费-优惠劵金额
    //    _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-self.ticketdiscount];
    [self refurbish];
}

#pragma mark 从子页面传地址列表过来
//发票信息
-(void)selected_invoice:(id)data{
    self.invoiceName = data[@"InvoiceName"];
    self.invoiceID = data[@"InvoiceID"];
    self.invoiceHead = data[@"InvoiceHead"];
    self.invoicetext.text = [NSString stringWithFormat:@"%@:%@",self.invoiceName,self.invoiceHead];
}

-(void)passAddressListData:(SPAddressListData *)list
{
    requsetData=[list retain];
    [self.navigationController popViewControllerAnimated:YES];
    _addressLabel.text=list.mAddressInfo;
    _phoneLabel.text=list.mMobile;
    _zipCodeLabel.text=list.mZipCode;
    _consigneeLabel.text=list.mConsignee;
    self.addressobject = list;
    //    [self requestShippingFee];//客户要求地址传过来之后，将支付方式和配送方式置空
    
    self.shippingID=nil;
    self.shippingName = nil;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:3];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexpath];
    cell.textLabel.text = @"配送方式:";
    
    self.paymentID=nil;
    self.paymentname = nil;
    indexpath = [NSIndexPath indexPathForRow:0 inSection:1];
    cell = [self.tableView cellForRowAtIndexPath:indexpath];
    cell.textLabel.text = @"支付方式:";
    
    _feeLabel.text = @"￥0.00";
    //共需支付=共需支付-现金账户-优惠劵金额
    float pricetempvalue = 0.0;//得到现金账户
    if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
        pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
    }
     
    _totalPayLabel.text =  [self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue -self.ticketdiscount]];;
    
}

#pragma mark 请求默认地址
//由于没有需要传递的参数，所以这里传参的方法并没有写
-(void)onResponseAddressSetDefaultSuccess:(SPAddressListData*)addressList
{
    [self hideHUD];
    self.addressobject = addressList;
    requsetData=[addressList retain];
    _addressLabel.text=addressList.mAddressInfo;
    _phoneLabel.text=addressList.mMobile;
    _zipCodeLabel.text=addressList.mZipCode;
    _consigneeLabel.text=addressList.mConsignee;
}

-(void)onResponseAddressSetDefaultFail
{
    [self hideHUD];
}

#pragma mark 提交订单
-(void)submitOrderPay
{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.view endEditing:YES];
    
    if (self.discountcardtext.text != nil && ![self.discountcardtext.text isEqualToString:@""]) {
        [self requestTicketInfo:self.discountcardtext];
        
    }else{
        
        [self submitOrderPayAfterValidateTicket];
    }
}

- (void)submitOrderPayAfterValidateTicket
{
    if (requsetData == nil || requsetData.mAreaId == nil ||[requsetData.mAreaId isEqualToString:@""]) {
        
           [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"您还没有填写任何收货地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
//        [UIViewHealper helperBasicUIAlertView:nil message:@"您还没有填写任何收货地址"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }else if(self.cashString.floatValue > self.member.mprice.floatValue){
        //        [UIViewHealper helperBasicUIAlertView:@"错误" message:@"输入的金额大于您的现金账户，请重新输入"];
        //        self.navigationItem.rightBarButtonItem.enabled = YES;
                 return;
    }
        
     else   if(self.paymentID == nil || [self.paymentID isEqualToString:@""]){

         [SPStatusUtility showAlert:@"提示" message:@"支付方式未填写" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [UIViewHealper helperBasicUIAlertView:nil message:@"支付方式未填写"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;

    }else if([_pricetext.text floatValue] > [_shopCartData.mSumAmount floatValue] + [_shopCartData.mDiscountAmount floatValue]){
         [SPStatusUtility showAlert:@"提示" message:@"输入的金额大于商品小计总数，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
//        [UIViewHealper helperBasicUIAlertView:@"错误" message:@"输入的金额大于商品小计总数，请重新输入"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }else if(self.shippingID == nil || [self.shippingID isEqualToString:@""] ){
           [SPStatusUtility showAlert:@"提示" message:@"配送方式未填写" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
       
        self.navigationItem.rightBarButtonItem.enabled = YES;
        return;
    }else {
    }
    
    submitAction =[[SPSubmitOrderAction alloc] init];
    submitAction.m_delegate_submitOrder=self;
    [submitAction requestSubmitOrderData];
    [self showHUDWithMessage:@"提交订单"];
}


-(NSDictionary *)onRequestSubmitOrderAction
{
    NSMutableDictionary *requsetDic=[[NSMutableDictionary alloc] init];
    [requsetDic setObject:requsetData.mConsignee forKey:@"Consignee"];
    [requsetDic setObject:requsetData.mProvinceID forKey:@"ProvinceId"];
    [requsetDic setObject:requsetData.mCityId forKey:@"CityId"];
    [requsetDic setObject:requsetData.mAreaId forKey:@"AreaId"];
    [requsetDic setObject:requsetData.mAddress forKey:@"Address"];
    [requsetDic setObject:requsetData.mZipCode forKey:@"ZipCode"];
    [requsetDic setObject:requsetData.mMobile forKey:@"Mobile"];
    [requsetDic setObject:requsetData.mTel forKey:@"Tel"];
    [requsetDic setObject:self.remark==nil?@"":self.remark forKey:@"Remark"];
    
    if (self.shippingID) {
        [requsetDic setObject:self.shippingID forKey:@"ShippingId"];
    }
    if (self.paymentID) {
        [requsetDic setObject:self.paymentID forKey:@"PaymentId"];
    }
    float price = [self getMoneyFloatValue:_pricetext.text];
    [requsetDic setObject:[NSString stringWithFormat:@"%.2f",price] forKey:@"AllCash"];//现金账户字段
    //    if (self.ticketno != nil) {//假如使用了优惠劵
    if (self.discountcardtext.text != nil && ![self.discountcardtext.text isEqualToString:@""]) {//这里做了修正，将最开始选择优惠劵改为了可手工输入也可选择两种，所以，这里传的内容改为了discountcardtext的value
        //        [requsetDic setObject:self.ticketno forKey:@"TicketNo"];
        [requsetDic setObject:self.discountcardtext.text forKey:@"TicketNo"];
    }
    return [requsetDic autorelease];
}

-(void)onResponseSubmitOrderDataSuccess:(PersonalOrder *)l_data_UpdateShopCart
{
    [self hideHUD];
      self.navigationItem.rightBarButtonItem.enabled = NO;
    SPOrderPayViewController *orderPay=[[SPOrderPayViewController alloc] init];
    orderPay.po = l_data_UpdateShopCart;
    orderPay.ticketdiscount = self.ticketdiscount;
    
    [self.navigationController pushViewController:orderPay animated:YES];
    [orderPay release];
}

-(void)onResponseSubmitOrderDataFail{
    
    [self hideHUD];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}
-(NSString *)formatTotalPay:(NSString *)totalString{
    if ([totalString isEqualToString:@"-￥0.00"] || [totalString isEqualToString:@"￥-0.00"]) {
        return @"￥0.00";
    }else
    {
        return totalString;
    }
    
}
#pragma mark 请求运费
- (void)requestShippingFee
{
    if (self.addressobject!= nil && self.addressobject.mProvinceID!=nil &&self.addressobject.mAreaId!=nil&&self.shippingID!=nil) {
        SPShippingFeeAction *spsfa = [[SPShippingFeeAction alloc] init];
        [spsfa requestData:SP_URL_GETSHIPPINGFEE methodName:SP_METHOD_GETSHIPPINGFEE createParaBlock:^NSDictionary *{
            return [NSDictionary dictionaryWithObjectsAndKeys:self.addressobject.mProvinceID,@"ProvId",self.addressobject.mAreaId,@"AreaId",self.shippingID,@"ShippingID", nil];
        } requestSuccessBlock:^(id shippingfee) {
            NSString *shippingfeestr = shippingfee;
            _feeLabel.text = [NSString stringWithFormat:@"￥%.2f",shippingfeestr.doubleValue];
            //共需支付=支付金额+运费-现金账户-优惠劵折扣，这里需要判断，加入对方输入过，则需要减去现金账户，如果并没有输入过现金账户，则不需要家
         

            if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
                float price = [self getMoneyFloatValue:_pricetext.text];
                 
                _totalPayLabel.text =[self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]+[shippingfeestr floatValue]-ticketdiscount-price]];
                
            }else{
                
                _totalPayLabel.text = [self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]+[shippingfeestr floatValue]-ticketdiscount]];
            }
        } requestFailureBlock:^(ASIHTTPRequest *request) {
                 [SPStatusUtility showAlert:@"" message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [UIViewHealper helperBasicASIFailUIAlertView];
        }];
    }
}

#pragma mark textfield的代理

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    self.cashString = textField.text;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.discountcardtext resignFirstResponder];
    [self.pricetext resignFirstResponder];
    [self.invoicetext resignFirstResponder];
}
 

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (_pricetext.text) {
            textField.text = _pricetext.text;
        _pricetext.text = @"";
    }
    else
    {
        textField.text = nil;
    }
     
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
 
    if (textField.tag == PRICETEXT) {
        if ([textField.text isEqualToString:@""]) {
            float feetempvalue =0.0;
            if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@""]){
                feetempvalue = [self getMoneyFloatValue:_feeLabel.text];
            }
            float pricetempvalue = 0.0;//得到现金账户
            if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
                pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
            }
            
             _moneyAccountLabel.text = @"￥0.00";

            
            _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-ticketdiscount];
        }
        self.cashString = textField.text;
        float sumTotal = [_shopCartData.mSumAmount floatValue];
   
        float textNumber = [textField.text floatValue];
        
        float totalpaytempvalue = 0.0;//现金账户不能用来支付运费，所以这里的参考值必须减去运费
        if (textNumber > [self.member.mprice floatValue]) {
            [SPStatusUtility showAlert:@"提示" message:@"输入的金额大于您的现金账户，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
  
            
            textField.text = nil;
          
            textField.placeholder = [NSString stringWithFormat:@"当前余额为%.2f",[self.member.mprice floatValue]];
            self.cashString = self.member.mprice;
            return;
        }else{
            
            
            if (!([textField.text isEqualToString:@""]||[textField.text isEqualToString:nil])) {
                textField.text = [NSString stringWithFormat:@"￥%.2f",[textField.text floatValue]];
               
                if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@" "]&&![_feeLabel.text isEqualToString:@"￥0.00"]&&![_feeLabel.text isEqualToString:@"0.00"]) {
                    NSLog(@"333");
                    float price = [self getMoneyFloatValue:_pricetext.text];
                    float fee = [self getMoneyFloatValue:_feeLabel.text];
                    
                    if (price<=(sumTotal-ticketdiscount)) {
                        _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]+ fee-ticketdiscount-price ];
                    }else{
                        totalpaytempvalue = [self getMoneyFloatValue:_totalPayLabel.text] - [self getMoneyFloatValue:_feeLabel.text];
                        if(textNumber > totalpaytempvalue){
                            [SPStatusUtility showAlert:@"提示" message:@"输入的金额大于您需要支付的金额，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
  
                            if (ticketdiscount == 0.0f) {
                                textField.text = [NSString stringWithFormat:@"￥%.2f",sumTotal];
                            }else{
                                textField.text = [NSString stringWithFormat:@"￥%.2f",sumTotal-ticketdiscount];
                            }
                            _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f", fee];
//                            _totalPayLabel.text = [NSString stringWithFormat: @"￥%.2f",totalpaytempvalue];
                            textField.placeholder = [NSString stringWithFormat:@"当前余额为%.2f",[self.member.mprice floatValue]];
                        }
                        
                    }
                    
                }else{
                  
                    float price = [self getMoneyFloatValue:_pricetext.text];
                    
                    if (price<=(sumTotal-ticketdiscount)) {
                        _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-price-ticketdiscount];
                    }else{
                        totalpaytempvalue = [self getMoneyFloatValue:_totalPayLabel.text];
                        if(textNumber > totalpaytempvalue){
                             
                            
                            if (ticketdiscount == 0.0f) {
                                textField.text = [NSString stringWithFormat:@"￥%.2f",sumTotal];
                            }else{
                                textField.text = [NSString stringWithFormat:@"￥%.2f",sumTotal-ticketdiscount];
                            }
                            
                            
//                            _totalPayLabel.text = [NSString stringWithFormat: @"￥%.2f",totalpaytempvalue];
                            
                            float feetempvalue = 0.0;//得到运费
                            if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@""]){
                                feetempvalue = [self getMoneyFloatValue:_feeLabel.text];
                            }
                            float pricetempvalue = 0.0;//得到现金账户
                            if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
                                pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
                            }
                            //共需支付=共需支付-现金账户+运费-优惠劵金额
                            NSString *totalNumber = [NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-ticketdiscount];
                            DLog(@"total number ----- %@",totalNumber);
                            if ([totalNumber isEqualToString:@"-￥0.00"] || [totalNumber isEqualToString:@"￥-0.00"]) {
                                totalNumber =@"￥0.00";
                            }
                            
                            _totalPayLabel.text = totalNumber;
                            
                            textField.placeholder = [NSString stringWithFormat:@"当前余额为%.2f",[self.member.mprice floatValue]];
                            
                            [SPStatusUtility showAlert:@"提示" message:@"输入的金额大于您需要支付的金额，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            self.navigationItem.rightBarButtonItem.enabled = YES;
                            return;
                        }
                        
                    }
                }
                
            }
            
            _moneyAccountLabel.text = textField.text;
        }
    }else if(textField.tag == DISCOUNTCARTEXT){
        
        if (self.discountcardtext.text == nil || [self.discountcardtext.text isEqualToString:@""]) {
            //这里要处理清空的情况，当他清空之后，首先将优惠劵的打折金额改为0，然后修改其他的金额
            self.ticketdiscount = 0.0;
            _discountAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",self.ticketdiscount+[_shopCartData.mDiscountAmount floatValue]];
            float feetempvalue = 0.0;//得到运费
            if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@""]){
                feetempvalue = [self getMoneyFloatValue:_feeLabel.text];
            }
            float pricetempvalue = 0.0;//得到现金账户
            if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
                pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
            }
            //共需支付=共需支付-现金账户+运费-优惠劵金额
            _totalPayLabel.text =[self formatTotalPay:[NSString stringWithFormat:@"￥%.2f",[_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-ticketdiscount]];
        }
    }
}

#pragma mark uialterViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.cashString = @"0.0";
    
}

- (void)requestTicketInfo:(UITextField *)textField
{
    if (textField.text == nil || [textField.text isEqualToString:@""]) {
        return;
    }
    SPGetTicketInfoAction *tickerinfoaction = [[SPGetTicketInfoAction alloc] init];
    [tickerinfoaction requestData:SP_URL_GETTICKETINFO methodName:SP_METHOD_GETTICKETINFO createParaBlock:^NSDictionary *{
        return [NSDictionary dictionaryWithObjectsAndKeys:textField.text,@"TicketNo", nil];
    } requestSuccessBlock:^(id ticketmessage) {
        NSDictionary *dict = (NSDictionary *)ticketmessage;
        
        if ([[dict valueForKey:@"ErrorCode"] isEqualToString:@"0"]) {
            if ([[[dict valueForKey:@"Data"] valueForKey:@"ValidateResult"] isEqualToString:@"可使用此优惠券"]) {
                self.ticketdiscount = [[[[dict valueForKey:@"Data"] valueForKey:@"Ticket"] valueForKey:@"DiscountAmount"] floatValue];//优惠金额
                _discountAmountLabel.text = [NSString stringWithFormat:@"￥%.2f",self.ticketdiscount+[_shopCartData.mDiscountAmount floatValue]];
                float feetempvalue = 0.0;//得到运费
                if (_feeLabel.text!=nil && ![_feeLabel.text isEqualToString:@""]){
                    feetempvalue = [self getMoneyFloatValue:_feeLabel.text];
                }
                float pricetempvalue = 0.0;//得到现金账户
                if (_pricetext.text!=nil && ![_pricetext.text isEqualToString:@""]) {
                    pricetempvalue = [self getMoneyFloatValue:_pricetext.text];
                }
                
                //共需支付=共需支付（指的是商品小计）-现金账户+运费-优惠劵金额
                float incomCash = [_shopCartData.mSumAmount floatValue]-pricetempvalue + feetempvalue-ticketdiscount;
                _totalPayLabel.text = [NSString stringWithFormat:@"￥%.2f",incomCash];
                
                [self submitOrderPayAfterValidateTicket];
            }else{
                
                [UIViewHealper helperBasicUIAlertView:@"速普提示" message:[[dict valueForKey:@"Data"] valueForKey:@"ValidateResult"]];
            }
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } requestFailureBlock:^(ASIHTTPRequest *request) {
        
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
    [tickerinfoaction release];
}

//将￥5.00这样的字符截取，获得5这个数字
- (float)getMoneyFloatValue:(NSString *)labeltext
{
//    NSLog(@"labelText ---------- %@",labeltext);
    
    NSInteger moneycharlocation = [labeltext rangeOfString:@"￥"].location;
    
    if ([labeltext length]>1) {
      NSString *pricestr = [labeltext substringFromIndex:moneycharlocation+1];
        
        return pricestr.floatValue;
    }
    return 0.0f;
  
}

- (void)viewDidUnload
{
    [self setSaddressedView:nil];
    [self setSpriceView:nil];
    self.tableView=nil;
//    stitleArray=nil;
    self.consigneeLabel=nil;
    self.addressLabel=nil;
    self.zipCodeLabel=nil;
    self.phoneLabel=nil;
//    self.member = nil;
//    self.pricetext = nil;
//    self.lastaccount = nil;
//    self.paymentname = nil;
//    self.shippingName = nil;
//    self.discountcardtext = nil;
//    self.cashString = nil;
//    self.selectedCell = nil;
//    self.delete_coupoons = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [stitleArray release];
    [_tableView release];
    [_saddressedView release];
    [_spriceView release];
    [_addressLabel release];
    [_zipCodeLabel release];
    [_phoneLabel release];
    [_consigneeLabel release];
    [_paymentID release];
    [_shippingID release];
    [_member release];
    [_pricetext release];
    [_lastaccount release];
    [_paymentname release];
    [_shippingName release];
    [_discountcardtext release];
    [cashString release];
    [selectedCell release];
    [delete_coupoons release];
    [_invoicetext release];
    [_invoiceID release];
    [_invoiceHead release];
    [_invoiceName release];
    [super dealloc];
}


@end
