//
//  SPPersonalInfomations.h
//  SuPu
//
//  Created by 持创 on 13-3-25.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "Member.h"
@protocol SSPOrderMemberActionDelegate
-(NSDictionary *)onRequestOrderMemberAction;
-(void)onResponseOrderMemberDataSuccess:(Member *)l_data_orderList;
-(void)onResponseOrderMemberDataFail;

@end
@interface SPPersonalInfomations : SPBaseAction{
    ASIHTTPRequest *m_request_orderList;
    id<SSPOrderMemberActionDelegate> m_delegate_orderList;
}

@property(nonatomic,assign)id<SSPOrderMemberActionDelegate> m_delegate_orderList;

/**
 *	@brief	发出请求
 *
 *	发出用户信息请求
 */
-(void)requestPersonalInfomationData;

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPersonalInfomationDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPersonalInfomationDataFailResponse:(ASIHTTPRequest*)request;
@end
