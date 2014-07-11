//
//  SPResultData.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPResultData.h"

@implementation SPResultData
@synthesize mErrorCode;
@synthesize mMessage;

- (void)dealloc {
    self.mErrorCode=nil;
    self.mMessage=nil;
    [super dealloc];
}
@end
