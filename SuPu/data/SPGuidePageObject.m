//
//  SPGuidePageObject.m
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPGuidePageObject.h"
@implementation SPPage
@synthesize m_pageArray;

-(void)dealloc{
    [m_pageArray release];
    [super dealloc];
}
@end

@implementation SPGuidePageObject
@synthesize m_BeginTime;
@synthesize m_EndTime;
@synthesize m_PicUrl;

-(void)dealloc{
    [m_PicUrl release];
    [m_EndTime release];
    [m_BeginTime release];
    [super dealloc];
}
@end
