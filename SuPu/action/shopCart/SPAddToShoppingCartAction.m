//
//  SPShoppingCartAction.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddToShoppingCartAction.h"

@implementation SPAddToShoppingCartAction
@synthesize m_delegate_shopCart;

- (void)dealloc {
    m_delegate_shopCart=nil;
    [m_request_shopCart setUserInfo:nil];
    [m_request_shopCart clearDelegatesAndCancel];
    [m_request_shopCart release];m_request_shopCart=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出添加到购物车请求
 */
-(void)requestAddToShoppingCartData{
////////////////////////////
    if (m_request_shopCart!=nil&&[m_request_shopCart isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onRequestAddToShoppingCart)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_shopCart onRequestAddToShoppingCart]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_MODIFYSHOPPINGCART] forKey:SP_KEY_SIGN];
    m_request_shopCart=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_MODIFYSHOPPINGCART 
                                                 postParams:l_dict 
                                                     object:self 
                                           onFinishedAction:@selector(onRequestAddToShoppingCartDataFinishResponse:) 
                                             onFailedAction:@selector(onRequestAddToShoppingCartDataFailResponse:)];
    
    [m_request_shopCart startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddToShoppingCartDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseAddToShoppingCartSuccess)]) {
            [m_delegate_shopCart onResponseAddToShoppingCartSuccess];
        }
    }else{
        if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseAddToShoppingCartFail)]) {
            [m_delegate_shopCart onResponseAddToShoppingCartFail];
        }
    }
    m_request_shopCart=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddToShoppingCartDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseShoppingCartDataFail)]) {
        [m_delegate_shopCart onResponseAddToShoppingCartFail];
    }
}
@end
