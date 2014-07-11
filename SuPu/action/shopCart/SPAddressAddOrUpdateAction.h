//
//  SPAddressAddOrUpdateAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-31.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"

@protocol SPAddressAddOrUpdateActionDelegate

-(NSDictionary*)onRequestAddressAddAction;
-(void)onResponseAddressAddSuccess;
-(void)onResponseAddressAddFail;

@end


@interface SPAddressAddOrUpdateAction : SPBaseAction{

    ASIHTTPRequest *m_request_addressAdd;
    id<SPAddressAddOrUpdateActionDelegate> m_delegate_addressAdd;
}

@property(nonatomic,assign)id<SPAddressAddOrUpdateActionDelegate> m_delegate_addressAdd;

/**
 *	@brief	发出请求
 *
 *	请求添加地址数据
 */
-(void)requestAddressAdd;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressAddFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressAddFailResponse:(ASIHTTPRequest*)request;

@end
