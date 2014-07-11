//
//  SPAddressListAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPAddressListData.h"
@protocol SPAddressListActionDelegate

-(NSDictionary*)onRequestAddressListDataAction;
-(void)onResponseAddressListDataSuccess:(NSArray*)l_array_address;
-(void)onResponseAddressListDataFail;

@end

@interface SPAddressListAction : SPBaseAction{
    ASIHTTPRequest *m_request_addresslist;
    id<SPAddressListActionDelegate> m_delegate_addresslist;
}
@property(nonatomic,assign)id<SPAddressListActionDelegate> m_delegate_addresslist;

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestAddressListData;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressListDataFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressListDataFailResponse:(ASIHTTPRequest*)request;
@end

