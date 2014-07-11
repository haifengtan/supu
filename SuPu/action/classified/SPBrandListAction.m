//
//  SPBrandListAction.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBrandListAction.h"

@implementation SPBrandListAction
@synthesize m_delegate_brandList;

- (void)dealloc {
    m_delegate_brandList=nil;
    [m_request_brandList setUserInfo:nil];
    [m_request_brandList clearDelegatesAndCancel];
    [m_request_brandList release];m_request_brandList=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出品牌请求
 */
-(void)requestBrandListData{
////////////////////////////
    if (m_request_brandList!=nil&&[m_request_brandList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_brandList respondsToSelector:@selector(onResponseBrandListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_brandList onResponseBrandListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetBrandList] forKey:SP_KEY_SIGN];
    m_request_brandList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetBrandList 
                                                      postParams:l_dict 
                                                          object:self 
                                                onFinishedAction:@selector(onRequestBrandListDataFinishResponse:) 
                                                  onFailedAction:@selector(onRequestBrandListDataFailResponse:)];
    
    [m_request_brandList startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBrandListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        NSMutableArray *l_arr_brand=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_brand in [l_dict_data objectForKey:@"BrandList"]) {
            SPBrandData *l_data_brand=[[SPBrandData alloc] init];
            l_data_brand.mBrandID=[l_dict_brand objectForKey:@"BrandID"];
            l_data_brand.mBrandName=[l_dict_brand objectForKey:@"BrandName"];
            l_data_brand.mSortOrder=[l_dict_brand objectForKey:@"SortOrder"];
            
            [l_arr_brand addObject:l_data_brand];
            [l_data_brand release];
        }
        
        if ([(UIViewController*)m_delegate_brandList respondsToSelector:@selector(onResponseBrandListDataSuccess:)]) {
            [m_delegate_brandList onResponseBrandListDataSuccess:l_arr_brand];
        }
    }else{
        if ([(UIViewController*)m_delegate_brandList respondsToSelector:@selector(onResponseBrandListDataFail)]) {
            [m_delegate_brandList onResponseBrandListDataFail];
        }
    }
    m_request_brandList=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestBrandListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_brandList respondsToSelector:@selector(onResponseBrandListDataFail)]) {
        [m_delegate_brandList onResponseBrandListDataFail];
    }
    m_request_brandList=nil;
}
@end
