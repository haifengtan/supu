//
//  SPFilterAction.h
//  SuPu
//
//  Created by xx on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPFilterItemData.h"

@protocol SPFilterActionDelegate

-(NSDictionary*)onResponseFilterDataAction;
-(void)onResponseFilterDataSuccess:(NSDictionary *)l_dict_filterData;
-(void)onResponseFilterDataFail;

@end

@interface SPFilterAction : SPBaseAction{
    ASIHTTPRequest *m_request_filter;
    id<SPFilterActionDelegate> m_delegate_filter;
}
@property(nonatomic,assign)id<SPFilterActionDelegate> m_delegate_filter;

/**
 *	@brief	发出请求
 *	
 *	发出筛选数据请求
 */
-(void)requestFilterData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFilterDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFilterDataFailResponse:(ASIHTTPRequest*)request;
@end
