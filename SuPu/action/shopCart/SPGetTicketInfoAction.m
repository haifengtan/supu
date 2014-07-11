//
//  SPGetTicketInfoAction.m
//  SuPu
//
//  Created by cc on 12-12-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPGetTicketInfoAction.h"

@implementation SPGetTicketInfoAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    NSDictionary *dict = [request.responseString objectFromJSONString];
    return dict;
}

@end
