//
//  PersonalOrderDetail.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalOrderDetail.h"
#import "RequestHelper.h"
#import "OrderDetail.h"
#import "UIImageView+WebCache.h"
#import "OrderProcessDetail.h"
#import "sqlService.h"
@interface PersonalOrderDetail ()

@property (retain, nonatomic) NSMutableArray *podarr;
@property (retain, nonatomic) UITableView *orderdetailtableview;
@property (assign, nonatomic) float totalmoney;
@property BOOL isPad;
@property (assign,nonatomic) float countPrice;

@end

@implementation PersonalOrderDetail
@synthesize personalorder;
@synthesize podarr;
@synthesize orderdetailtableview;
@synthesize totalmoney;
@synthesize isPad;
@synthesize countPrice;
@synthesize isStyle;
@synthesize orderSN = _orderSN;
- (void)dealloc
{
    [personalorder release];
    [podarr release];
    [orderdetailtableview release];
    [super dealloc];
}

- (void)popView:(id)sender
{
    if (isStyle) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    self.isPad = iPad;
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    orderdetailtableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    if (self.isPad) {
        orderdetailtableview.frame = CGRectMake(0, 0, 768, 860);
    }else{
        orderdetailtableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    orderdetailtableview.delegate = self;
    orderdetailtableview.dataSource = self;
    orderdetailtableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.jpg"]];
    [self.view addSubview:orderdetailtableview];
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    self.title = @"订单详情";
    self.UMStr= @"订单详情";
    
    self.orderdetailtableview.hidden = YES;
    
    [self personalOrdersDetailSelect];
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

#pragma mark 表格的代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.podarr.count+1;
    }
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGSize cgsize;
        if (self.isPad) {
            cgsize = CGSizeMake(550, HUGE_VALF);
            CGSize size =[self.personalorder.Address sizeWithFont:[UIFont systemFontOfSize:26]  constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            return 310 + size.height - 30;
        }else{
            cgsize = CGSizeMake(200, HUGE_VALF);
            CGSize size =[self.personalorder.Address sizeWithFont:[UIFont systemFontOfSize:13]  constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            return 150 + size.height - 16;
        }
    }else if (indexPath.section ==1 && indexPath.row == self.podarr.count){
        if (self.isPad) {
            return 170;
        }else{
            return 88;
        }
    }else {
        OrderDetail *od = [self.podarr objectAtIndex:indexPath.row];
        CGSize cgsize;
        if (self.isPad) {
            cgsize = CGSizeMake(580, HUGE_VALF);
            NSString *measurestr = [NSString stringWithFormat:@"%@111111111111111",od.GoodsName];
            CGSize goodsnamesize =[measurestr sizeWithFont:[UIFont boldSystemFontOfSize:26] constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            return ((30+goodsnamesize.height)<100?100:(30+goodsnamesize.height));
        }else{
            cgsize = CGSizeMake(215, HUGE_VALF);
            NSString *measurestr = [NSString stringWithFormat:@"%@111111111111111",od.GoodsName];
            CGSize goodsnamesize =[measurestr sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            return ((10+goodsnamesize.height)<46?46:(10+goodsnamesize.height));
        }
    }
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        return 1;
    }
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isPad) {
        if (section ==0) {
            return 50;
        }
        if (section ==1) {
            return 100;
        }
    }else{
        if (section ==0) {
            return 28;
        }
        if (section ==1) {
            return 50;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *goodsdetailtipview = nil;
        UILabel *gooddetailtiplabel = nil;
        if (self.isPad) {
            goodsdetailtipview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 50)];
            gooddetailtiplabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 268, 50)];
            [gooddetailtiplabel setFont:[UIFont boldSystemFontOfSize:28]];
        }else{
            goodsdetailtipview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
            gooddetailtiplabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 0, 90, 30)];
            [gooddetailtiplabel setFont:[UIFont boldSystemFontOfSize:14]];
        }
        gooddetailtiplabel.text = @"商 品 明 细";
        gooddetailtiplabel.textColor = [UIColor redColor];
        gooddetailtiplabel.backgroundColor = [UIColor clearColor];
        gooddetailtiplabel.textAlignment = UITextAlignmentCenter;
        [goodsdetailtipview addSubview:gooddetailtiplabel];
        [gooddetailtiplabel release];
        //内存警告13--------------------
        return [goodsdetailtipview autorelease] ;
    }
    if (section ==1) {
        UIView *controlview = nil;
        if (self.isPad) {
            controlview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 300)];
        }else{
            controlview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
        }
 
        
        if (self.countPrice != 0.0) {//总共支付的
            if (([self.personalorder.OrderAmount floatValue]+[self.personalorder.ShippingFee floatValue])!=0) {
                if (self.personalorder.PayStatus != nil && [self.personalorder.PayStatus isEqualToString:@"未支付"] && self.personalorder.OrderStatus != nil  && [self.personalorder.OrderStatus isEqualToString:@"待确认"] &&self.personalorder.PayName != nil && [self.personalorder.PayName isEqualToString:@"在线支付"]){
                    UIButton *paybtn = nil;
                    UIButton *cancelpaybtn = nil;
                    if (self.isPad) {
                        paybtn = [[UIButton alloc] initWithFrame:CGRectMake(284, 25, 200, 53)];
                        [paybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
                        cancelpaybtn = [[UIButton alloc] initWithFrame:CGRectMake(167, 11, 100, 28)];
                        [cancelpaybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                    }else{
                        paybtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 11, 100, 28)];
                        [paybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                        cancelpaybtn = [[UIButton alloc] initWithFrame:CGRectMake(167, 11, 100, 28)];
                        [cancelpaybtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                    }
                    UIImage *payimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"怀孕中按钮" ofType:@"png"]];
                    [paybtn setBackgroundImage:payimage forState:UIControlStateNormal];
                    [paybtn setTitle:@"支 付" forState:UIControlStateNormal];
                    [paybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
                    [controlview addSubview:paybtn];
                    [paybtn release];
                    
                    [self setRightBarButton:@"支付" backgroundimagename:@"顶部登录按钮" target:self action:@selector(pay:)];
//                    UIButton *l_rightPay=nil;
//                    UIView *l_view=nil;
//                    
//                    l_rightPay = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
//                    if (iPad) {
//                        [l_rightPay.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
//                    }else{
//                        [l_rightPay.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//                    }
//                    
//                    l_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
//                    
//                    UIImage *l_payimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"顶部登录按钮" ofType:@"png"]];
//                    [l_rightPay setBackgroundImage:l_payimage forState:UIControlStateNormal];
//                    [l_rightPay setTitle:@"支付" forState:UIControlStateNormal];
//                    [l_rightPay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
//                    
//                    [l_view addSubview:l_rightPay];
//                    [l_rightPay release];
//                    
//                    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:l_view] autorelease];
//                    [l_view release];
                    
                    
                    UIImage *cancelimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"怀孕中按钮灰色" ofType:@"png"]];
                    [cancelpaybtn setBackgroundImage:cancelimage forState:UIControlStateNormal];
                    [cancelpaybtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [cancelpaybtn addTarget:self action:@selector(cancelpay:) forControlEvents:UIControlEventTouchUpInside];
                    cancelpaybtn.hidden = YES;//客户提出不要这个按钮，为了避免我去测试或者修改任何东西，直接把它隐藏了
                    [controlview addSubview:cancelpaybtn];
                    [cancelpaybtn release];
                }
            }
            
        }
        return [controlview autorelease];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    
    NSString *identifer = [NSString stringWithFormat:@"Cell%d%d",section, [indexPath row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer] autorelease];

        cell.selectionStyle = UITableViewCellStyleDefault;
        
    
    }
    
    for (UILabel *view in cell.contentView.subviews) {
 
        [view removeFromSuperview];
 
    }
 
    
    if (indexPath.section == 0) {
        
        [cell.contentView addSubview:[self createOrderDetailTopView]];
        
    }else  if (indexPath.section == 1 &&indexPath.row == self.podarr.count ) {
        [cell.contentView addSubview:[self createOrderDetailBottomView]];
    }else {
        OrderDetail *od = [self.podarr objectAtIndex:indexPath.row];
        CGSize cgsize;
        UIImageView *snimageview = nil;
        NSString *measurestr = [NSString stringWithFormat:@"111111111111111%@",od.GoodsName];
        CGSize goodsnamesize;
        if (self.isPad) {
            cgsize = CGSizeMake(580, HUGE_VALF);
            goodsnamesize =[measurestr sizeWithFont:[UIFont boldSystemFontOfSize:26] constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            float imageheight = ((goodsnamesize.height-60)>0?(goodsnamesize.height-60):0);
            snimageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6+imageheight/2, 80, 80)];
        }else{
            cgsize = CGSizeMake(215, HUGE_VALF);
            goodsnamesize =[measurestr sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
            float imageheight = (goodsnamesize.height-32)>0?goodsnamesize.height-32:0;
            snimageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3+imageheight/2, 40, 40)];
        }
        
        NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
        
        if ( [showpicture isEqualToString:@"ON"]) {
            if(iPad){
                [snimageview setImageWithURL:URLImagePath(od.ImgFile) placeholderImage:[UIImage imageNamed:@"95-91.png"]];
            }else
                [snimageview setImageWithURL:URLImagePath(od.ImgFile) placeholderImage:[UIImage imageNamed:@"40-40.png"]];
        }else{
            if(iPad){
                [snimageview setImage:[UIImage imageNamed:@"95-91.png"]];
            }else
                [snimageview setImage:[UIImage imageNamed:@"40-40.png"]];
        }
        [cell.contentView addSubview:snimageview];
        [snimageview release];
        
        
        
        
        UILabel *goodsnamemessagelabel = nil;
        CGSize pricesize;
        CGSize countsize;
        if (self.isPad) {
            goodsnamemessagelabel=[[UILabel alloc] initWithFrame:CGRectMake(100,11,580,goodsnamesize.height)];
            [goodsnamemessagelabel setFont:[UIFont boldSystemFontOfSize:26]];
            pricesize = [od.Price sizeWithFont:[UIFont boldSystemFontOfSize:26]];
            countsize = [od.Count sizeWithFont:[UIFont boldSystemFontOfSize:26]];
        }else{
            goodsnamemessagelabel=[[UILabel alloc] initWithFrame:CGRectMake(75, 3, 215, goodsnamesize.height)];
            [goodsnamemessagelabel setFont:[UIFont boldSystemFontOfSize:13]];
            pricesize = [od.Price sizeWithFont:[UIFont boldSystemFontOfSize:13]];
            countsize = [od.Count sizeWithFont:[UIFont boldSystemFontOfSize:13]];
        }
        goodsnamemessagelabel.backgroundColor = [UIColor clearColor];
        goodsnamemessagelabel.text = od.GoodsName;
        goodsnamemessagelabel.numberOfLines = 0;
        goodsnamemessagelabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.contentView addSubview:goodsnamemessagelabel];
        [goodsnamemessagelabel release];
        
        UILabel *pricemessagelabel = nil;
        UILabel *countmessagelabel = nil;
        if (self.isPad) {
            pricemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(680-pricesize.width-50-countsize.width-40, 60, pricesize.width+40, 30)];
            [pricemessagelabel setFont:[UIFont boldSystemFontOfSize:26]];
            countmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(680-countsize.width-50,60, countsize.width+40, 30)];
            [countmessagelabel setFont:[UIFont boldSystemFontOfSize:26]];
        }else{
            pricemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(300-pricesize.width-25-countsize.width-20, goodsnamesize.height-5, pricesize.width+20, 15)];
            [pricemessagelabel setFont:[UIFont boldSystemFontOfSize:13]];
            countmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(300-countsize.width-25, goodsnamesize.height-5, countsize.width+20, 15)];
            [countmessagelabel setFont:[UIFont boldSystemFontOfSize:13]];
        }
        pricemessagelabel.backgroundColor = [UIColor clearColor];
        pricemessagelabel.text = [NSString stringWithFormat:@"￥%@",od.Price];
        pricemessagelabel.textColor = [UIColor redColor];
        [cell.contentView addSubview:pricemessagelabel];
        [pricemessagelabel release];
        
        countmessagelabel.backgroundColor = [UIColor clearColor];
        countmessagelabel.text = [NSString stringWithFormat:@" x %@",od.Count];
        [cell.contentView addSubview:countmessagelabel];
        [countmessagelabel release];
    }
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row!= self.podarr.count) {
        OrderDetail *od = [self.podarr objectAtIndex:indexPath.row];
        [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:od.GoodsSN from:self];
    }
}

#pragma mark 页面的cell的创建
- (UIView *)createOrderDetailTopView
{
    CGSize cgsize;
    CGSize size;
    UIView *topviw = nil;
    UILabel *ordersntiplabel = nil;
    UILabel *ordersnmessagelabel = nil;
    UILabel *consigneetiplabel = nil;
    UILabel *consigneemessagelabel = nil;
    UILabel *mobileteltiplabel = nil;
    UILabel *mobiletelmessagelabel = nil;
    UILabel *addresstiplabel = nil;
    UILabel *addressmessagelabel = nil;
    UILabel *zipcodetiplabel = nil;
    UILabel *zipcodemessagelabel = nil;
    UILabel *shippingnametiplabel = nil;
    UILabel *shippingnamemessagelabel= nil;
    UILabel *paynametiplabel = nil;
    UILabel *paynamemessagelabel = nil;
    UILabel *paystatustiplabel = nil;
    UILabel *paystatusmessagelabel = nil;
    UILabel *orderstatustiplabel = nil;
    UILabel *orderstatusmessagelabel = nil;
    if (self.isPad) {
        cgsize = CGSizeMake(480, HUGE_VALF);
        size =[self.personalorder.Address sizeWithFont:[UIFont systemFontOfSize:26]  constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
        topviw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 680, 300)];
        ordersntiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 120, 28)];
        [ordersntiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        ordersnmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 14, 400, 28)];
        [ordersnmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        consigneetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 44, 120, 28)];
        [consigneetiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        consigneemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 44, 400, 28)];
        [consigneemessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        mobileteltiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, 120, 28)];
        [mobileteltiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        mobiletelmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 74, 400, 28)];
        [mobiletelmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        addresstiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, 120, size.height-2)];
        [addresstiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        addressmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 104, 480, size.height-2)];
        [addressmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        zipcodetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 134+size.height-28, 120, 28)];
        [zipcodetiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        zipcodemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 134+size.height-28, 400, 28)];
        [zipcodemessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        shippingnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 164+size.height-28, 120, 28)];
        [shippingnametiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        shippingnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 164+size.height-28,400,28)];
        [shippingnamemessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        paynametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 194+size.height-28, 120, 28)];
        [paynametiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        paynamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 194+size.height-28, 400, 28)];
        [paynamemessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        paystatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 224+size.height-28, 120, 28)];
        [paystatustiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        paystatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 224+size.height-28, 200, 28)];
        [paystatusmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        orderstatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 254+size.height-28, 120, 28)];
        [orderstatustiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        orderstatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 254+size.height-28, 200, 28)];
        [orderstatusmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
    }else{
        cgsize = CGSizeMake(200, HUGE_VALF);
        size =[self.personalorder.Address sizeWithFont:[UIFont systemFontOfSize:13]  constrainedToSize:cgsize lineBreakMode:UILineBreakModeWordWrap];
        topviw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
        ordersntiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 60, 14)];
        [ordersntiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        ordersnmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 7, 200, 14)];
        [ordersnmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        consigneetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 60, 14)];
        [consigneetiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        consigneemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 22, 200, 14)];
        [consigneemessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        mobileteltiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 37, 60, 14)];
        [mobileteltiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        mobiletelmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 37, 200, 14)];
        [mobiletelmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        addresstiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 52, 60, size.height-2)];
        [addresstiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        addressmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 52, 200, size.height-2)];
        [addressmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        zipcodetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 67+size.height-16, 60, 14)];
        [zipcodetiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        zipcodemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 67+size.height-16, 200, 14)];
        [zipcodemessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        shippingnametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 82+size.height-16, 60, 14)];
        [shippingnametiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        shippingnamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 82+size.height-16, 200, 14)];
        [shippingnamemessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        paynametiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 97+size.height-16, 60, 14)];
        [paynametiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        paynamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 97+size.height-16, 200, 14)];
        [paynamemessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        paystatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 112+size.height-16, 60, 14)];
        [paystatustiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        paystatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 112+size.height-16, 100, 14)];
        [paystatusmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        orderstatustiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 127+size.height-16, 60, 14)];
        [orderstatustiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        orderstatusmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 127+size.height-16, 100, 14)];
        [orderstatusmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    
    ordersntiplabel.backgroundColor = [UIColor clearColor];
    ordersntiplabel.text = @"订单编号：";
    [topviw addSubview:ordersntiplabel];
    [ordersntiplabel release];
    
    ordersnmessagelabel.backgroundColor = [UIColor clearColor];
    ordersnmessagelabel.text = self.personalorder.OrderSN;
    [topviw addSubview:ordersnmessagelabel];
    [ordersnmessagelabel release];
    
    consigneetiplabel.backgroundColor = [UIColor clearColor];
    consigneetiplabel.text = @"收货人：";
    [topviw addSubview:consigneetiplabel];
    [consigneetiplabel release];
    
    consigneemessagelabel.backgroundColor = [UIColor clearColor];
    consigneemessagelabel.text = self.personalorder.Consignee;
    [topviw addSubview:consigneemessagelabel];
    [consigneemessagelabel release];
    
    mobileteltiplabel.backgroundColor = [UIColor clearColor];
    mobileteltiplabel.text = @"联系电话：";
    [topviw addSubview:mobileteltiplabel];
    [mobileteltiplabel release];
    
    mobiletelmessagelabel.backgroundColor = [UIColor clearColor];
    if (self.personalorder.Mobile == nil || self.personalorder.Tel == nil || [self.personalorder.Mobile isEqualToString:@""] || [self.personalorder.Tel isEqualToString:@""]) {
        mobiletelmessagelabel.text = [NSString stringWithFormat:@"%@%@",self.personalorder.Mobile,self.personalorder.Tel];
    }else{
        mobiletelmessagelabel.text = [NSString stringWithFormat:@"%@ / %@",self.personalorder.Mobile,self.personalorder.Tel];
    }
    [topviw addSubview:mobiletelmessagelabel];
    [mobiletelmessagelabel release];
    
    addresstiplabel.backgroundColor = [UIColor clearColor];
    addresstiplabel.text = @"收货地址：";
    [addresstiplabel sizeToFit];
    [topviw addSubview:addresstiplabel];
    [addresstiplabel release];
    
    addressmessagelabel.backgroundColor = [UIColor clearColor];
    addressmessagelabel.text = [self getAdress];
    addressmessagelabel.numberOfLines = 0;
    addressmessagelabel.lineBreakMode = UILineBreakModeWordWrap;
    [topviw addSubview:addressmessagelabel];
    [addressmessagelabel release];
    
    zipcodetiplabel.backgroundColor = [UIColor clearColor];
    zipcodetiplabel.text = @"邮政编码：";
    [topviw addSubview:zipcodetiplabel];
    [zipcodetiplabel release];
    
    zipcodemessagelabel.backgroundColor = [UIColor clearColor];
    zipcodemessagelabel.text = self.personalorder.ZipCode;
    [topviw addSubview:zipcodemessagelabel];
    [zipcodemessagelabel release];
    
    shippingnametiplabel.backgroundColor = [UIColor clearColor];
    shippingnametiplabel.text = @"配送方式：";
    [topviw addSubview:shippingnametiplabel];
    [shippingnametiplabel release];
    
    shippingnamemessagelabel.backgroundColor = [UIColor clearColor];
    shippingnamemessagelabel.text = self.personalorder.ShippingName;
    [topviw addSubview:shippingnamemessagelabel];
    [shippingnamemessagelabel release];
    
    paynametiplabel.backgroundColor = [UIColor clearColor];
    paynametiplabel.text = @"支付方式：";
    [topviw addSubview:paynametiplabel];
    [paynametiplabel release];
    
    paynamemessagelabel.backgroundColor = [UIColor clearColor];
    paynamemessagelabel.text = self.personalorder.PayName;
    [topviw addSubview:paynamemessagelabel];
    [paynamemessagelabel release];
    
    paystatustiplabel.backgroundColor = [UIColor clearColor];
    paystatustiplabel.text = @"支付状态：";
    [topviw addSubview:paystatustiplabel];
    [paystatustiplabel release];
    
    paystatusmessagelabel.backgroundColor = [UIColor clearColor];
    paystatusmessagelabel.text = self.personalorder.PayStatus;
    paystatusmessagelabel.textColor = [UIColor redColor];
    [topviw addSubview:paystatusmessagelabel];
    [paystatusmessagelabel release];
    
    orderstatustiplabel.backgroundColor = [UIColor clearColor];
    orderstatustiplabel.text = @"订单状态：";
    [topviw addSubview:orderstatustiplabel];
    [orderstatustiplabel release];
    
    orderstatusmessagelabel.backgroundColor = [UIColor clearColor];
    orderstatusmessagelabel.text = self.personalorder.OrderStatus;
    orderstatusmessagelabel.textColor = [UIColor redColor];
    [topviw addSubview:orderstatusmessagelabel];
    [orderstatusmessagelabel release];
    
    //如果是货到付款方式或者是已经支付的订单，就显示这个按钮并让用户可以查询到物流情况
    if ((self.personalorder.PayName!=nil && [self.personalorder.PayName isEqualToString:@"货到付款"]) || (self.personalorder.PayStatus!=nil &&[self.personalorder.PayStatus isEqualToString:@"已支付"])) {
        UIButton *orderprocessbtn = nil;
        if (self.isPad) {
            orderprocessbtn = [[UIButton alloc] initWithFrame:CGRectMake(400, paystatustiplabel.frameY, 200, 54)];
            [orderprocessbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
        }else{
            orderprocessbtn = [[UIButton alloc] initWithFrame:CGRectMake(180, paystatustiplabel.frameY, 100, 27)];
            [orderprocessbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        }
        UIImage *btnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"物流查询" ofType:@"png"]];
        [orderprocessbtn setBackgroundImage:btnimage forState:UIControlStateNormal];
        [orderprocessbtn setTitle:@"物流查询" forState:UIControlStateNormal];
        [orderprocessbtn addTarget:self action:@selector(orderProcessSelect:) forControlEvents:UIControlEventTouchUpInside];
        [topviw addSubview:orderprocessbtn];
        [orderprocessbtn release];
    }
    
    return [topviw autorelease];
}

- (UIView *)createOrderDetailBottomView
{
    UIView *bottomview = nil;
    UILabel *totalmoneytiplabel = nil;
    UILabel *totalmoneymessagelabel = nil;
    UILabel *shippingfeetiplabel = nil;
    UILabel *shippingfeemessagelabel = nil;
    UILabel *discounttiplabel= nil;
    UILabel *discountmessagelabel = nil;
    UILabel *orderamounttiplabel  = nil;
    UILabel *orderamountmessagelabel = nil;
    UILabel *moneyaccounttiplabel= nil;
    UILabel *moneyaccountmessagelabel = nil;
    if(self.isPad){
        bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 680, 170)];
        totalmoneytiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 14, 120, 28)];
        [totalmoneytiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        totalmoneymessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 14, 520, 28)];
        [totalmoneymessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        shippingfeetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 44, 120, 28)];
        [shippingfeetiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        shippingfeemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 44, 520, 28)];
        [shippingfeemessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        discounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 74, 120, 28)];
        [discounttiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        discountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 74, 520, 28)];
        [discountmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        orderamounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 104, 120, 28)];
        [orderamounttiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        orderamountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 104, 520, 28)];
        [orderamountmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
        moneyaccounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 134, 120, 28)];
        [moneyaccounttiplabel setFont:[UIFont boldSystemFontOfSize:24]];
        moneyaccountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 134, 520, 28)];
        [moneyaccountmessagelabel setFont:[UIFont boldSystemFontOfSize:24]];
    }else{
        bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 96)];
        totalmoneytiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 60, 14)];
        [totalmoneytiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        totalmoneymessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 190, 14)];
        [totalmoneymessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        shippingfeetiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 60, 14)];
        [shippingfeetiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        shippingfeemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 22, 190, 14)];
        [shippingfeemessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        discounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 37, 60, 14)];
        [discounttiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        discountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 37, 190, 14)];
        [discountmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        orderamounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 52, 60, 14)];
        [orderamounttiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        orderamountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 52, 190, 14)];
        [orderamountmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
        moneyaccounttiplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 67, 60, 14)];
        [moneyaccounttiplabel setFont:[UIFont boldSystemFontOfSize:12]];
        moneyaccountmessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 67, 190, 14)];
        [moneyaccountmessagelabel setFont:[UIFont boldSystemFontOfSize:12]];
    }
    
    totalmoneytiplabel.backgroundColor = [UIColor clearColor];
    totalmoneytiplabel.text = @"商品小计：";
    [bottomview addSubview:totalmoneytiplabel];
    [totalmoneytiplabel release];
    
    totalmoneymessagelabel.backgroundColor = [UIColor clearColor];
    totalmoneymessagelabel.text = [NSString stringWithFormat:@"￥%.2f",[self.personalorder.GoodsSubtotal floatValue]];
    totalmoneymessagelabel.textColor = [UIColor redColor];
    totalmoneymessagelabel.textAlignment = UITextAlignmentRight;
    [bottomview addSubview:totalmoneymessagelabel];
    [totalmoneymessagelabel release];
    
    shippingfeetiplabel.backgroundColor = [UIColor clearColor];
    shippingfeetiplabel.text = @"运费：";
    [bottomview addSubview:shippingfeetiplabel];
    [shippingfeetiplabel release];
    
    shippingfeemessagelabel.backgroundColor = [UIColor clearColor];
    shippingfeemessagelabel.text = [NSString stringWithFormat:@"￥%@",self.personalorder.ShippingFee];
    shippingfeemessagelabel.textColor = [UIColor redColor];
    shippingfeemessagelabel.textAlignment = UITextAlignmentRight;
    [bottomview addSubview:shippingfeemessagelabel];
    [shippingfeemessagelabel release];
    
    discounttiplabel.backgroundColor = [UIColor clearColor];
    discounttiplabel.text = @"优惠：";
    [bottomview addSubview:discounttiplabel];
    [discounttiplabel release];
    
    discountmessagelabel.backgroundColor = [UIColor clearColor];
    discountmessagelabel.text = [NSString stringWithFormat:@"￥%.2f",[self.personalorder.Discount floatValue]+[self.personalorder.TicketDiscount floatValue]];
    discountmessagelabel.textColor = [UIColor redColor];
    discountmessagelabel.textAlignment = UITextAlignmentRight;
    [bottomview addSubview:discountmessagelabel];
    [discountmessagelabel release];
    
    orderamounttiplabel.backgroundColor = [UIColor clearColor];
    orderamounttiplabel.text = @"总计：";
    [bottomview addSubview:orderamounttiplabel];
    [orderamounttiplabel release];
    
    orderamountmessagelabel.backgroundColor = [UIColor clearColor];
    orderamountmessagelabel.text = [NSString stringWithFormat:@"￥%.2f",[self.personalorder.OrderAmount floatValue]+[self.personalorder.ShippingFee floatValue]];
    self.countPrice = [self.personalorder.OrderAmount floatValue]+[self.personalorder.ShippingFee floatValue];
    orderamountmessagelabel.textColor = [UIColor redColor];
    orderamountmessagelabel.textAlignment = UITextAlignmentRight;
    [bottomview addSubview:orderamountmessagelabel];
    [orderamountmessagelabel release];
    
    moneyaccounttiplabel.backgroundColor = [UIColor clearColor];
    moneyaccounttiplabel.text = @"现金账户：";
    [bottomview addSubview:moneyaccounttiplabel];
    [moneyaccounttiplabel release];
    
    moneyaccountmessagelabel.backgroundColor = [UIColor clearColor];
    moneyaccountmessagelabel.text = [NSString stringWithFormat:@"￥%.2f",[self.personalorder.CashPrice floatValue]];
    moneyaccountmessagelabel.textColor = [UIColor redColor];
    moneyaccountmessagelabel.textAlignment = UITextAlignmentRight;
    [bottomview addSubview:moneyaccountmessagelabel];
    [moneyaccountmessagelabel release];
    
    return [bottomview autorelease];
}

#pragma mark 查询单个订单的详细货物

- (void)personalOrdersDetailSelect
{
 
    orderDetailsAction = [[SPOrderDetailsAction alloc] init];
    orderDetailsAction.m_delegate_orderDetials = self;
    [orderDetailsAction requestOrderDetialsListData];
    [self showHUD];
}
-(NSDictionary*)onRequestOrderDetialsAction{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.orderSN,@"OrderSN",nil];
}
-(void)onResponseOrderDetailsSuccess:(PersonalOrder *)order{
    [self hideHUD];
    self.personalorder = order;
    self.podarr = order.orderDetialsArray;
    totalmoney = 0.0f;
    for (OrderDetail *od in self.podarr) {
        totalmoney += od.Price.floatValue;
    }
  
    self.orderdetailtableview.hidden = NO;
    [self.orderdetailtableview reloadData];
}
-(void)onResponseOrderDetailsFail{
    [self hideHUD];
    self.orderdetailtableview.hidden = YES;
}
 
 

#pragma mark 物流查询
- (void)orderProcessSelect:(id)sender
{
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    [requestDic setValue:self.orderSN forKey:@"OrderSN"];
    NSString *memberid = [self getMemberId:@"memberdata"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETORDERPROCESSINFORMATION methodName:(NSString *)SP_METHOD_GETORDERPROCESSINFORMATION memberid:memberid];
    
    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:requestDic succ:@selector(orderProcessSelectSucc:) fail:@selector(orderProcessSelectFail:) responsedelegate:self];

    [rh release];
}

- (void)orderProcessSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSDictionary *resultdict = [request.responseString objectFromJSONString];
    NSDictionary *datadict = [resultdict objectForKey:@"Data"];
    NSArray *processarr = [datadict objectForKey:@"ProcessList"];
    OrderProcessDetail *opd = [[OrderProcessDetail alloc] init];
    opd.processarr = processarr;
    [self.navigationController pushViewController:opd animated:YES];
    [opd release];
}

- (void)orderProcessSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

- (void)pay:(id)sender
{
    
    NSString *paymoneystr = [NSString stringWithFormat:@"%.2f",[self.personalorder.OrderAmount floatValue]+[self.personalorder.ShippingFee floatValue]];
    
    [Go2PageUtility go2PayTypeChooseViewControllerFrom:self orderNo:self.personalorder.OrderSN orderAmount:paymoneystr];
}

- (void)cancelpay:(id)sender
{
    
}

-(NSString *)getAdress{
    sqlService *sql = [[sqlService alloc] init];
    NSString *province = strOrEmpty([sql getCityName:self.personalorder.ProvinceID]);
    NSString *city = strOrEmpty([sql getCityName:self.personalorder.CityID]);
    NSString *area = strOrEmpty([sql getCityName:self.personalorder.AreaID]);
    NSString *tempString = [NSString stringWithFormat:@"%@%@%@%@",province,city,area,self.personalorder.Address];
    [sql release];
    return tempString;
}

@end
