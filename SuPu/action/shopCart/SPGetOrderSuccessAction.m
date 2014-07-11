//
//  SPGetOrderSuccessAction.m
//  SuPu
//
//  Created by cc on 12-11-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPGetOrderSuccessAction.h"

@implementation SPGetOrderSuccessAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    NSMutableDictionary *resultdict = [request.responseString objectFromJSONString];
    return resultdict;
}

@end
