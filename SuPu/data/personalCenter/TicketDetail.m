//
//  TicketDetail.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "TicketDetail.h"

@implementation TicketDetail
@synthesize TicketNo;
@synthesize BindingTime;
@synthesize TicketId;
@synthesize TicketName;
@synthesize TicketDescribe;
@synthesize BeginTime;
@synthesize EndTime;
@synthesize Discount;
@synthesize DiscountAmount;
@synthesize DiscountCumulative;
@synthesize GrantAmount;
@synthesize Status;
@synthesize IsUsed;
@synthesize BeginTimeDate;
@synthesize EndTimeDate;

- (void)dealloc
{
    [TicketNo release];
    [BindingTime release];
    [TicketId release];
    [TicketName release];
    [TicketDescribe release];
    [BeginTime release];
    [EndTime release];
    [Discount release];
    [DiscountAmount release];
    [DiscountCumulative release];
    [GrantAmount release];
    [Status release];
    [IsUsed release];
    [BeginTimeDate release];
    [EndTimeDate release];
    [super dealloc];
}

@end
