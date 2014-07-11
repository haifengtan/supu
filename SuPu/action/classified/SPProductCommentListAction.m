//
//  SPProductCommentListAction.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductCommentListAction.h"

@implementation SPProductCommentListAction
@synthesize m_delegate_productCommentList;

- (void)dealloc {
    m_delegate_productCommentList=nil;
    [m_request_productCommentList setUserInfo:nil];
    [m_request_productCommentList clearDelegatesAndCancel];
    [m_request_productCommentList release];m_request_productCommentList=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出商品列表请求
 */
-(void)requestProductCommentListData{
////////////////////////////
    if (m_request_productCommentList!=nil&&[m_request_productCommentList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_productCommentList respondsToSelector:@selector(onResponseProductCommentListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_productCommentList onResponseProductCommentListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetProductCommentList] forKey:SP_KEY_SIGN];
    m_request_productCommentList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetProductCommentList
                                                     postParams:l_dict 
                                                         object:self 
                                               onFinishedAction:@selector(onRequestProductCommentListDataFinishResponse:) 
                                                 onFailedAction:@selector(onRequestProductCommentListDataFailResponse:)];
    
    [m_request_productCommentList startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductCommentListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    
    NSLog(@"购买评论 --------------- %@",l_dict_response);
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPProductCommentListData *l_data_productCommentList=[[SPProductCommentListData alloc] init];
        
        SPPageInfoData *l_data_pageInfo=[[SPPageInfoData alloc] init];
        NSDictionary *l_dict_pageInfo=[l_dict_data objectForKey:@"PageInfo"];
        l_data_pageInfo.mPageIndex=[l_dict_pageInfo objectForKey:@"PageIndex"];
        l_data_pageInfo.mPageSize=[l_dict_pageInfo objectForKey:@"PageSize"];
        l_data_pageInfo.mRecordCount=[l_dict_pageInfo objectForKey:@"RecordCount"];
        
        l_data_productCommentList.pageInfo=l_data_pageInfo;
        [l_data_pageInfo release];
        
        NSMutableArray *l_arr_comments=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_comment in [l_dict_data objectForKey:@"CommentList"]) {
            SPProductCommentData *l_data_item=[[SPProductCommentData alloc] init];
            
            NSDictionary *commentDic = [l_dict_comment objectForKey:@"Comment"];
            
            l_data_item.identifier   =  [commentDic objectForKey:@"Id"];
            l_data_item.time         =  [SPStatusUtility dateStringFromTimeInterval:[commentDic objectForKey:@"CommentTime"]];
            l_data_item.content      = [commentDic objectForKey:@"CommentContent"];
             l_data_item.goodsScore  = [commentDic objectForKey:@"GoodsScore"];
            
            Member *m = [[Member alloc] init];
            
            m.maccount = [[l_dict_comment objectForKey:@"Member"] objectForKey:@"Account"];
            m.mlevel = [[l_dict_comment objectForKey:@"Member"] objectForKey:@"LevelCode"];
            l_data_item.member = m;
            [m release];
            
            [l_arr_comments addObject:l_data_item];
            [l_data_item release];
        }
        l_data_productCommentList.comments=l_arr_comments;
        
        if ([(UIViewController*)m_delegate_productCommentList respondsToSelector:@selector(onResponseProductCommentListDataSuccess:)]) {
            [m_delegate_productCommentList onResponseProductCommentListDataSuccess:l_data_productCommentList];
           
        }
         [l_data_productCommentList release];
     
    }else{
        if ([(UIViewController*)m_delegate_productCommentList respondsToSelector:@selector(onResponseProductCommentListDataFail)]) {
            [m_delegate_productCommentList onResponseProductCommentListDataFail];
        }
    }
    m_request_productCommentList = nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductCommentListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_productCommentList respondsToSelector:@selector(onResponseProductCommentListDataFail)]) {
        [m_delegate_productCommentList onResponseProductCommentListDataFail];
    }
    m_request_productCommentList=nil;
}
@end
