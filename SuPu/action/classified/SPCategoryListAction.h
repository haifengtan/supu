//
//  SPCategoryListAction.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPCategoryListData.h"

@protocol SPCategoryListActionDelegate

-(NSDictionary*)onResponseCategoryListAction;
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList;
-(void)onResponseCategoryListDataFail;

@end

@interface SPCategoryListAction : SPBaseAction{
    ASIHTTPRequest *m_request_categoryList;
    id<SPCategoryListActionDelegate> m_delegate_categoryList;
}
@property(nonatomic,assign)id<SPCategoryListActionDelegate> m_delegate_categoryList;

/**
 *	@brief	发出请求
 *	
 *	发出分类请求
 */
-(void)requestCategoryListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCategoryListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCategoryListDataFailResponse:(ASIHTTPRequest*)request;

@end
