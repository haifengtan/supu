//
//  SPUPPayPluginAction.h
//  SuPu
//
//  Created by xingyong on 13-5-10.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
@protocol SPUPPayPluginActionDelegate

-(NSDictionary*)onRequestPayPluginAction;
-(void)onResponsePayPluginSuccess:(NSString *)tradeNumber ServerMode:(NSString *)serverMode;
-(void)onResponsePayPluginFail;

@end
@interface SPUPPayPluginAction : SPBaseAction{
    ASIHTTPRequest *m_request_payPlugin;
    id<SPUPPayPluginActionDelegate> m_delegate_payPlugin;
}
@property(nonatomic,assign)id<SPUPPayPluginActionDelegate> m_delegate_payPlugin;

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestPayPluginListData;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestListDataFailResponse:(ASIHTTPRequest*)request;

@end

