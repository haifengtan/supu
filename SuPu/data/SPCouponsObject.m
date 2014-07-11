//
//  SPCouponsObject.m
//  SuPu
//
//  Created by 持创 on 13-3-29.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPCouponsObject.h"

@implementation gift
@synthesize m_GiftCount;
@synthesize m_PresentName;
@synthesize m_PresentSN;

-(void)dealloc{
    [m_PresentSN release];
    [m_PresentName release];
    [m_GiftCount release];
    [super dealloc];
}
@end

@implementation SPCouponsObject
@synthesize m_ErrorCode;
@synthesize m_Message;
@synthesize m_TicketNo;
@synthesize m_ValidateResult;
@synthesize m_TicketName;
@synthesize m_TicketDescribe;
@synthesize m_DiscountAmount;
@synthesize m_Discount;
@synthesize m_TicketsGifts;
-(void)dealloc{
    [m_ErrorCode release];
    [m_Message release];
    [m_TicketNo release];
    [m_ValidateResult release];
    [m_TicketName release];
    [m_TicketDescribe release];
    [m_DiscountAmount release];
    [m_Discount release];
    [m_TicketsGifts release];
    [super dealloc];
}
@end
