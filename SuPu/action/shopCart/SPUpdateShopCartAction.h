//
//  SPUpdateShopCartAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPShoppingCartData.h"
@protocol SPUpdateShopCartActionDelegate
-(NSDictionary *)onRequestUpdateShopCartAction;
-(void)onResponseUpdateShopCartDataSuccess:(SPShoppingCartData *)l_data_UpdateShopCart sumAmount:(NSString *)sum;
-(void)onResponseUpdateShopCartDataFail;

@end

@interface SPUpdateShopCartAction : SPBaseAction{
    ASIHTTPRequest *m_request_updateShopCart;
    id<SPUpdateShopCartActionDelegate> m_delegate_updateShopCart;
}
@property(nonatomic,assign)id<SPUpdateShopCartActionDelegate> m_delegate_updateShopCart;

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestUpdateShopCartData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestUpdateShopCartDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestUpdateShopCartDataFailResponse:(ASIHTTPRequest*)request;
@end


