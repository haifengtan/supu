//
//  SPOrderDetailsAction.h
//  SuPu
//
//  Created by xingyong on 13-5-15.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "PersonalOrder.h"
@protocol SPOrderDetailsActionDelegate

-(NSDictionary*)onRequestOrderDetialsAction;
-(void)onResponseOrderDetailsSuccess:(PersonalOrder *)order;
-(void)onResponseOrderDetailsFail;

@end
@interface SPOrderDetailsAction : SPBaseAction {
    ASIHTTPRequest *m_request_orderDetials;
    id<SPOrderDetailsActionDelegate> m_delegate_orderDetials;
}
@property(nonatomic,assign)id<SPOrderDetailsActionDelegate> m_delegate_orderDetials;

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestOrderDetialsListData;

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

