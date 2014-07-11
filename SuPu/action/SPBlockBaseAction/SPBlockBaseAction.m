//
//  SPBlockBaseAction.m
//  SuPu
//
//  Created by cc on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBlockBaseAction.h"
#import "SPAppDelegate.h"

@interface SPBlockBaseAction ()

@property (retain, nonatomic) ASIHTTPRequest *request;

@end

@implementation SPBlockBaseAction
@synthesize request = _request;
@synthesize successBlock;
@synthesize failureBlock;

- (void)dealloc
{
    successBlock = nil;
    failureBlock = nil;
    [_request setUserInfo:nil];
    [_request clearDelegatesAndCancel];
    [_request release];
    _request = nil;
    [super dealloc];
}

- (void)requestData:(const NSString *)url methodName:(const NSString *)methodname createParaBlock:(CreateRequestParameterBlock)parablock requestSuccessBlock:(RequestDataSuccBlock)succBlock requestFailureBlock:(RequestDataFailBlock)failBlock
{
    if (![self isInternetWorking]) {
        return;
    }
    self.successBlock = succBlock;
    self.failureBlock = failBlock;
    if (_request!=nil && [_request isFinished]) return;
    NSMutableDictionary *requestparamdict = [NSMutableDictionary dictionaryWithDictionary:parablock()];//通过block拿到参数
    if (requestparamdict == nil) {
        requestparamdict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    //进行签名
    [requestparamdict setObject:[SPActionUtility createSignWithMethod:(NSString *)methodname] forKey:(NSString *)SP_KEY_SIGN];
    //请求
    _request=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)url
                                        postParams:requestparamdict
                                            object:self
                                  onFinishedAction:@selector(requestFinish:)
                                    onFailedAction:@selector(requestFail:)];
    
    [_request startAsynchronous];
}

-(void)requestFinish:(ASIHTTPRequest*)request{
    NSString *responsestring=[request responseString];
    NSDictionary *responsedict=[responsestring objectFromJSONString];
    if ([SPActionUtility isRequestJSONSuccess:responsedict]) {//判断是否返回了内容
        if (self.successBlock) {//判断是否有处理成功信息的block
            id resultobject = [self requestDataFinish:request];//调用子类的数据解析方法
            self.successBlock(resultobject);//将子类的数据解析传给view层
        }
    }else{
        if (self.failureBlock) {
            self.failureBlock(request);
        }
        _request= nil;
    }
    _request= nil;
}

- (void)requestFail:(ASIHTTPRequest *)request{
    if (self.failureBlock) {
        self.failureBlock(request);
    }
    _request= nil;
}

-(id)requestDataFinish:(ASIHTTPRequest*)request{
    //这里只是为了不报警所以才写了这个方法，下面的action实现了这个类，将会跳过这个方法直接执行子类的方法
    [NSException raise:@"NORequestDataFinishMethodException" format:@"requestDataFinish Method not found,Please Override"];
    return nil;
}

-(BOOL)isInternetWorking{
    Reachability* curReach = [Reachability reachabilityWithHostName:SUPUHOST];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
 
        [SPStatusUtility showAlert:SP_DEFAULTTITLE
                           message:@"网络连接失败，请确保设备已经连网"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
        
        return NO;
    }else{
        return YES;
    }
}

@end
