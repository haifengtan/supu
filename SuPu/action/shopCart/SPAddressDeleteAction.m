//
//  SPAddressDeleteAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressDeleteAction.h"

@implementation SPAddressDeleteAction@synthesize m_delegate_addressDele;

- (void)dealloc {
    m_delegate_addressDele=nil;
    [m_request_addressDele setUserInfo:nil];
    [m_request_addressDele clearDelegatesAndCancel];
    [m_request_addressDele release];m_request_addressDele=nil;
    [super dealloc];
}


/**
 *	@brief	发出请求
 *
 *	请求删除地址数据
 */
-(void)requestAddressDele{
////////////////////////////
    if (m_request_addressDele!=nil&&[m_request_addressDele isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_addressDele respondsToSelector:@selector(onRequestAddressDeleAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_addressDele onRequestAddressDeleAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_DeleteConsignee] forKey:SP_KEY_SIGN];
    
    m_request_addressDele=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_DeleteConsignee
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestAddressDeleFinishResponse:)
                                                  onFailedAction:@selector(onRequestAddressDeleFailResponse:)];
    [m_request_addressDele startAsynchronous];
 
}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressDeleFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        if ([(UIViewController*)m_delegate_addressDele respondsToSelector:@selector(onResponseAddressDeleSuccess)]) {
            [m_delegate_addressDele onResponseAddressDeleSuccess];
        }
    }else{
        
        if ([(UIViewController*)m_delegate_addressDele respondsToSelector:@selector(onResponseAddressDeleFail)]) {
            [m_delegate_addressDele onResponseAddressDeleFail];
        }
        
    }
    m_request_addressDele=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressDeleFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_addressDele respondsToSelector:@selector(onResponseAddressDeleFail)]) {
        [m_delegate_addressDele onResponseAddressDeleFail];
    }
    m_request_addressDele=nil;
}
@end
