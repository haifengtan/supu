//
//  SPProductListData.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductListData.h"

@implementation SPProductListData
@synthesize mpageInfo;
@synthesize mGoodsListArray;

- (void)dealloc {
    self.mGoodsListArray=nil;
    self.mpageInfo=nil;
    [super dealloc];
}
@end

@implementation SPProductListGoodData
@synthesize mAddTime;
@synthesize mBrandID;
@synthesize mGoodsSN;
@synthesize mImgFile;
@synthesize mIntegral;
@synthesize mGoodsName;
@synthesize mGoodsSort;
@synthesize mIsNoStock;
@synthesize mShopPrice;
@synthesize mCategoryID;
@synthesize mGoodsScore;
@synthesize mGoodsSlogan;
@synthesize mMarketPrice;
@synthesize mCommentCount;

- (void)dealloc {
    self.mAddTime=nil;
    self.mBrandID=nil;
    self.mCategoryID=nil;
    self.mCommentCount=nil;
    self.mGoodsName=nil;
    self.mGoodsScore=nil;
    self.mGoodsSlogan=nil;
    self.mGoodsSN=nil;
    self.mGoodsSort=nil;
    self.mImgFile=nil;
    [super dealloc];
}

@end
