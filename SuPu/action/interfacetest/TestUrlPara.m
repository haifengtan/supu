//
//  TestUrlPara.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "TestUrlPara.h"

@implementation TestUrlPara
@synthesize url;
@synthesize methodname;
@synthesize memberid;
@synthesize requestmethod;
@synthesize havememberid;

- (id)init
{
    self.havememberid = TRUE;
    self.requestmethod = @"POST";
    return self;
}

- (void)dealloc
{
    [url release];
    [methodname release];
    [memberid release];
    [requestmethod release];
    [super dealloc];
}

@end
