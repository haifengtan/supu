//
//  PersonalOrder.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-20.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalOrder.h"

@implementation PersonalOrder

@synthesize OrderSN;
@synthesize RunningNumber;
@synthesize Consignee;
@synthesize ProvinceID;//
@synthesize CityID;//
@synthesize AreaID;//
@synthesize ZipCode;
@synthesize Address;
@synthesize Tel;
@synthesize Mobile;
@synthesize Discount;
@synthesize OrderAmount;
@synthesize OrderStatus;
@synthesize Email;
@synthesize PayName;
@synthesize PayStatus;
@synthesize ShippingName;
@synthesize ShippingFee;
@synthesize Account;
@synthesize MemberId;
@synthesize AddTime;
@synthesize CashPrice;
@synthesize TicketDiscount;
@synthesize orderDetialsArray;
@synthesize GoodsSubtotal;//商品小计


-(void)dealloc{
    self.orderDetialsArray = nil;
    [OrderSN release];
    [RunningNumber release];
    [Consignee release];
    [ProvinceID release];
    [CityID release];
    [AreaID release];
    [ZipCode release];
    [Address release];
    [Tel release];
    [Mobile release];
    [Discount release];
    [OrderAmount release];
    [OrderStatus release];
    [Email release];
    [PayName release];
    [PayStatus release];
    [ShippingName release];
    [ShippingFee release];
    [Account release];
    [MemberId release];
    [AddTime release];
    [CashPrice release];
    [TicketDiscount release];
    [GoodsSubtotal release];//商品小计
    [super dealloc];
}
@end
