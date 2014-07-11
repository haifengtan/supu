//
//  SPHomeAction.m
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeAction.h"

@implementation SPHomeAction
@synthesize m_delegate_home;

- (void)dealloc {
    m_delegate_home=nil;
    [m_request_home setUserInfo:nil];
    [m_request_home clearDelegatesAndCancel];
    [m_request_home release];m_request_home=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出首页优惠信息请求
 */
-(void)requestHomeData{
////////////////////////////
    if (m_request_home!=nil&&[m_request_home isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if (nil) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:nil];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETINDEXTOPGOODS] forKey:SP_KEY_SIGN];
    m_request_home=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETINDEXTOPGOODS 
                                              postParams:l_dict 
                                                  object:self 
                                        onFinishedAction:@selector(onRequestHomeDataFinishResponse:) 
                                          onFailedAction:@selector(onRequestHomeDataFailResponse:)];
    NSDictionary *l_userInfo=m_request_home.userInfo;
    NSMutableDictionary *l_dict_userInfo=[NSMutableDictionary dictionaryWithDictionary:l_userInfo];
    [l_dict_userInfo setObject:(NSString*)SP_METHOD_GETINDEXTOPGOODS forKey:@"method"];
    [m_request_home setUserInfo:l_dict_userInfo];
    
    [m_request_home startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_method=[request.userInfo objectForKey:@"method"];
    if (!l_str_method||![l_str_method isEqualToString:(NSString*)SP_METHOD_GETINDEXTOPGOODS]) {
        return;
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
        
        if ([(UIViewController*)m_delegate_home respondsToSelector:@selector(onResponseHomeDataSuccess:)]) {
            [m_delegate_home onResponseHomeDataSuccess:l_array_topGoods];
        }
    }else{
        if ([(UIViewController*)m_delegate_home respondsToSelector:@selector(onResponseHomeDataFail)]) {
            [m_delegate_home onResponseHomeDataFail];
        }
    }
    m_request_home=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_home respondsToSelector:@selector(onResponseHomeDataFail)]) {
        [m_delegate_home onResponseHomeDataFail];
    }
    m_request_home=nil;
}

@end
