//
//  SPShoppingCartAction.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPShoppingCartAction.h"

@implementation SPShoppingCartAction
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
 *	发出购物车请求
 */
-(void)requestShoppingCartData{
////////////////////////////
    if (m_request_shopCart!=nil&&[m_request_shopCart isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;;
    if (nil) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:nil];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETSHOPPINGCART] forKey:SP_KEY_SIGN];
    m_request_shopCart=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETSHOPPINGCART 
                                                 postParams:l_dict 
                                                     object:self 
                                           onFinishedAction:@selector(onRequestShoppingCartDataFinishResponse:) 
                                             onFailedAction:@selector(onRequestShoppingCartDataFailResponse:)];
    
    [m_request_shopCart startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestShoppingCartDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPShoppingCartData *l_data_shopCart=[[SPShoppingCartData alloc] init];
        l_data_shopCart.mSumAmount=[l_dict_data objectForKey:@"SumAmount"];
        l_data_shopCart.mDiscountAmount=[l_dict_data objectForKey:@"DiscountAmount"];
        
        NSMutableArray *l_arr_cartList=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray *l_arr_giftList=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_cartItem in [l_dict_data objectForKey:@"CartList"]) {
            SPShoppingCartItemData *l_data_cartItem=[[SPShoppingCartItemData alloc] init];
            l_data_cartItem.mGoodsSN=[l_dict_cartItem objectForKey:@"GoodsSN"];
            l_data_cartItem.mCount=[l_dict_cartItem objectForKey:@"Count"];
            l_data_cartItem.mDiscountAmount=[l_dict_cartItem objectForKey:@"DiscountAmount"];
            l_data_cartItem.mShopPrice=[l_dict_cartItem objectForKey:@"ShopPrice"];

            l_data_cartItem.mGoodsName=[l_dict_cartItem objectForKey:@"GoodsName"];
            l_data_cartItem.mImgFile=[l_dict_cartItem objectForKey:@"ImgFile"];
            l_data_cartItem.mIsGift=[l_dict_cartItem objectForKey:@"IsGift"];
            l_data_cartItem.mIsNoStock=[l_dict_cartItem objectForKey:@"IsNoStock"];
 
            [l_arr_cartList addObject:l_data_cartItem];
            [l_data_cartItem release];
        }
        l_data_shopCart.mCartListArray=l_arr_cartList;
        l_data_shopCart.mGiftListArray=l_arr_giftList;
        
        NSString *sum = [l_dict_data objectForKey:@"SumAmount"];
        
        if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseShoppingCartDataSuccess:sumAmout:)]) {
            [m_delegate_shopCart onResponseShoppingCartDataSuccess:l_data_shopCart sumAmout:sum];
        }
        [l_data_shopCart release];
    }else{
        if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseShoppingCartDataFail)]) {
            [m_delegate_shopCart onResponseShoppingCartDataFail];
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
-(void)onRequestShoppingCartDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_shopCart respondsToSelector:@selector(onResponseShoppingCartDataFail)]) {
        [m_delegate_shopCart onResponseShoppingCartDataFail];
    }
}
@end
