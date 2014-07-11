//
//  SPSubmitOrderAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPSubmitOrderAction.h"
#import "JsonUtil.h"

@implementation SPSubmitOrderAction

@synthesize m_delegate_submitOrder;

- (void)dealloc {
    m_delegate_submitOrder=nil;
    [m_request_submitOrder setUserInfo:nil];
    [m_request_submitOrder clearDelegatesAndCancel];
    [m_request_submitOrder release];m_request_submitOrder=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestSubmitOrderData{
////////////////////////////
    if (m_request_submitOrder!=nil&&[m_request_submitOrder isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_submitOrder respondsToSelector:@selector(onRequestSubmitOrderAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_submitOrder onRequestSubmitOrderAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_SUBMITORDER] forKey:SP_KEY_SIGN];
    
    m_request_submitOrder=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_SUBMITORDER
                                                        postParams:l_dict
                                                            object:self
                                                  onFinishedAction:@selector(onRequestSubmitOrderDataFinishResponse:)
                                                 onFailedAction:@selector(onRequestSubmitOrderDataFailResponse:)];
    
    [m_request_submitOrder startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestSubmitOrderDataFinishResponse:(ASIHTTPRequest *)request{
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        PersonalOrder *po = [JsonUtil fromSimpleJsonStrToSimpleObject:l_str_response className:[PersonalOrder class] keyPath:@"Data.Order" keyPathDeep:nil];
        
        if ([(UIViewController*)m_delegate_submitOrder respondsToSelector:@selector(onResponseSubmitOrderDataSuccess:)]) {
            [m_delegate_submitOrder onResponseSubmitOrderDataSuccess:po];
        }
    }else{
        
        if ([(UIViewController*)m_delegate_submitOrder respondsToSelector:@selector(onResponseSubmitOrderDataFail)]) {
            [m_delegate_submitOrder onResponseSubmitOrderDataFail];
        }
    }
    m_request_submitOrder=nil;
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestSubmitOrderDataFailResponse:(ASIHTTPRequest *)request{
    
    if ([(UIViewController*)m_delegate_submitOrder respondsToSelector:@selector(onResponseSubmitOrderDataFail)]) {
        [m_delegate_submitOrder onResponseSubmitOrderDataFail];
    }
}
@end

