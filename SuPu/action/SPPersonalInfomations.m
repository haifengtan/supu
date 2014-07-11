//
//  SPPersonalInfomations.m
//  SuPu
//
//  Created by 持创 on 13-3-25.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPPersonalInfomations.h"

@implementation SPPersonalInfomations
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
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onRequestOrderMemberAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderList onRequestOrderMemberAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETMEMBERINFO] forKey:SP_KEY_SIGN];
    
    m_request_orderList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETMEMBERINFO
                                                   postParams:l_dict
                                                       object:self
                                             onFinishedAction:@selector(onRequestPersonalInfomationDataFinishResponse:)
                                               onFailedAction:@selector(onRequestPersonalInfomationDataFailResponse:)];
    
    [m_request_orderList startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPersonalInfomationDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        
            NSDictionary *infoDict = [l_dict_data objectForKey:@"Member"];
            
            
            Member *memberInfo = [[Member allObjects] objectAtIndex:0];
            
            memberInfo.mmemberId = [infoDict objectForKey:@"MemberId"];
            memberInfo.mlevel = [infoDict objectForKey:@"Level"];
            memberInfo.mprice = [infoDict objectForKey:@"Price"];
            memberInfo.mimageUrl = [infoDict objectForKey:@"ImageUrl"];
            memberInfo.mscores = [infoDict objectForKey:@"Scores"];
            memberInfo.maccount = [infoDict objectForKey:@"Account"];
            
            [SPDataInterface setCommonParam:SP_KEY_MEMBERID value:memberInfo.mmemberId];
            
            [memberInfo save];
//            [memberInfo release];
        
        
        
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderMemberDataSuccess:)]) {
            [m_delegate_orderList onResponseOrderMemberDataSuccess:nil];
        }
        //        [l_data_shopCart release];
    }else{
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderMemberDataFail)]) {
            [m_delegate_orderList onResponseOrderMemberDataFail];
        }
    }
    m_request_orderList=nil;
    
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPersonalInfomationDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderListDataFail)]) {
        [m_delegate_orderList onResponseOrderMemberDataFail];
    }
}

@end
