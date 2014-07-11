//
//  SPAddCollectListAction.m
//  SuPu
//
//  Created by xx on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddCollectListAction.h"

@implementation SPAddCollectListAction
@synthesize m_delegate_addCollect;

- (void)dealloc {
    m_delegate_addCollect=nil;
    [m_request_addCollect setUserInfo:nil];
    [m_request_addCollect clearDelegatesAndCancel];
    OUOSafeRelease(m_request_addCollect);
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出加入收藏数据请求
 */
-(void)requestAddCollectList{
////////////////////////////
    if (m_request_addCollect!=nil&&[m_request_addCollect isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_addCollect respondsToSelector:@selector(onResponseAddCollectListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_addCollect onResponseAddCollectListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_AddFavorites] forKey:SP_KEY_SIGN];
    m_request_addCollect=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_AddFavorites 
                                                postParams:l_dict 
                                                    object:self 
                                          onFinishedAction:@selector(onRequestAddCollectListFinishResponse:) 
                                            onFailedAction:@selector(onRequestAddCollectListFailResponse:)];
    [m_request_addCollect startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddCollectListFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        if ([(UIViewController*)m_delegate_addCollect respondsToSelector:@selector(onResponseAddCollectListSuccess)]) {
            [m_delegate_addCollect onResponseAddCollectListSuccess];
        }
    }else{
        if ([(UIViewController*)m_delegate_addCollect respondsToSelector:@selector(onResponseAddCollectListFail)]) {
            [m_delegate_addCollect onResponseAddCollectListFail];
        }
    }
    m_request_addCollect=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddCollectListFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_addCollect respondsToSelector:@selector(onResponseAddCollectListFail)]) {
        [m_delegate_addCollect onResponseAddCollectListFail];
    }
    m_request_addCollect=nil;
}
@end
