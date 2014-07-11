//
//  SPProductDetailAction.h
//  SuPu
//
//  Created by xx on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPProductDetailData.h"

@protocol SPProductDetailActionDelegate

-(NSDictionary*)onResponseProductDetailAction;
-(void)onResponseProductDetailDataSuccess:(SPProductDetailData *)l_data_productDetail;
-(void)onResponseProductDetailDataFail;

@end

@interface SPProductDetailAction : SPBaseAction{
    ASIHTTPRequest *m_request_productDetail;
    id<SPProductDetailActionDelegate> m_delegate_productDetail;
}
@property(nonatomic,assign)id<SPProductDetailActionDelegate> m_delegate_productDetail;


/**
 *	@brief	发出请求
 *	
 *	发出商品详情请求
 */
-(void)requestProductDetailData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductDetailDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductDetailDataFailResponse:(ASIHTTPRequest*)request;
@end
