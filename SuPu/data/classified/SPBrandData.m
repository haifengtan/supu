//
//  SPBrandData.m
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBrandData.h"

@implementation SPBrandData
@synthesize mSortOrder;
@synthesize mBrandID;
@synthesize mBrandName;

- (void)dealloc {
    self.mBrandID=nil;
    self.mBrandName=nil;
    self.mSortOrder=nil;
    [super dealloc];
}

@end
