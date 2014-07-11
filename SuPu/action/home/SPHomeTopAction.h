//
//  SPHomeTopAction.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPHomeTopData.h"

@protocol SPHomeTopActionDelegate

-(void)onResponseHomeTopDataSuccess:(NSArray *)l_arr_homeItem;
-(void)onResponseHomeTopDataFail;

@end

@interface SPHomeTopAction : SPBaseAction{
    ASIHTTPRequest *m_request_homeTop;
    id<SPHomeTopActionDelegate> m_delegate_homeTop;
}
@property(nonatomic,assign)id<SPHomeTopActionDelegate> m_delegate_homeTop;

/**
 *	@brief	发出请求
 *	
 *	发出首页焦点图请求
 */
-(void)requestHomeTopData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeTopDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeTopDataFailResponse:(ASIHTTPRequest*)request;
@end
