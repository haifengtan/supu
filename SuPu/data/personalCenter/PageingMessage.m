//
//  PageingMessage.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PageingMessage.h"

@implementation PageingMessage
@synthesize PageIndex;
@synthesize PageSize;
@synthesize RecordCount;

- (void)dealloc
{
    [PageIndex release];
    [PageSize release];
    [RecordCount release];
    [super dealloc];
}

@end
