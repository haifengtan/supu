//
//  SPVersionUpdateAction.h
//  SuPu
//
//  Created by xingyong on 13-5-22.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
@protocol SPVersionUpdateActionDelegate

-(NSDictionary*)onRequestVersionUpdateAction;
-(void)onResponseVersionUpdateSuccess:(NSDictionary *)dict;
-(void)onResponseVersionUpdateFail;

@end
@interface SPVersionUpdateAction : SPBaseAction{
    ASIHTTPRequest *m_request_version;
    id<SPVersionUpdateActionDelegate> m_delegate_version;
}
@property(nonatomic,assign)id<SPVersionUpdateActionDelegate> m_delegate_version;

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestVersionUpdate;

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

