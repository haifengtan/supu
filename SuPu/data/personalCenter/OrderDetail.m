//
//  OrderDetail.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OrderDetail.h"

@implementation OrderDetail
@synthesize Id;
@synthesize OrderSN;
@synthesize GoodsSN;
@synthesize GoodsName;
@synthesize Price;
@synthesize Discount;
@synthesize Count;
@synthesize IsGift;
@synthesize Integral;
@synthesize ImgFile;

- (void)dealloc
{
    [Id release];
    [OrderSN release];
    [GoodsSN release];
    [GoodsName release];
    [Price release];
    [Discount release];
    [Count release];
    [IsGift release];
    [Integral release];
    [ImgFile release];
    [super dealloc];
}

@end
