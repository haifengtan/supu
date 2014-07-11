//
//  SPCollectAction.h
//  SuPu
//
//  Created by xingyong on 13-6-6.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPPageInfoData.h"
@protocol SPCollectActionDelegate
-(NSDictionary *)onRequestCollectAction;
-(void)onResponseCollectDataSuccess:(SPPageInfoData *)pageInfo;
-(void)onResponseCollectDataFail;

@end
@interface SPCollectAction : SPBaseAction
{
    ASIHTTPRequest *m_request_collect;
    id<SPCollectActionDelegate> m_delegate_collect;
}

@property(nonatomic,assign)id<SPCollectActionDelegate> m_delegate_collect;



/**
 *	@brief	发出请求
 *
 *	发出分类请求
 */
-(void)requestCollectListData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCollectListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCollectListDataFailResponse:(ASIHTTPRequest*)request;
@end
