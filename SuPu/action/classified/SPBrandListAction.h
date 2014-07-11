//
//  SPBrandListAction.h
//  SuPu
//
//  品牌列表
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPBrandData.h"

@protocol SPBrandListActionDelegate

-(NSDictionary*)onResponseBrandListAction;
-(void)onResponseBrandListDataSuccess:(NSArray *)l_arr_brandList;
-(void)onResponseBrandListDataFail;

@end

@interface SPBrandListAction : SPBaseAction{
    ASIHTTPRequest *m_request_brandList;
    id<SPBrandListActionDelegate> m_delegate_brandList;
}
@property(nonatomic,assign)id<SPBrandListActionDelegate> m_delegate_brandList;

/**
 *	@brief	发出请求
 *	
 *	发出品牌请求
 */
-(void)requestBrandListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBrandListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBrandListDataFailResponse:(ASIHTTPRequest*)request;

@end
