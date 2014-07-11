//
//  SPVersionUpdateAction.m
//  SuPu
//
//  Created by xingyong on 13-5-22.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPVersionUpdateAction.h"

@implementation SPVersionUpdateAction

@synthesize m_delegate_version;

- (void)dealloc {
    m_delegate_version=nil;
    [m_request_version setUserInfo:nil];
    [m_request_version clearDelegatesAndCancel];
    [m_request_version release];m_request_version=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestVersionUpdate{
    //    if (![super isInternetWorking]) {
    //        return;
    //    }
    if (m_request_version!=nil&&[m_request_version isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_version respondsToSelector:@selector(onRequestVersionUpdateAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_version onRequestVersionUpdateAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_UPDATE] forKey:SP_KEY_SIGN];
    
    m_request_version=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_UPDATE
                                                   postParams:l_dict
                                                       object:self
                                             onFinishedAction:@selector(onRequestListDataFinishResponse:)
                                               onFailedAction:@selector(onRequestListDataFailResponse:)];
    [m_request_version startAsynchronous];
    
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
    
    if ([(UIViewController*)m_delegate_version respondsToSelector:@selector(onResponseVersionUpdateSuccess:)]) {
        [m_delegate_version onResponseVersionUpdateSuccess:l_dict_response];
        
    }
    
    m_request_version=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_version respondsToSelector:@selector(onResponseVersionUpdateFail)]) {
        [m_delegate_version onResponseVersionUpdateFail];
    }
    m_request_version = nil;
}
@end
