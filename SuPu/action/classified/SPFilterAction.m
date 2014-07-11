//
//  SPFilterAction.m
//  SuPu
//
//  Created by xx on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPFilterAction.h"

@implementation SPFilterAction
@synthesize m_delegate_filter;

- (void)dealloc {
    m_delegate_filter=nil;
    [m_request_filter setUserInfo:nil];
    [m_request_filter clearDelegatesAndCancel];
    OUOSafeRelease(m_request_filter);
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出筛选数据请求
 */
-(void)requestFilterData{
////////////////////////////
    if (m_request_filter!=nil&&[m_request_filter isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_filter respondsToSelector:@selector(onResponseFilterDataAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_filter onResponseFilterDataAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetScreeningInfo] forKey:SP_KEY_SIGN];
    m_request_filter=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetScreeningInfo 
                                                       postParams:l_dict 
                                                           object:self 
                                                 onFinishedAction:@selector(onRequestFilterDataFinishResponse:) 
                                                   onFailedAction:@selector(onRequestFilterDataFailResponse:)];
    NSDictionary *l_userInfo=m_request_filter.userInfo;
    NSMutableDictionary *l_dict_userInfo=[NSMutableDictionary dictionaryWithDictionary:l_userInfo];
    [l_dict_userInfo setObject:(NSString*)SP_METHOD_GetScreeningInfo forKey:@"method"];
    [m_request_filter setUserInfo:l_dict_userInfo];
    [m_request_filter startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFilterDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_method=[request.userInfo objectForKey:@"method"];
    if (!l_str_method||![l_str_method isEqualToString:(NSString*)SP_METHOD_GetScreeningInfo]) {
        return;
    }
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        if ([(UIViewController*)m_delegate_filter respondsToSelector:@selector(onResponseFilterDataSuccess:)]) {
            [m_delegate_filter onResponseFilterDataSuccess:l_dict_data];
        }
    }else{
        if ([(UIViewController*)m_delegate_filter respondsToSelector:@selector(onResponseFilterDataFail)]) {
            [m_delegate_filter onResponseFilterDataFail];
        }
    }
    m_request_filter=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFilterDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_filter respondsToSelector:@selector(onResponseFilterDataFail)]) {
        [m_delegate_filter onResponseFilterDataFail];
    }
    m_request_filter=nil;
}
@end
