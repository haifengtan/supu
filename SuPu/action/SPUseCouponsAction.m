//
//  SPUseCouponsAction.m
//  SuPu
//
//  Created by 持创 on 13-3-29.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPUseCouponsAction.h"

@implementation SPUseCouponsAction
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
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onRequestUseCouponsAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderList onRequestUseCouponsAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETTICKETINFO] forKey:SP_KEY_SIGN];
    
    m_request_orderList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETTICKETINFO
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
        SPCouponsObject *couponsObject = [[SPCouponsObject alloc] init];
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        couponsObject.m_ErrorCode = [l_dict_response objectForKey:@"ErrorCode"];
        couponsObject.m_Message = [l_dict_response objectForKey:@"Message"];
        
        couponsObject.m_TicketNo = [l_dict_data objectForKey:@"TicketNo"];
        couponsObject.m_ValidateResult = [l_dict_data objectForKey:@"ValidateResult"];
        
        NSDictionary *infoDict = [l_dict_data objectForKey:@"Ticket"];
        
        couponsObject.m_TicketName = [infoDict objectForKey:@"TicketName"];
        couponsObject.m_TicketDescribe = [infoDict objectForKey:@"TicketDescribe"];
        couponsObject.m_DiscountAmount = [infoDict objectForKey:@"DiscountAmount"];
        couponsObject.m_DiscountCumulative = [infoDict objectForKey:@"DiscountCumulative"];
        couponsObject.m_Discount = [infoDict objectForKey:@"Discount"];
       
        NSMutableArray *giftArray = [NSMutableArray array];
        
        NSArray *tempArray = [infoDict objectForKey:@"TicketsGifts"];
        
        for (NSDictionary *dict in tempArray) {
            gift *giftObject = [[gift alloc] init];
            giftObject.m_GiftCount = [dict objectForKey:@"GiftCount"];
            giftObject.m_PresentName = [dict objectForKey:@"PresentName"];
            giftObject.m_PresentSN = [dict objectForKey:@"PresentSN"];
            [giftArray addObject:giftObject];
            [giftObject release];
        }
        couponsObject.m_TicketsGifts = giftArray;
        
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseUseCouponsActionDataSuccess:)]) {
            [m_delegate_orderList onResponseUseCouponsActionDataSuccess:couponsObject];
        }
        
        [couponsObject release];
    }else{
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseUseCouponsActionDataFail)]) {
            [m_delegate_orderList onResponseUseCouponsActionDataFail];
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
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseUseCouponsActionDataFail)]) {
        [m_delegate_orderList onResponseUseCouponsActionDataFail];
    }
}
@end
