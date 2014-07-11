//
//  SPProductDetailData.m
//  SuPu
//
//  Created by xx on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductDetailData.h"

@implementation SPProductDetailData
@synthesize mBrandID;
@synthesize mGoodsSN;
@synthesize mGoodsName;
@synthesize mShopPrice;
@synthesize mCategoryID;
@synthesize mGoodsScore;
@synthesize mGoodsImages;
@synthesize mGoodsSlogan;
@synthesize mMarketPrice;
@synthesize mCommentCount;
@synthesize mConsultCount;
@synthesize mShareText;
@synthesize mIsNoStock;

- (void)dealloc {
    self.mConsultCount=nil;
    self.mBrandID=nil;
    self.mCategoryID=nil;
    self.mCommentCount=nil;
    self.mGoodsImages=nil;
    self.mGoodsName=nil;
    self.mGoodsScore=nil;
    self.mGoodsSlogan=nil;
    self.mGoodsSN=nil;
    self.mMarketPrice=nil;
    self.mShareText=nil;
    self.mIsNoStock=nil;
    [super dealloc];
}

@end

@implementation SPProductGoodsImage
@synthesize mGoodsSN;
@synthesize mName;
@synthesize mImgFile;
@synthesize mSmallImgFile;

- (void)dealloc {

    self.mSmallImgFile = nil;
    self.mImgFile = nil;
    self.mGoodsSN=nil;
    self.mName=nil;
    [super dealloc];
}
@end
