//
//  SPGetUPPayDataAction.m
//  SuPu
//
//  Created by xingyong on 13-3-5.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPGetUPPayDataAction.h"

@implementation SPGetUPPayDataAction
-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    
    NSDictionary *dict = [request.responseString objectFromJSONString];
    
    return dict;
}
@end
