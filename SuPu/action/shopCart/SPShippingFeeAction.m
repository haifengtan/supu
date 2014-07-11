//
//  SPShippingFeeAction.m
//  SuPu
//
//  Created by cc on 12-11-15.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPShippingFeeAction.h"

@implementation SPShippingFeeAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    NSString *shippingfee = [[[request.responseString objectFromJSONString] objectForKey:@"Data"] objectForKey:@"ShippingFee"];
    return shippingfee;
}

@end
