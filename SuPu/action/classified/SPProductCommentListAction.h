//
//  SPProductCommentListAction.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPProductCommentListData.h"

@protocol SPProductCommentListActionDelegate

-(NSDictionary*)onResponseProductCommentListAction;
-(void)onResponseProductCommentListDataSuccess:(SPProductCommentListData *)l_data_productCommentList;
-(void)onResponseProductCommentListDataFail;

@end

@interface SPProductCommentListAction : SPBaseAction{
    ASIHTTPRequest *m_request_productCommentList;
    id<SPProductCommentListActionDelegate> m_delegate_productCommentList;
}
@property(nonatomic,assign)id<SPProductCommentListActionDelegate> m_delegate_productCommentList;

/**
 *	@brief	发出请求
 *	
 *	发出商品列表请求
 */
-(void)requestProductCommentListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductCommentListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductCommentListDataFailResponse:(ASIHTTPRequest*)request;
@end
