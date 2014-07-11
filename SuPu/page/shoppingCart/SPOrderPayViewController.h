//
//  SPOrderPayViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#import "PersonalOrder.h"

@interface SPOrderPayViewController : SPBaseTableViewController
    

@property (retain, nonatomic) IBOutlet UIView *topview;
@property (retain, nonatomic) IBOutlet UIView *bottomview;
@property (retain, nonatomic) PersonalOrder *po;
@property float ticketdiscount;
@property (retain, nonatomic) IBOutlet UILabel *topordersnlabel;//上面的section订单号
@property (retain, nonatomic) IBOutlet UILabel *toppaymoney;//支付总金额
@property (retain, nonatomic) IBOutlet UIWebView *bottomwebview;//底部的webview

@end
