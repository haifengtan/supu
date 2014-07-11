//
//  PersonalOrder.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-20.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalOrder : NSObject

@property (retain, nonatomic) NSString *OrderSN;
@property (retain, nonatomic) NSString *RunningNumber;
@property (retain, nonatomic) NSString *Consignee;
@property (retain, nonatomic) NSString *ProvinceID;
@property (retain, nonatomic) NSString *CityID;
@property (retain, nonatomic) NSString *AreaID;
@property (retain, nonatomic) NSString *ZipCode;
@property (retain, nonatomic) NSString *Address;
@property (retain, nonatomic) NSString *Tel;
@property (retain, nonatomic) NSString *Mobile;
@property (retain, nonatomic) NSString *Discount;
@property (retain, nonatomic) NSString *OrderAmount;
@property (retain, nonatomic) NSString *OrderStatus;
@property (retain, nonatomic) NSString *Email;
@property (retain, nonatomic) NSString *PayName;
@property (retain, nonatomic) NSString *PayStatus;
@property (retain, nonatomic) NSString *ShippingName;
@property (retain, nonatomic) NSString *ShippingFee;
@property (retain, nonatomic) NSString *Account;
@property (retain, nonatomic) NSString *MemberId;
@property (retain, nonatomic) NSString *AddTime;
@property (retain, nonatomic) NSString *CashPrice;
@property (retain, nonatomic) NSString *TicketDiscount;

@property (retain, nonatomic) NSString *GoodsSubtotal;

@property(retain,nonatomic) NSMutableArray *orderDetialsArray;
@end
