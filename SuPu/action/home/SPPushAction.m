//
//  SPPushAction.m
//  SuPu
//
//  Created by xingyong on 13-3-5.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPPushAction.h"

@implementation SPPushAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    NSDictionary *dict = [[request responseString] objectFromJSONString];
    
    return dict;
    
    //    if ([[dict valueForKey:@"ErrorCode"] isEqualToString:@"0"]) {
    //        NSString *token = [[dict valueForKey:@"Data"] valueForKey:@"DeviceToken"];
    //        return token;
    //    }else{
    //        return nil;
    //    }
    
}
@end
 
