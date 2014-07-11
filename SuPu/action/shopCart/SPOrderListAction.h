//
//  SPOrderListAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPOrderData.h"
@protocol SSPOrderListActionDelegate
-(NSDictionary *)onRequestOrderListAction;
-(void)onResponseOrderListDataSuccess:(SPOrderData *)l_data_orderList;
-(void)onResponseOrderListDataFail;

@end
@interface SPOrderListAction : SPBaseAction{
    ASIHTTPRequest *m_request_orderList;
    id<SSPOrderListActionDelegate> m_delegate_orderList;
}
@property(nonatomic,assign)id<SSPOrderListActionDelegate> m_delegate_orderList;

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestOrderListData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestOrderListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestOrderListDataFailResponse:(ASIHTTPRequest*)request;
@end


