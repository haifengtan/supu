//
//  SPBaseAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDataWorld.h"
#import "ASIHTTPRequest.h"
#import "SPActionUtility.h"
#import "Reachability.h"

@interface SPBaseAction : NSObject{
    @protected ASIHTTPRequest *baseactionrequest;
}

-(BOOL)isInternetWorking;

@end
