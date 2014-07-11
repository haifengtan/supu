//
//  SPOrderListAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPOrderListAction.h"

@implementation SPOrderListAction
@synthesize m_delegate_orderList;

- (void)dealloc {
    m_delegate_orderList=nil;
    [m_request_orderList setUserInfo:nil];
    [m_request_orderList clearDelegatesAndCancel];
    [m_request_orderList release];m_request_orderList=nil;
    [super dealloc];
}

-(void)requestOrderListData{
////////////////////////////
    if (m_request_orderList!=nil&&[m_request_orderList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onRequestUpdateShopCartAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderList onRequestOrderListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETORDERLIST] forKey:SP_KEY_SIGN];
    
    m_request_orderList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETORDERLIST
                                                        postParams:l_dict
                                                            object:self
                                                  onFinishedAction:@selector(onRequestOrderListDataFinishResponse:)
                                                    onFailedAction:@selector(onRequestOrderListDataFailResponse:)];
    
    [m_request_orderList startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestOrderListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
//        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPOrderData *l_data_shopCart=[[SPOrderData alloc] init];
//        l_data_shopCart.mSumAmount=[l_dict_data objectForKey:@"SumAmount"];
//        l_data_shopCart.mDiscountAmount=[l_dict_data objectForKey:@"DiscountAmount"];
//        
//        NSMutableArray *l_arr_cartList=[NSMutableArray arrayWithCapacity:0];
//        for (NSDictionary *l_dict_cartItem in [l_dict_data objectForKey:@"Result"]) {
//            SPOrderData *l_data_cartItem=[[SPShoppingCartItemData alloc] init];
//            l_data_cartItem.mGoodsSN=[l_dict_cartItem objectForKey:@"GoodsSN"];
//            l_data_cartItem.mCount=[l_dict_cartItem objectForKey:@"Count"];
//            l_data_cartItem.mIsNoStock  =[l_dict_cartItem objectForKey:@"IsNoStock"];
//            
//            //            l_data_cartItem.mDiscountAmount=[l_dict_cartItem objectForKey:@"DiscountAmount"];
//            //            l_data_cartItem.mShopPrice=[l_dict_cartItem objectForKey:@"ShopPrice"];
//            
//            
//            [l_arr_cartList addObject:l_data_cartItem];
//            [l_data_cartItem release];
//        }
//        l_data_shopCart.mCartListArray=l_arr_cartList;
        
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderListDataSuccess:)]) {
            [m_delegate_orderList onResponseOrderListDataSuccess:l_data_shopCart];
        }
        [l_data_shopCart release];
    }else{
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderListDataFail)]) {
            [m_delegate_orderList onResponseOrderListDataFail];
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
-(void)onRequestOrderListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseOrderListDataFail)]) {
        [m_delegate_orderList onResponseOrderListDataFail];
    }
}
@end
