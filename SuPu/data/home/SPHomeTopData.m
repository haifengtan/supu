//
//  SPHomeTopData.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeTopData.h"

@implementation SPHomeTopData
@synthesize mPicUrl;
@synthesize mPicSort;
@synthesize mLinkData;
@synthesize mLinkType;

- (void)dealloc {
    self.mLinkType=nil;
    self.mPicSort=nil;
    self.mPicUrl=nil;
    self.mLinkData=nil;
    [super dealloc];
}

@end
