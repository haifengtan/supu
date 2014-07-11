//
//  SPHomeData.m
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeData.h"

@implementation SPHomeData
@synthesize mOtherGoodsArray;
@synthesize mTopGoodsListArray;

- (void)dealloc {
    self.mTopGoodsListArray=nil;
    self.mOtherGoodsArray=nil;
    [super dealloc];
}
@end

@implementation SPHomeItemData
@synthesize mName;
@synthesize mGoodsArray;

- (void)dealloc {
    self.mGoodsArray=nil;
    self.mName=nil;
    [super dealloc];
}

@end

@implementation SPHomeGoodData
@synthesize mPrice;
@synthesize mGoodsSN;
@synthesize mImgFile;

- (void)dealloc {
    self.mImgFile=nil;
    self.mPrice=nil;
    self.mGoodsSN=nil;
    [super dealloc];
}
@end