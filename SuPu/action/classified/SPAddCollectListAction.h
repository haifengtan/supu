//
//  SPAddCollectListAction.h
//  SuPu
//
//  Created by xx on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"

@protocol SPAddCollectListActionDelegate

-(NSDictionary*)onResponseAddCollectListAction;
-(void)onResponseAddCollectListSuccess;
-(void)onResponseAddCollectListFail;

@end

@interface SPAddCollectListAction : SPBaseAction{
    ASIHTTPRequest *m_request_addCollect;
    id<SPAddCollectListActionDelegate> m_delegate_addCollect;
}
@property(nonatomic,assign)id<SPAddCollectListActionDelegate> m_delegate_addCollect;

/**
 *	@brief	发出请求
 *	
 *	发出加入收藏数据请求
 */
-(void)requestAddCollectList;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddCollectListFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddCollectListFailResponse:(ASIHTTPRequest*)request;
@end
