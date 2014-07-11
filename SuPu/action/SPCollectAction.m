//
//  SPCollectAction.m
//  SuPu
//
//  Created by xingyong on 13-6-6.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPCollectAction.h"
#import "GoodsObject.h"
@implementation SPCollectAction
@synthesize m_delegate_collect;

- (void)dealloc {
    m_delegate_collect=nil;
    [m_request_collect setUserInfo:nil];
    [m_request_collect clearDelegatesAndCancel];
    [m_request_collect release];m_request_collect=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	发出分类请求
 */
-(void)requestCollectListData{
   
//    
//    if (m_request_collect!=nil&&[m_request_collect isFinished]) {
//        return;
//    }
    NSMutableDictionary *l_dict = nil;
    if ([(UIViewController*)m_delegate_collect respondsToSelector:@selector(onRequestCollectAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_collect onRequestCollectAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETFAVORITES] forKey:SP_KEY_SIGN];
    m_request_collect=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETFAVORITES
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestCollectListDataFinishResponse:)
                                                  onFailedAction:@selector(onRequestCollectListDataFailResponse:)];
    
    [m_request_collect startAsynchronous];
}

/**
 *	@brief	请求完成
 *
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCollectListDataFinishResponse:(ASIHTTPRequest*)request{
     
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
     
    
    NSMutableArray *goodsArray = [NSMutableArray array];
    SPPageInfoData *pageData   = [[SPPageInfoData alloc] init];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSArray *t_array_data  = [[l_dict_response objectForKey:@"Data"] objectForKey:@"FavoritesList"];
        
        for (NSDictionary *t_dic_list in t_array_data) {
            GoodsObject *goods = [[[GoodsObject alloc] init] autorelease];
            
            NSDictionary *goodsDict = [t_dic_list objectForKey:@"Goods"];
            
            goods.AddTime       = [goodsDict objectForKey:@"AddTime"];
            goods.BrandID       = [goodsDict objectForKey:@"BrandID"];
            goods.CategoryID    = [goodsDict objectForKey:@"CategoryID"];
            goods.CommentCount  = [goodsDict objectForKey:@"CommentCount"];
            goods.GoodsName     = [goodsDict objectForKey:@"GoodsName"];
            goods.GoodsSN       = [goodsDict objectForKey:@"GoodsSN"];
            goods.GoodsScore    = [goodsDict objectForKey:@"GoodsScore"];
            goods.GoodsSort     = [goodsDict objectForKey:@"GoodsSort"];
            goods.ImgFile       = [goodsDict objectForKey:@"ImgFile"];
            goods.GoodsSlogan   = [goodsDict objectForKey:@"GoodsSlogan"];
            goods.IsNoStock     = [goodsDict objectForKey:@"IsNoStock"];
            goods.Integral      = [goodsDict objectForKey:@"Integral"];
            goods.MarketPrice   = [goodsDict objectForKey:@"MarketPrice"];
            goods.ShopPrice     = [goodsDict objectForKey:@"ShopPrice"];
            [goodsArray addObject:goods];
          
        }
        NSDictionary *pageDict = [[l_dict_response objectForKey:@"Data"] objectForKey:@"PageInfo"];

        pageData.mRecordCount = [pageDict objectForKey:@"RecordCount"];
 
        pageData.mPageArray = goodsArray;
  
        if ([(UIViewController*)m_delegate_collect respondsToSelector:@selector(onResponseCollectDataSuccess:)]) {
            [m_delegate_collect onResponseCollectDataSuccess:pageData];
        }
    }else{
        if ([(UIViewController*)m_delegate_collect respondsToSelector:@selector(onResponseCollectDataFail)]) {
            [m_delegate_collect onResponseCollectDataFail];
        }
    }
    m_request_collect=nil;
}

/**
 *	@brief	请求失败
 *
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestCollectListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_collect respondsToSelector:@selector(onResponseCollectDataFail)]) {
        [m_delegate_collect onResponseCollectDataFail];
    }
    m_request_collect = nil;
}

@end
