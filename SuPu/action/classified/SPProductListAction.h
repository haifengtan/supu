//
//  SPProductListAction.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPProductListData.h"

@protocol SPProductListActionDelegate

-(NSDictionary*)onResponseProductListAction;
-(void)onResponseProductListDataSuccess:(SPProductListData *)l_data_productList;
-(void)onResponseProductListDataFail;

@end

@interface SPProductListAction : SPBaseAction{
    ASIHTTPRequest *m_request_productList;
    id<SPProductListActionDelegate> m_delegate_productList;
}
@property(nonatomic,assign)id<SPProductListActionDelegate> m_delegate_productList;

/**
 *	@brief	发出请求
 *	
 *	发出商品列表请求
 */
-(void)requestProductListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductListDataFailResponse:(ASIHTTPRequest*)request;
@end
