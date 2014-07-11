//
//  SPArticleListData.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleListData.h"

@implementation SPArticleListData

@synthesize mPageInfo;
@synthesize mArticleListArray;

- (void)dealloc {
    self.mArticleListArray=nil;
    self.mPageInfo=nil;
    [super dealloc];
}
@end
