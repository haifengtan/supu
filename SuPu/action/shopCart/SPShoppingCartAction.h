//
//  SPShoppingCartAction.h
//  SuPu
//
/*
 #import <Foundation/Foundation.h>
 #import "SPDataWorld.h"
 #import "ASIHTTPRequest.h"
 #import "SPActionUtility.h"
 
 @interface SPBaseAction : NSObject
 
 @end
 */
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPShoppingCartData.h"

@protocol SPShoppingCartActionDelegate

-(void)onResponseShoppingCartDataSuccess:(SPShoppingCartData *)l_data_shopCart sumAmout:(NSString *)sum;
-(void)onResponseShoppingCartDataFail;

@end

@interface SPShoppingCartAction : SPBaseAction{
    ASIHTTPRequest *m_request_shopCart;
    id<SPShoppingCartActionDelegate> m_delegate_shopCart;
}
@property(nonatomic,assign)id<SPShoppingCartActionDelegate> m_delegate_shopCart;

/**
 *	@brief	发出请求
 *	
 *	发出购物车请求
 */
-(void)requestShoppingCartData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestShoppingCartDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestShoppingCartDataFailResponse:(ASIHTTPRequest*)request;
@end
