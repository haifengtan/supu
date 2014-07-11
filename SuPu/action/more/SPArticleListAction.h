//
//  SPArticleListAction.h
//  SuPu
//
//  文章列表
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPArticleListData.h"
#import "SPArticleData.h"

@protocol SPArticleListActionDelegate

-(NSDictionary*)onResponseArticleListAction;
-(void)onResponseArticleListDataSuccess:(SPArticleListData *)l_data_articleList;
-(void)onResponseArticleListDataFail;

@end

@interface SPArticleListAction : SPBaseAction{
    ASIHTTPRequest *m_request_articleList;
    id<SPArticleListActionDelegate> m_delegate_articleList;
}
@property(nonatomic,assign)id<SPArticleListActionDelegate> m_delegate_articleList;

/**
 *	@brief	发出请求
 *	
 *	发出文章请求
 */
-(void)requestArticleListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleListDataFailResponse:(ASIHTTPRequest*)request;
@end
