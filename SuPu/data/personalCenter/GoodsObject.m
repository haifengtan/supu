//
//  GoodsObject.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "GoodsObject.h"

@implementation GoodsObject 
@synthesize GoodsSN;
@synthesize GoodsName;
@synthesize GoodsSlogan;
@synthesize CommentCount;
@synthesize CategoryID;
@synthesize BrandID;
@synthesize GoodsScore;
@synthesize GoodsSort;
@synthesize Integral;
@synthesize ImgFile;
@synthesize MarketPrice;
@synthesize ShopPrice;
@synthesize IsNoStock;
@synthesize AddTime;

- (void)dealloc
{
    [GoodsSN release];
    [GoodsName release];
    [GoodsSlogan release];
    [CommentCount release];
    [CategoryID release];
    [BrandID release];
    [GoodsScore release];
    [GoodsSort release];
    [Integral release];
    [ImgFile release];
    [MarketPrice release];
    [ShopPrice release];
    [IsNoStock release];
    [AddTime release];
    [super dealloc];
}

@end
