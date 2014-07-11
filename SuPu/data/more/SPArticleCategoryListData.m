//
//  SPArticleCategoryListData.m
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleCategoryListData.h"

@implementation SPArticleCategoryListData
@synthesize mID;
@synthesize mSort;
@synthesize mPicUrl;
@synthesize mCategoryName;

- (void)dealloc {
    self.mCategoryName=nil;
    self.mID=nil;
    self.mPicUrl=nil;
    self.mSort=nil;
    [super dealloc];
}

@end
