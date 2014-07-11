//
//  UserMessageObject.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "UserMessageObject.h"

@implementation UserMessageObject
@synthesize MessageContent;
@synthesize ReleaseTime;
@synthesize RID;
@synthesize MID;
@synthesize IsSee;
@synthesize ReleaseDate;

- (void)dealloc
{
    [MessageContent release];
    [ReleaseTime release];
    [RID release];
    [MID release];
    [IsSee release];
    [ReleaseDate release];
    [super dealloc];
}

@end
