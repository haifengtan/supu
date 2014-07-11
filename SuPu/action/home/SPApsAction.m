//
//  SPApsAction.m
//  SuPu
//
//  Created by cc on 13-1-8.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPApsAction.h"

@implementation SPApsAction

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
