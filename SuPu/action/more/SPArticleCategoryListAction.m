//
//  SPArticleCategoryListAction.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleCategoryListAction.h"

@implementation SPArticleCategoryListAction
@synthesize m_delegate_categoryList;

- (void)dealloc {
    m_delegate_categoryList=nil;
    [m_request_categoryList setUserInfo:nil];
    [m_request_categoryList clearDelegatesAndCancel];
    [m_request_categoryList release];m_request_categoryList=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出文章分类请求
 */
-(void)requestArticleCategoryListData{
////////////////////////////
    if (m_request_categoryList!=nil&&[m_request_categoryList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_categoryList onResponseCategoryListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetArticleCategoryList] forKey:SP_KEY_SIGN];
    m_request_categoryList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetArticleCategoryList 
                                                     postParams:l_dict 
                                                         object:self 
                                               onFinishedAction:@selector(onRequestArticleCategoryListDataFinishResponse:) 
                                                 onFailedAction:@selector(onRequestArticleCategoryListDataFailResponse:)];
    
    [m_request_categoryList startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleCategoryListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        NSMutableArray *l_arr_category=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_category in [l_dict_data objectForKey:@"ArticleCategoryList"]) {
            SPArticleCategoryListData *l_data_category=[[SPArticleCategoryListData alloc] init];
            l_data_category.mID=[l_dict_category objectForKey:@"ID"];
            l_data_category.mPicUrl=[l_dict_category objectForKey:@"PicUrl"];
            l_data_category.mSort=[l_dict_category objectForKey:@"Sort"];
            l_data_category.mCategoryName=[l_dict_category objectForKey:@"CategoryName"];
            
            [l_arr_category addObject:l_data_category];
            [l_data_category release];
        }
        
        if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataSuccess:)]) {
            [m_delegate_categoryList onResponseCategoryListDataSuccess:l_arr_category];
        }
    }else{
        if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataFail)]) {
            [m_delegate_categoryList onResponseCategoryListDataFail];
        }
    }
    m_request_categoryList=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleCategoryListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataFail)]) {
        [m_delegate_categoryList onResponseCategoryListDataFail];
    }
    m_request_categoryList=nil;
}
@end
