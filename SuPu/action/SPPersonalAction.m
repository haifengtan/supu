//
//  SPPersonalAction.m
//  SuPu
//
//  Created by 持创 on 13-3-20.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPPersonalAction.h"

@implementation SPPersonalAction
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
 *	发出分类请求
 */
-(void)requestCategoryListData{
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
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETMEMBERTOPGOODS] forKey:SP_KEY_SIGN];
    m_request_categoryList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETMEMBERTOPGOODS
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestCategoryListDataFinishResponse:)
                                                  onFailedAction:@selector(onRequestCategoryListDataFailResponse:)];
    
    [m_request_categoryList startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCategoryListDataFinishResponse:(ASIHTTPRequest*)request{

    NSString *l_str_method=[request.userInfo objectForKey:@"method"];

    if (!l_str_method||![l_str_method isEqualToString:(NSString*)SP_METHOD_GETMEMBERTOPGOODS]) {
//        return;
    }
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        NSMutableArray *l_array_topGoods=[NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *l_dict_homeItem in [l_dict_data objectForKey:@"TopGoodsList"]) {
            SPHomeItemData *l_data_homeItem=[[SPHomeItemData alloc] init];
            l_data_homeItem.mName=[l_dict_homeItem objectForKey:@"Name"];
            
            NSMutableArray *l_array_good=[NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *l_dict_goods in [l_dict_homeItem objectForKey:@"Goods"]) {
                SPHomeGoodData *l_data_good=[[SPHomeGoodData alloc] init];
                l_data_good.mGoodsSN=[l_dict_goods objectForKey:@"GoodsSN"];
                l_data_good.mImgFile=[l_dict_goods objectForKey:@"ImgFile"];
                l_data_good.mPrice=[l_dict_goods objectForKey:@"Price"];
                
                [l_array_good addObject:l_data_good];
                [l_data_good release];
            }
            l_data_homeItem.mGoodsArray=l_array_good;
            
            [l_array_topGoods addObject:l_data_homeItem];
            [l_data_homeItem release];
        }
        
        if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataSuccess:)]) {
            [m_delegate_categoryList onResponseCategoryListDataSuccess:l_array_topGoods];
        }
    }else{
        if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataFail)]) {
            [m_delegate_categoryList onResponseCategoryListDataFail];
        }
    }
    m_delegate_categoryList=nil;
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCategoryListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_categoryList respondsToSelector:@selector(onResponseCategoryListDataFail)]) {
        [m_delegate_categoryList onResponseCategoryListDataFail];
    }
    m_request_categoryList=nil;
}
@end
