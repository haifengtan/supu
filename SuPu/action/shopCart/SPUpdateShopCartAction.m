//
//  SPUpdateShopCartAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPUpdateShopCartAction.h"

@implementation SPUpdateShopCartAction

@synthesize m_delegate_updateShopCart;

- (void)dealloc {
    m_delegate_updateShopCart=nil;
    [m_request_updateShopCart setUserInfo:nil];
    [m_request_updateShopCart clearDelegatesAndCancel];
    [m_request_updateShopCart release];m_request_updateShopCart=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestUpdateShopCartData{
////////////////////////////
    if (m_request_updateShopCart!=nil&&[m_request_updateShopCart isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_updateShopCart respondsToSelector:@selector(onRequestUpdateShopCartAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_updateShopCart onRequestUpdateShopCartAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_MODIFYSHOPPINGCART] forKey:SP_KEY_SIGN];

    m_request_updateShopCart=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_MODIFYSHOPPINGCART
                                                  postParams:l_dict
                                                      object:self
                                            onFinishedAction:@selector(onRequestUpdateShopCartDataFinishResponse:)
                                              onFailedAction:@selector(onRequestUpdateShopCartDataFailResponse:)];
    
    [m_request_updateShopCart startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestUpdateShopCartDataFinishResponse:(ASIHTTPRequest *)request{
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
//    NSLog(@"修改购物车后的结果： %@",l_dict_response);
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
    
        SPShoppingCartData *l_data_shopCart=[[SPShoppingCartData alloc] init];
        l_data_shopCart.mSumAmount=[l_dict_data objectForKey:@"SumAmount"];
        l_data_shopCart.mDiscountAmount=[l_dict_data objectForKey:@"DiscountAmount"];
        
        NSMutableArray *l_arr_cartList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_cartItem in [l_dict_data objectForKey:@"Result"]) {
            SPShoppingCartItemData *l_data_cartItem=[[SPShoppingCartItemData alloc] init];
            l_data_cartItem.mGoodsSN=[l_dict_cartItem objectForKey:@"GoodsSN"];
            l_data_cartItem.mGoodsName=[l_dict_cartItem objectForKey:@"GoodsName"];
            l_data_cartItem.mCount=[l_dict_cartItem objectForKey:@"Count"];
            l_data_cartItem.mIsNoStock  =[l_dict_cartItem objectForKey:@"IsNoStock"];
  
            l_data_cartItem.mShopPrice=[l_dict_cartItem objectForKey:@"ShopPrice"];
 
            l_data_cartItem.mImgFile=[l_dict_cartItem objectForKey:@"ImgFile"];
  
            [l_arr_cartList addObject:l_data_cartItem];
            [l_data_cartItem release];
        }
        NSString *sum = [l_dict_data objectForKey:@"SumAmount"];
        
        l_data_shopCart.mCartListArray=l_arr_cartList;
        
        if ([(UIViewController*)m_delegate_updateShopCart respondsToSelector:@selector(onResponseUpdateShopCartDataSuccess:sumAmount:)]) {
            [m_delegate_updateShopCart onResponseUpdateShopCartDataSuccess:l_data_shopCart sumAmount:sum];
        }
        [l_data_shopCart release];
    }else{
        if ([(UIViewController*)m_delegate_updateShopCart respondsToSelector:@selector(onResponseUpdateShopCartDataFail)]) {
            [m_delegate_updateShopCart onResponseUpdateShopCartDataFail];
        }
    }
    m_request_updateShopCart=nil;
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestUpdateShopCartDataFailResponse:(ASIHTTPRequest *)request{
    if ([(UIViewController*)m_delegate_updateShopCart respondsToSelector:@selector(onResponseUpdateShopCartDataFail)]) {
        [m_delegate_updateShopCart onResponseUpdateShopCartDataFail];
    }
}
@end
