//
//  SPPageInfoData.m
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPPageInfoData.h"

@implementation SPPageInfoData
@synthesize mPageSize;
@synthesize mPageIndex;
@synthesize mRecordCount;
@synthesize mPageArray;
- (void)dealloc {
    self.mRecordCount=nil;
    self.mPageSize=nil;
    self.mRecordCount=nil;
    self.mPageArray = nil;
    [super dealloc];
}

@end
