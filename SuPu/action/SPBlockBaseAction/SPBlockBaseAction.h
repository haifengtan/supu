//
//  SPBlockBaseAction.h
//  SuPu
//
//  Created by cc on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDataWorld.h"
#import "ASIHTTPRequest.h"
#import "SPActionUtility.h"
#import "Reachability.h"

typedef NSDictionary * (^CreateRequestParameterBlock)(void);//获取request的请求参数的block
typedef void (^RequestDataSuccBlock)(id);//请求成功之后的block
typedef void (^RequestDataFailBlock)(ASIHTTPRequest *);//请求失败之后的block

@interface SPBlockBaseAction : NSObject

@property (copy, nonatomic) RequestDataSuccBlock successBlock;
@property (copy, nonatomic) RequestDataFailBlock failureBlock;

- (void)requestData:(const NSString *)url methodName:(const NSString *)methodname
    createParaBlock:(CreateRequestParameterBlock)parablock
    requestSuccessBlock:(RequestDataSuccBlock)succBlock
    requestFailureBlock:(RequestDataFailBlock)failBlock;

-(id)requestDataFinish:(ASIHTTPRequest*)request;

-(BOOL)isInternetWorking;

@end
