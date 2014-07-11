//
//  SPBalanceAccountViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPShoppingCartData.h"
#import "SPSetDefaultAddressAction.h"
#import "SPAddressManagerViewController.h"
#import "SPTableViewDelegate.h"
#import "SPSubmitOrderAction.h"
#import "SPAddressListData.h"

@interface SPBalanceAccountViewController : SPBaseViewController<SPSetDefaultAddressActionDelegate,SPAddressManagerDelegate,SPTableViewDelegate,SPSubmitOrderActionDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate>{
    SPSetDefaultAddressAction *defaultAddressAction;
    NSMutableArray *stitleArray;

    SPSubmitOrderAction *submitAction;
    SPAddressListData *requsetData;
}

@property (nonatomic,retain)IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *spriceView;
@property (nonatomic,retain)SPShoppingCartData *shopCartData;
@property (retain, nonatomic) IBOutlet UIView *saddressedView;
//需要支付的信息
@property (retain, nonatomic) IBOutlet UILabel *totalPayLabel;
@property (retain, nonatomic) IBOutlet UILabel *productTotalLabel;
@property (retain, nonatomic) IBOutlet UILabel *discountAmountLabel;
@property (retain, nonatomic) IBOutlet UILabel *feeLabel;
@property (retain, nonatomic) IBOutlet UILabel *moneyAccountLabel;

//收货信息
@property (retain, nonatomic) IBOutlet UILabel *consigneeLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneLabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *zipCodeLabel;

@property (retain, nonatomic) UITextField *discountcardtext;
@property (retain, nonatomic) UILabel *invoicetext;
@property (nonatomic,retain) NSString *paymentID;
@property (nonatomic,retain) NSString *shippingID;

@property (retain, nonatomic) NSString *ticketno;//从优惠劵页面传递过来的优惠劵编号
@property (retain, nonatomic) SPAddressListData *addressobject;//用来确认运费的地址对象
@property (retain, nonatomic) NSString *remark;

@property (retain, nonatomic) NSString *lastaccount;//上一次登陆的账号

@end
