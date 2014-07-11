//
//  SPArticleCategoryListAction.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPArticleCategoryListData.h"

@protocol SPArticleCategoryListActionDelegate

-(NSDictionary*)onResponseCategoryListAction;
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList;
-(void)onResponseCategoryListDataFail;

@end

@interface SPArticleCategoryListAction : SPBaseAction{
    ASIHTTPRequest *m_request_categoryList;
    id<SPArticleCategoryListActionDelegate> m_delegate_categoryList;
}
@property(nonatomic,assign)id<SPArticleCategoryListActionDelegate> m_delegate_categoryList;

/**
 *	@brief	发出请求
 *	
 *	发出文章分类请求
 */
-(void)requestArticleCategoryListData;

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleCategoryListDataFinishResponse:(ASIHTTPRequest*)request;

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleCategoryListDataFailResponse:(ASIHTTPRequest*)request;
@end
