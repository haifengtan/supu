//
//  TicketDetail.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketDetail : NSObject

@property (retain, nonatomic) NSString *TicketNo;
@property (retain, nonatomic) NSString *BindingTime;
@property (retain, nonatomic) NSString *TicketId;
@property (retain, nonatomic) NSString *TicketName;
@property (retain, nonatomic) NSString *TicketDescribe;
@property (retain, nonatomic) NSString *BeginTime;
@property (retain, nonatomic) NSString *EndTime;
@property (retain, nonatomic) NSString *Discount;
@property (retain, nonatomic) NSString *DiscountAmount;
@property (retain, nonatomic) NSString *DiscountCumulative;
@property (retain, nonatomic) NSString *GrantAmount;
@property (retain, nonatomic) NSString *Status;
@property (retain, nonatomic) NSString *IsUsed;
@property (retain, nonatomic) NSString *BeginTimeDate;
@property (retain, nonatomic) NSString *EndTimeDate;

@end
