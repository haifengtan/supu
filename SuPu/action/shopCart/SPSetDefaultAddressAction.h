//
//  SPSetDefaultAddressAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPAddressListData.h"
@protocol SPSetDefaultAddressActionDelegate

//-(NSDictionary*)onRequestAddressSetDefaultAction;
-(void)onResponseAddressSetDefaultSuccess:(SPAddressListData*)addressList;
-(void)onResponseAddressSetDefaultFail;

@end

@interface SPSetDefaultAddressAction : SPBaseAction{
    ASIHTTPRequest *m_request_setDefault;
    id<SPSetDefaultAddressActionDelegate> m_delegate_setDefault;
}
@property(nonatomic,assign)id<SPSetDefaultAddressActionDelegate> m_delegate_setDefault;

/**
 *	@brief	发出请求
 *
 *	请求设置默认地址数据
 */
-(void)requestAddressSetDefault;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressSetDefaultFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressSetDefaultFailResponse:(ASIHTTPRequest*)request;
@end
