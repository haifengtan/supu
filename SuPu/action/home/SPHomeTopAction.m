//
//  SPHomeTopAction.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeTopAction.h"

@implementation SPHomeTopAction
@synthesize m_delegate_homeTop;


- (void)dealloc {
    m_delegate_homeTop=nil;
    [m_request_homeTop setUserInfo:nil];
    [m_request_homeTop clearDelegatesAndCancel];
    [m_request_homeTop release];m_request_homeTop=nil;
    [super dealloc];
}
/**
 *	@brief	发出请求
 *	
 *	发出首页焦点图请求
 */
-(void)requestHomeTopData{
////////////////////////////
    if (m_request_homeTop!=nil&&[m_request_homeTop isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;;
    if (nil) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:nil];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETINDEXTOPIMG] forKey:SP_KEY_SIGN];
    m_request_homeTop=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETINDEXTOPIMG 
                                              postParams:l_dict 
                                                  object:self 
                                        onFinishedAction:@selector(onRequestHomeTopDataFinishResponse:) 
                                          onFailedAction:@selector(onRequestHomeTopDataFailResponse:)];
    NSDictionary *l_userInfo=m_request_homeTop.userInfo;
    NSMutableDictionary *l_dict_userInfo=[NSMutableDictionary dictionaryWithDictionary:l_userInfo];
    [l_dict_userInfo setObject:(NSString*)SP_METHOD_GETINDEXTOPIMG forKey:@"method"];
    [m_request_homeTop setUserInfo:l_dict_userInfo];
    
    [m_request_homeTop startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeTopDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_method=[request.userInfo objectForKey:@"method"];
    if (!l_str_method||![l_str_method isEqualToString:(NSString*)SP_METHOD_GETINDEXTOPIMG]) {
        return;
    }
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        NSMutableArray *l_arr_topImg=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_pic in [l_dict_data objectForKey:@"PicList"]) {
            SPHomeTopData *l_data_topImg=[[SPHomeTopData alloc] init];
            l_data_topImg.mPicUrl=[l_dict_pic objectForKey:@"PicUrl"];
            l_data_topImg.mPicSort=[l_dict_pic objectForKey:@"PicSort"];
            l_data_topImg.mLinkType=[l_dict_pic objectForKey:@"LinkType"];
            l_data_topImg.mLinkData=[l_dict_pic objectForKey:@"LinkData"];
            
            [l_arr_topImg addObject:l_data_topImg];
            [l_data_topImg release];
        }
        
        if ([(UIViewController*)m_delegate_homeTop respondsToSelector:@selector(onResponseHomeTopDataSuccess:)]) {
            [m_delegate_homeTop onResponseHomeTopDataSuccess:l_arr_topImg];
        }
    }else{
        if ([(UIViewController*)m_delegate_homeTop respondsToSelector:@selector(onResponseHomeTopDataFail)]) {
            [m_delegate_homeTop onResponseHomeTopDataFail];
        }
    }
    m_request_homeTop=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestHomeTopDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_homeTop respondsToSelector:@selector(onResponseHomeTopDataFail)]) {
        [m_delegate_homeTop onResponseHomeTopDataFail];
    }
    m_request_homeTop=nil;
}

@end
