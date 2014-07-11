//
//  SPPaymentStyleAction.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPStyleList.h"

@protocol SPPaymentStyleActionDelegate

-(NSDictionary*)onRequestPaymentAction;
-(void)onResponsePaymentSuccess:(SPStyleList *) styleData;
-(void)onResponsePaymentFail;

@end

@interface SPPaymentStyleAction : SPBaseAction{
    ASIHTTPRequest *m_request_payment;
    id<SPPaymentStyleActionDelegate> m_delegate_payment;
}
@property(nonatomic,assign) id<SPPaymentStyleActionDelegate> m_delegate_payment;


/**
 *	@brief	发出请求
 *
 *	请求wap支付页面URL
 */
-(void)requestPayment;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPaymentFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestPaymentFailResponse:(ASIHTTPRequest*)request;

@end
