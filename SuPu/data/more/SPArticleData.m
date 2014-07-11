//
//  SPArticleData.m
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleData.h"

@implementation SPArticleData
@synthesize mArticle;
@synthesize mArticleGoodsArray;

- (void)dealloc {
    self.mArticleGoodsArray=nil;
    self.mArticle=nil;
    [super dealloc];
}

@end

@implementation SPArticleItemData
@synthesize mID;
@synthesize mTitle;
@synthesize mCategoryID;
@synthesize mContent;
@synthesize mModifyTime;

- (void)dealloc {
    self.mModifyTime=nil;
    self.mCategoryID=nil;
    self.mContent=nil;
    self.mTitle=nil;
    self.mID=nil;
    [super dealloc];
}

@end

@implementation SPArticleGoodData
@synthesize mPrice;
@synthesize mGoodsSN;
@synthesize mImgFile;
@synthesize mGoodsName;
@synthesize mMarketPrice;
@synthesize mGooodsIntro;

- (void)dealloc {
    self.mImgFile=nil;
    self.mGoodsSN=nil;
    self.mGoodsName=nil;
    self.mGooodsIntro = nil;
    self.mMarketPrice=nil;
    self.mPrice=nil;
    [super dealloc];
}

@end
