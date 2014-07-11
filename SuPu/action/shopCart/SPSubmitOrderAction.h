//
//  SPSubmitOrderAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "PersonalOrder.h"
@protocol SPSubmitOrderActionDelegate
-(NSDictionary *)onRequestSubmitOrderAction;
-(void)onResponseSubmitOrderDataSuccess:(PersonalOrder *)l_data_UpdateShopCart;
-(void)onResponseSubmitOrderDataFail;

@end

@interface SPSubmitOrderAction : SPBaseAction{
    ASIHTTPRequest *m_request_submitOrder;
    id<SPSubmitOrderActionDelegate> m_delegate_submitOrder;
}
@property(nonatomic,assign)id<SPSubmitOrderActionDelegate> m_delegate_submitOrder;

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestSubmitOrderData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestSubmitOrderDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestSubmitOrderDataFailResponse:(ASIHTTPRequest*)request;
@end


