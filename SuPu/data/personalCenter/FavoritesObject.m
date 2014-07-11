//
//  FavoritesObject.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "FavoritesObject.h"

@implementation FavoritesObject
@synthesize GoodsSN;
@synthesize PriceSnapshot;
@synthesize AddTime;

- (void)dealloc
{
    [GoodsSN release];
    [PriceSnapshot release];
    [AddTime release];
    [super dealloc];
}

@end
