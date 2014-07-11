//
//  SPDiscountActivity.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPDiscountActivity.h"

@implementation SPDiscountActivity
@synthesize Id;
@synthesize Name;
@synthesize Description;
@synthesize ActivityImage;

- (void)dealloc
{
    [Id release];
    [Name release];
    [Description release];
    [ActivityImage release];
    [super dealloc];
}

@end
