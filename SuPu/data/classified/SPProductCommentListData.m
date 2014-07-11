//
//  SPProductCommentListData.m
//  SuPu
//
//  Created by 杨福军 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductCommentListData.h"

@implementation SPProductCommentListData
@synthesize comments = comments_;
@synthesize pageInfo = pageInfo_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(pageInfo_);
    [super dealloc];
}

@end

@implementation SPProductCommentData
@synthesize goodsScore = goodsScore_;
@synthesize identifier = identifier_;
@synthesize content = content_;
@synthesize member = member_;
@synthesize time = time_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(goodsScore_);
    OUOSafeRelease(identifier_);
    OUOSafeRelease(member_);
    OUOSafeRelease(content_);
    OUOSafeRelease(time_);
    [super dealloc];
}

@end