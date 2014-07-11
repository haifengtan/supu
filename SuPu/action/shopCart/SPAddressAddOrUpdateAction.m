//
//  SPAddressAddOrUpdateAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-31.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressAddOrUpdateAction.h"

@implementation SPAddressAddOrUpdateAction
@synthesize m_delegate_addressAdd;

- (void)dealloc {
    m_delegate_addressAdd=nil;
    [m_request_addressAdd setUserInfo:nil];
    [m_request_addressAdd clearDelegatesAndCancel];
    [m_request_addressAdd release];m_request_addressAdd=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	请求添加地址数据
 */
-(void)requestAddressAdd{
////////////////////////////
    if (m_request_addressAdd!=nil&&[m_request_addressAdd isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_addressAdd respondsToSelector:@selector(onRequestAddressAddAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_addressAdd onRequestAddressAddAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_AddOrMoidfyConsignee] forKey:SP_KEY_SIGN];
    
    m_request_addressAdd=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_AddOrMoidfyConsignee
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestAddressAddFinishResponse:)
                                                  onFailedAction:@selector(onRequestAddressAddFailResponse:)];
    [m_request_addressAdd startAsynchronous];
}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressAddFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        if ([(UIViewController*)m_delegate_addressAdd respondsToSelector:@selector(onResponseAddressAddSuccess)]) {
            [m_delegate_addressAdd onResponseAddressAddSuccess];
        }
    }else{
        
        if ([(UIViewController*)m_delegate_addressAdd respondsToSelector:@selector(onResponseAddressAddFail)]) {
            [m_delegate_addressAdd onResponseAddressAddFail];
        }
        
    }
    m_request_addressAdd=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressAddFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_addressAdd respondsToSelector:@selector(onResponseAddressAddFail)]) {
        [m_delegate_addressAdd onResponseAddressAddFail];
    }
    m_request_addressAdd=nil;
}

@end
