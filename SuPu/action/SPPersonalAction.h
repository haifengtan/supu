//
//  SPPersonalAction.h
//  SuPu
//
//  Created by 持创 on 13-3-20.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//
#import "SPBaseAction.h"
#import "SPHomeData.h"
@protocol SPCategoryListActionDelegate_a

-(NSMutableDictionary *)onResponseCategoryListAction;
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList;
-(void)onResponseCategoryListDataFail;

@end
@interface SPPersonalAction : SPBaseAction{

    ASIHTTPRequest *m_request_categoryList;
    id<SPCategoryListActionDelegate_a> m_delegate_categoryList;
}
@property(nonatomic,assign)id<SPCategoryListActionDelegate_a> m_delegate_categoryList;

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
