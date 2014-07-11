//
//  SPOrderDetailsAction.m
//  SuPu
//
//  Created by xingyong on 13-5-15.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPOrderDetailsAction.h"
#import "SPProductDetailData.h"
#import "OrderDetail.h"
@implementation SPOrderDetailsAction

@synthesize m_delegate_orderDetials;

- (void)dealloc {
    m_delegate_orderDetials=nil;
    [m_request_orderDetials setUserInfo:nil];
    [m_request_orderDetials clearDelegatesAndCancel];
    [m_request_orderDetials release];m_request_orderDetials=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestOrderDetialsListData{
////////////////////////////
    if (m_request_orderDetials!=nil&&[m_request_orderDetials isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_orderDetials respondsToSelector:@selector(onRequestOrderDetialsAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderDetials onRequestOrderDetialsAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETORDER] forKey:SP_KEY_SIGN];
    
    m_request_orderDetials=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_GETORDER
                                                     postParams:l_dict
                                                         object:self
                                               onFinishedAction:@selector(onRequestListDataFinishResponse:)
                                                 onFailedAction:@selector(onRequestListDataFailResponse:)];
    [m_request_orderDetials startAsynchronous];
    
}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFinishResponse:(ASIHTTPRequest*)request{
    request.responseEncoding = NSUTF8StringEncoding;
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict=[l_str_response objectFromJSONString];
//                           NSLog(@"l_dict_response ------订单详情 ---%@",l_dict_response);
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict]) {
      NSDictionary *l_dict_response = [[l_dict objectForKey:@"Data"] objectForKey:@"Order"];
        

        PersonalOrder *order  = [[PersonalOrder alloc] init];
        order.OrderSN         = strOrEmpty([l_dict_response objectForKey:@"OrderSN"]);
        order.Address         = strOrEmpty([l_dict_response objectForKey:@"Address"]);
        order.Tel             = strOrEmpty([l_dict_response objectForKey:@"Tel"]);
        order.Account         = strOrEmpty([l_dict_response objectForKey:@"Account"]);
        order.ZipCode         = strOrEmpty([l_dict_response objectForKey:@"ZipCode"]);
        order.ShippingFee     = strOrEmpty([l_dict_response objectForKey:@"ShippingFee"]);
        order.PayName         = strOrEmpty([l_dict_response objectForKey:@"PayName"]);
        order.PayStatus       = strOrEmpty([l_dict_response objectForKey:@"PayStatus"]);
        order.OrderStatus     = strOrEmpty([l_dict_response objectForKey:@"OrderStatus"]);
        order.ShippingName    = strOrEmpty([l_dict_response objectForKey:@"ShippingName"]);
        order.Mobile          = strOrEmpty([l_dict_response objectForKey:@"Mobile"]);
        order.Consignee       = strOrEmpty([l_dict_response objectForKey:@"Consignee"]);
        order.GoodsSubtotal   = strOrEmpty([l_dict_response objectForKey:@"GoodsSubtotal"]);
        order.CashPrice       = strOrEmpty([l_dict_response objectForKey:@"CashPrice"]);
        order.Discount        = strOrEmpty([l_dict_response objectForKey:@"Discount"]);
        order.OrderAmount     = strOrEmpty([l_dict_response objectForKey:@"OrderAmount"]);
        order.TicketDiscount  = strOrEmpty([l_dict_response objectForKey:@"TicketDiscount"]);

        
        NSArray *data_array = [l_dict_response objectForKey:@"OrderDetail"];
        NSMutableArray *order_array = [NSMutableArray arrayWithCapacity:data_array.count];
        
        for (NSDictionary *l_order_dict in data_array) {
            OrderDetail *product = [[OrderDetail alloc] init];
            product.GoodsName    = strOrEmpty([l_order_dict objectForKey:@"GoodsName"]);
            product.ImgFile      = strOrEmpty([l_order_dict objectForKey:@"ImgFile"]);
            product.GoodsSN      = strOrEmpty([l_order_dict objectForKey:@"GoodsSN"]);
            product.Price        = strOrEmpty([l_order_dict objectForKey:@"Price"]);
            product.Count        = strOrEmpty([l_order_dict objectForKey:@"Count"]);
            [order_array addObject:product];
            [product release];
        }
        order.orderDetialsArray = order_array;

        if ([(UIViewController*)m_delegate_orderDetials respondsToSelector:@selector(onResponseOrderDetailsSuccess:)]) {
            [m_delegate_orderDetials onResponseOrderDetailsSuccess:order];
            
        }
        [order release];
    }else{
        
        if ([(UIViewController*)m_delegate_orderDetials respondsToSelector:@selector(onResponseOrderDetailsFail)]) {
            [m_delegate_orderDetials onResponseOrderDetailsFail];
        }
        
    }
    m_request_orderDetials=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_orderDetials respondsToSelector:@selector(onResponseOrderDetailsFail)]) {
        [m_delegate_orderDetials onResponseOrderDetailsFail];
    }
    m_request_orderDetials = nil;
}
@end