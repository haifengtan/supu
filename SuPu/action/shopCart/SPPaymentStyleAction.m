//
//  SPPaymentStyleAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPPaymentStyleAction.h"

@implementation SPPaymentStyleAction
@synthesize m_delegate_payment;

- (void)dealloc {
    m_delegate_payment=nil;
    [m_request_payment setUserInfo:nil];
    [m_request_payment clearDelegatesAndCancel];
    [m_request_payment release];m_request_payment=nil;
    [super dealloc];
}

-(void)requestPayment{
////////////////////////////
    if (m_request_payment!=nil&&[m_request_payment isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_payment respondsToSelector:@selector(onRequestPaymentAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_payment onRequestPaymentAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetPaymentShipping] forKey:SP_KEY_SIGN];
    
    m_request_payment=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_GetPaymentShipping
                                                       postParams:l_dict
                                                           object:self
                                                 onFinishedAction:@selector(onRequestPaymentFinishResponse:)
                                                   onFailedAction:@selector(onRequestPaymentFailResponse:)];
    [m_request_payment startAsynchronous];
}

-(void)onRequestPaymentFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];

    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_result_dict=[l_dict_response objectForKey:@"Data"];
        SPStyleList *list=[[SPStyleList alloc] init];
        
        list.mPaymentArray=[l_result_dict objectForKey:@"PaymentList"];
 
        list.mShipArray=[l_result_dict objectForKey:@"ShippingList"];
        
        if ([(UIViewController*)m_delegate_payment respondsToSelector:@selector(onResponsePaymentSuccess:)]) {
            [m_delegate_payment onResponsePaymentSuccess:list];
        }
        [list release];
        
    }else{
        
        if ([(UIViewController*)m_delegate_payment respondsToSelector:@selector(onResponsePaymentFail)]) {
            [m_delegate_payment onResponsePaymentFail];
        }
        
    }
    m_request_payment=nil;
    
}
-(void)onRequestPaymentFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_payment respondsToSelector:@selector(onResponsePaymentFail)]) {
        [m_delegate_payment onResponsePaymentFail];
    }
    m_request_payment=nil;
    
}
@end

