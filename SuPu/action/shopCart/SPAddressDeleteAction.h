//
//  SPAddressDeleteAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"

@protocol SPAddressDeleteActionDelegate

-(NSDictionary*)onRequestAddressDeleAction;
-(void)onResponseAddressDeleSuccess;
-(void)onResponseAddressDeleFail;

@end
@interface SPAddressDeleteAction : SPBaseAction{
    ASIHTTPRequest *m_request_addressDele;
    id<SPAddressDeleteActionDelegate> m_delegate_addressDele;
}
@property(nonatomic,assign)id<SPAddressDeleteActionDelegate> m_delegate_addressDele;

/**
 *	@brief	发出请求
 *
 *	请求删除地址数据
 */
-(void)requestAddressDele;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressDeleFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressDeleFailResponse:(ASIHTTPRequest*)request;
@end
