//
//  SPDeviceAction.m
//  SuPu
//
//  Created by 持创 on 13-3-28.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPDeviceAction.h"

@implementation SPDeviceAction
@synthesize m_delegate_orderList;

- (void)dealloc {
    m_delegate_orderList=nil;
    [m_request_orderList setUserInfo:nil];
    [m_request_orderList clearDelegatesAndCancel];
    [m_request_orderList release];m_request_orderList=nil;
    [super dealloc];
}

-(void)requestPersonalInfomationData{
////////////////////////////
    if (m_request_orderList!=nil&&[m_request_orderList isFinished]) {
        return;
    }

    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onRequestDeviceAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderList onRequestDeviceAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString *)SP_METHOD_iPhonePush] forKey:SP_KEY_SIGN];
    
    m_request_orderList=[KDATAWORLD.httpEngineSP buildRequest:(NSString *)SP_URL_iPhonePush
                                                   postParams:l_dict
                                                       object:self
                                             onFinishedAction:@selector(onRequestDeviceDataFinishResponse:)
                                               onFailedAction:@selector(onRequestDeviceDataFailResponse:)];
    
    [m_request_orderList startAsynchronous];
}

-(void)onRequestDeviceDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPDeviceObject *device = [[SPDeviceObject alloc] init];
        device.deviceToken = [l_dict_data objectForKey:@"DeviceToken"];
        device.deviceTime = [l_dict_data objectForKey:@"Time"];
        
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseDeviceDataSuccess:)]) {
            [m_delegate_orderList onResponseDeviceDataSuccess:device];
        }
        [device release];
    }else{
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseDeviceDataFail)]) {
            [m_delegate_orderList onResponseDeviceDataFail];
        }
    }
    m_request_orderList=nil;
    
}

-(void)onRequestDeviceDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseDeviceDataFail)]) {
        [m_delegate_orderList onResponseDeviceDataFail];
    }
}

@end
