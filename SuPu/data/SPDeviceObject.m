//
//  SPDeviceObject.m
//  SuPu
//
//  Created by 持创 on 13-3-28.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPDeviceObject.h"

@implementation SPDeviceObject
@synthesize deviceTime;
@synthesize deviceToken;

-(void)dealloc{
    [deviceToken release];
    [deviceTime release];
    [super dealloc];
}
@end
