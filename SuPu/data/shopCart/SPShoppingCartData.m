//
//  SPShoppingCartData.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPShoppingCartData.h"

@implementation SPShoppingCartData
@synthesize mDiscountAmount;
@synthesize mSumAmount;
@synthesize mCartListArray;
@synthesize mGiftListArray;

- (void)dealloc {
    self.mCartListArray=nil;
    self.mDiscountAmount=nil;
    self.mSumAmount=nil;
    self.mGiftListArray=nil;
    [super dealloc];
}

@end

@implementation SPShoppingCartItemData
@synthesize mCount;
@synthesize mGoodsSN;
@synthesize mShopPrice;
@synthesize mDiscountAmount;
@synthesize mIsNoStock;
@synthesize mIsGift;
@synthesize mImgFile;
@synthesize mGoodsName;

- (void)dealloc {
    self.mIsNoStock=nil;
    self.mDiscountAmount=nil;
    self.mCount=nil;
    self.mGoodsSN=nil;
    self.mShopPrice=nil;
    self.mImgFile=nil;
    self.mIsGift=nil;
    self.mGoodsName=nil;
    [super dealloc];
}

@end