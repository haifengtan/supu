//
//  SPGoodsConsult.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPGoodsConsult.h"

@implementation SPGoodsConsult
@synthesize ConsultId;
@synthesize ConsultContent;
@synthesize ConsultTime;
@synthesize ReplyId;
@synthesize ReplyContent;
@synthesize ReplyTime;
@synthesize Account;
@synthesize LevelCode;
@synthesize ImageUrl;

- (void)dealloc
{
    [ConsultId release];
    [ConsultContent release];
    [ConsultTime release];
    [ReplyId release];
    [ReplyContent release];
    [ReplyTime release];
    [Account release];
    [LevelCode release];
    [ImageUrl release];
    [super dealloc];
}

@end
