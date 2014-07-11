//
//  SPHomeAction.h
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPHomeData.h"

@protocol SPHomeActionDelegate

-(void)onResponseHomeDataSuccess:(NSArray *)l_arr_homeItem;
-(void)onResponseHomeDataFail;

@end

@interface SPHomeAction : SPBaseAction{
    ASIHTTPRequest *m_request_home;
    id<SPHomeActionDelegate> m_delegate_home;
}
@property(nonatomic,assign)id<SPHomeActionDelegate> m_delegate_home;

/**
 *	@brief	发出请求
 *	
 *	发出首页优惠信息请求
 */
-(void)requestHomeData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeDataFailResponse:(ASIHTTPRequest*)request;
@end
