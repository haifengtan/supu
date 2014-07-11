//
//  SPArticleListAction.m
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleListAction.h"

@implementation SPArticleListAction
@synthesize m_delegate_articleList;

- (void)dealloc {
    m_delegate_articleList=nil;
    [m_request_articleList setUserInfo:nil];
    [m_request_articleList clearDelegatesAndCancel];
    [m_request_articleList release];m_request_articleList=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出文章请求
 */
-(void)requestArticleListData{
////////////////////////////
    if (m_request_articleList!=nil&&[m_request_articleList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_articleList respondsToSelector:@selector(onResponseArticleListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_articleList onResponseArticleListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetArticleList] forKey:SP_KEY_SIGN];
    m_request_articleList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetArticleList 
                                              postParams:l_dict 
                                                  object:self 
                                        onFinishedAction:@selector(onRequestArticleListDataFinishResponse:) 
                                          onFailedAction:@selector(onRequestArticleListDataFailResponse:)];
        
    [m_request_articleList startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPArticleListData *l_data_categoryList=[[SPArticleListData alloc] init];
        
        SPPageInfoData *l_data_pageInfo=[[SPPageInfoData alloc] init];
        NSDictionary *l_dict_pageInfo=[l_dict_data objectForKey:@"PageInfo"];
        l_data_pageInfo.mPageIndex=[l_dict_pageInfo objectForKey:@"PageIndex"];
        l_data_pageInfo.mPageSize=[l_dict_pageInfo objectForKey:@"PageSize"];
        l_data_pageInfo.mRecordCount=[l_dict_data objectForKey:@"RecordCount"];
        
        l_data_categoryList.mPageInfo=l_data_pageInfo;
        [l_data_pageInfo release];
        
        NSMutableArray *l_arr_articles=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_article in [l_dict_data objectForKey:@"ArticleList"]) {
            SPArticleItemData *l_data_item=[[SPArticleItemData alloc] init];
            l_data_item.mID=[l_dict_article objectForKey:@"ID"];
            l_data_item.mTitle=[l_dict_article objectForKey:@"ArticleTitle"];
            
            [l_arr_articles addObject:l_data_item];
            [l_data_item release];
        }
        l_data_categoryList.mArticleListArray=l_arr_articles;
        
        if ([(UIViewController*)m_delegate_articleList respondsToSelector:@selector(onResponseArticleListDataSuccess:)]) {
            [m_delegate_articleList onResponseArticleListDataSuccess:l_data_categoryList];
        }
        [l_data_categoryList release];
    }else{
        if ([(UIViewController*)m_delegate_articleList respondsToSelector:@selector(onResponseArticleListDataFail)]) {
            [m_delegate_articleList onResponseArticleListDataFail];
        }
    }
    m_request_articleList=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_articleList respondsToSelector:@selector(onResponseArticleListDataFail)]) {
        [m_delegate_articleList onResponseArticleListDataFail];
    }
    m_request_articleList=nil;
}
@end
