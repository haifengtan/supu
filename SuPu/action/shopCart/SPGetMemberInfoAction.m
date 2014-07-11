//
//  SPGetMemberInfoAction.m
//  SuPu
//
//  Created by cc on 12-12-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPGetMemberInfoAction.h"
#import "Member.h"

@implementation SPGetMemberInfoAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    Member *member = [JsonUtil fromSimpleJsonStrToSimpleObject1:request.responseString className1:[Member class] keyPath1:@"Data.Member" keyPathDeep1:nil];
     
    return member;
}

@end
