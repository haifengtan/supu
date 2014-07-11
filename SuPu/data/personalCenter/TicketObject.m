//
//  TicketObject.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "TicketObject.h"

@implementation TicketObject
@synthesize TicketNo;
@synthesize TicketId;
@synthesize TicketName;
@synthesize BeginTime;
@synthesize EndTime;
@synthesize Status;
@synthesize IsUsed;

- (void)dealloc
{
    [TicketNo release];
    [TicketId release];
    [TicketName release];
    [BeginTime release];
    [EndTime release];
    [Status release];
    [IsUsed release];
    [super dealloc];
}

@end
