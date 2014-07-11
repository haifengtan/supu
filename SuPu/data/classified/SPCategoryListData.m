//
//  SPCategoryListData.m
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPCategoryListData.h"

@implementation SPCategoryListData
@synthesize mImg;
@synthesize mParentID;
@synthesize mSortOrder;
@synthesize mCategoryID;
@synthesize mCategoryName;
@synthesize mIsLaef;

- (void)dealloc {
    self.mSortOrder=nil;
    self.mParentID=nil;
    self.mImg=nil;
    self.mCategoryName=nil;
    self.mCategoryID=nil;
    self.mIsLaef=nil;
    [super dealloc];
}

@end
