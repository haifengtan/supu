//
//  SPBuildAddressAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBuildAddressAction.h"

@implementation SPBuildAddressAction
@synthesize m_delegate_buildAddress;

- (void)dealloc {
    m_delegate_buildAddress=nil;
    [m_request_buildAddress setUserInfo:nil];
    [m_request_buildAddress clearDelegatesAndCancel];
    [m_request_buildAddress release];m_request_buildAddress=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestBuildAddressData{
////////////////////////////
    if (m_request_buildAddress!=nil&&[m_request_buildAddress isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;;
    if (nil) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:nil];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETALLDISTRICT] forKey:SP_KEY_SIGN];
    m_request_buildAddress=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETALLDISTRICT
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestBuildAddressDataFinishResponse:)
                                                  onFailedAction:@selector(onRequestBuildAddressDataFailResponse::)];
    
    [m_request_buildAddress startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBuildAddressDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        NSArray *l_array_data=[l_dict_data objectForKey:@"DistrictList"];
        
        
        if ([(UIViewController*)m_delegate_buildAddress respondsToSelector:@selector(onResponseBuildAddressDataSuccess:)]) {
            [m_delegate_buildAddress onResponseBuildAddressDataSuccess:l_array_data];
        }else if ([(UIViewController*)m_delegate_buildAddress respondsToSelector:@selector(onResponseBuildAddressDataFail)]) {
            [m_delegate_buildAddress onResponseBuildAddressDataFail];
        }
    }
    m_request_buildAddress=nil;
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBuildAddressDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_buildAddress respondsToSelector:@selector(onResponseBuildAddressDataFail)]) {
        [m_delegate_buildAddress onResponseBuildAddressDataFail];
    }
}
@end
