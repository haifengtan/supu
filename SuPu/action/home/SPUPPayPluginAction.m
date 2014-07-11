//
//  SPUPPayPluginAction.m
//  SuPu
//
//  Created by xingyong on 13-5-10.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPUPPayPluginAction.h"

@implementation SPUPPayPluginAction

@synthesize m_delegate_payPlugin;

- (void)dealloc {
    m_delegate_payPlugin=nil;
    [m_request_payPlugin setUserInfo:nil];
    [m_request_payPlugin clearDelegatesAndCancel];
    [m_request_payPlugin release];m_request_payPlugin=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestPayPluginListData{
////////////////////////////
    if (m_request_payPlugin!=nil&&[m_request_payPlugin isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_payPlugin respondsToSelector:@selector(onRequestPayPluginAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_payPlugin onRequestPayPluginAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetUPPayData] forKey:SP_KEY_SIGN];
    
    m_request_payPlugin=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_GetUPPayData
                                                       postParams:l_dict
                                                           object:self
                                                 onFinishedAction:@selector(onRequestListDataFinishResponse:)
                                                   onFailedAction:@selector(onRequestListDataFailResponse:)];
    [m_request_payPlugin startAsynchronous];
    
}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFinishResponse:(ASIHTTPRequest*)request{
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        NSDictionary* l_dict_result=[l_dict_response objectForKey:@"Data"];
        
        NSString *tradeNumber = [l_dict_result objectForKey:@"TradeNumber"];
        NSString *serverMode = [l_dict_result objectForKey:@"ServerMode"];
         
        if ([(UIViewController*)m_delegate_payPlugin respondsToSelector:@selector(onResponsePayPluginSuccess:ServerMode:)]) {
            [m_delegate_payPlugin onResponsePayPluginSuccess:tradeNumber ServerMode:serverMode];
 
        }
    }else{
        
        if ([(UIViewController*)m_delegate_payPlugin respondsToSelector:@selector(onResponsePayPluginFail)]) {
            [m_delegate_payPlugin onResponsePayPluginFail];
        }
        
    }
    m_request_payPlugin=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_payPlugin respondsToSelector:@selector(onResponsePayPluginFail)]) {
        [m_delegate_payPlugin onResponsePayPluginFail];
    }
    m_request_payPlugin = nil;
}
@end