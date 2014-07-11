//
//  SPArticleDetailAction.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPArticleData.h"

@protocol SPArticleDetailActionDelegate

-(NSDictionary*)onResponseArticleDetailDataAction;
-(void)onResponseArticleDetailDataSuccess:(SPArticleData *)l_data_article;
-(void)onResponseArticleDetailDataFail;
@end

@interface SPArticleDetailAction : SPBaseAction{
    ASIHTTPRequest *m_request_articleDetail;
    id<SPArticleDetailActionDelegate> m_delegate_articleDetail;
}
@property(nonatomic,assign)id<SPArticleDetailActionDelegate> m_delegate_articleDetail;

/**
 *	@brief	发出请求
 *	
 *	发出文章详情请求
 */
-(void)requestArticleDetailData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleDetailDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleDetailDataFailResponse:(ASIHTTPRequest*)request;
@end
