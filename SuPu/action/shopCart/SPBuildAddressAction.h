//
//  SPBuildAddressAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
@protocol SPBuildAddressActionDelegate

-(void)onResponseBuildAddressDataSuccess:(NSArray *)l_data_cityList;
-(void)onResponseBuildAddressDataFail;

@end
@interface SPBuildAddressAction : SPBaseAction{
    ASIHTTPRequest *m_request_buildAddress;
    id<SPBuildAddressActionDelegate> m_delegate_buildAddress;
}
@property(nonatomic,assign)id<SPBuildAddressActionDelegate> m_delegate_buildAddress;

/**
 *	@brief	发出请求
 *
 *	发出购物车请求
 */
-(void)requestBuildAddressData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBuildAddressDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBuildAddressDataFailResponse:(ASIHTTPRequest*)request;
@end
