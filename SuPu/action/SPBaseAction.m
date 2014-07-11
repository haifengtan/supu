//
//  SPBaseAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPAppDelegate.h"

@implementation SPBaseAction

- (void)dealloc
{
    [baseactionrequest setUserInfo:nil];
    [baseactionrequest clearDelegatesAndCancel];
    [baseactionrequest release];
    baseactionrequest = nil;
    [super dealloc];
}

-(BOOL)isInternetWorking{
    Reachability* curReach = [Reachability reachabilityWithHostName:SUPUHOST];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status == NotReachable) {
 
        [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"网络连接失败，请确保设备已经连网" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        return NO;
    }else{
        return YES;
    }
}

@end
