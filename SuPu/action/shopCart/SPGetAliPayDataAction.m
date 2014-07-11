//
//  SPGetAliPayDataAction.m
//  SuPu
//
//  Created by xingyong on 13-3-4.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPGetAliPayDataAction.h"

@implementation SPGetAliPayDataAction
-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    
    NSDictionary *dict = [request.responseString objectFromJSONString];
    return dict;
}

@end
