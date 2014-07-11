//
//  SPArticleDetailAction.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPArticleDetailAction.h"

@implementation SPArticleDetailAction
@synthesize m_delegate_articleDetail;

- (void)dealloc {
    m_delegate_articleDetail=nil;
    [m_request_articleDetail setUserInfo:nil];
    [m_request_articleDetail clearDelegatesAndCancel];
    [m_request_articleDetail release];m_request_articleDetail=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出文章详情请求
 */
-(void)requestArticleDetailData{
////////////////////////////
    if (m_request_articleDetail!=nil&&[m_request_articleDetail isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_articleDetail respondsToSelector:@selector(onResponseArticleDetailDataAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_articleDetail onResponseArticleDetailDataAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetArticleInfo] forKey:SP_KEY_SIGN];
    m_request_articleDetail=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetArticleInfo 
                                                      postParams:l_dict 
                                                          object:self 
                                                onFinishedAction:@selector(onRequestArticleDetailDataFinishResponse:) 
                                                  onFailedAction:@selector(onRequestArticleDetailDataFailResponse:)];
    
    [m_request_articleDetail startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleDetailDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPArticleData *l_data_article=[[SPArticleData alloc] init];
        
        NSDictionary *l_dict_item=[l_dict_data objectForKey:@"Article"];
        SPArticleItemData *l_data_item=[[SPArticleItemData alloc] init];
        l_data_item.mID=[l_dict_item objectForKey:@"ID"];
        l_data_item.mCategoryID=[l_dict_item objectForKey:@"CategoryID"];
        l_data_item.mContent=[l_dict_item objectForKey:@"Content"];
        l_data_item.mModifyTime=[l_dict_item objectForKey:@"ModifyTime"];
        l_data_item.mTitle=[l_dict_item objectForKey:@"Title"];
        
        l_data_article.mArticle=l_data_item;
        [l_data_item release];
        
        NSMutableArray *l_arr_goods=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_good in [l_dict_data objectForKey:@"ArticleGoods"]) {
            SPArticleGoodData *l_data_good=[[SPArticleGoodData alloc] init];
            l_data_good.mGoodsSN=[l_dict_good objectForKey:@"GoodsSN"];
            l_data_good.mGoodsName=[l_dict_good objectForKey:@"GoodsName"];
            l_data_good.mGooodsIntro = [l_dict_good objectForKey:@"GoodsDescription"];
            l_data_good.mImgFile=[l_dict_good objectForKey:@"ImgFile"];
            l_data_good.mMarketPrice=[l_dict_good objectForKey:@"MarketPrice"];
            l_data_good.mPrice=[l_dict_good objectForKey:@"Price"];
            
            [l_arr_goods addObject:l_data_good];
            [l_data_good release];
        }
        l_data_article.mArticleGoodsArray=l_arr_goods;
        
        if ([(UIViewController*)m_delegate_articleDetail respondsToSelector:@selector(onResponseArticleDetailDataSuccess:)]) {
            [m_delegate_articleDetail onResponseArticleDetailDataSuccess:l_data_article];
        }
        [l_data_article release];
    }else{
        if ([(UIViewController*)m_delegate_articleDetail respondsToSelector:@selector(onResponseArticleDetailDataFail)]) {
            [m_delegate_articleDetail onResponseArticleDetailDataFail];
        }
    }
    m_request_articleDetail=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestArticleDetailDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_articleDetail respondsToSelector:@selector(onResponseArticleDetailDataFail)]) {
        [m_delegate_articleDetail onResponseArticleDetailDataFail];
    }
    m_request_articleDetail=nil;
}
@end
