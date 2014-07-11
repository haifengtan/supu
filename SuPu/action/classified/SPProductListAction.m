//
//  SPProductListAction.m
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductListAction.h"

@implementation SPProductListAction
@synthesize m_delegate_productList;

- (void)dealloc {
    m_delegate_productList=nil;
    [m_request_productList setUserInfo:nil];
    [m_request_productList clearDelegatesAndCancel];
    [m_request_productList release];m_request_productList=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出商品列表请求
 */
-(void)requestProductListData{
////////////////////////////
    if (m_request_productList!=nil&&[m_request_productList isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict = nil;
    if ([(UIViewController*)m_delegate_productList respondsToSelector:@selector(onResponseProductListAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_productList onResponseProductListAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetProductList] forKey:SP_KEY_SIGN];
    m_request_productList=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetProductList 
                                                     postParams:l_dict 
                                                         object:self 
                                               onFinishedAction:@selector(onRequestProductListDataFinishResponse:) 
                                                 onFailedAction:@selector(onRequestProductListDataFailResponse:)];
    NSDictionary *l_userInfo=m_request_productList.userInfo;
    NSMutableDictionary *l_dict_userInfo=[NSMutableDictionary dictionaryWithDictionary:l_userInfo];
    [l_dict_userInfo setObject:(NSString*)SP_METHOD_GetProductList forKey:@"method"];
    [m_request_productList setUserInfo:l_dict_userInfo];
    [m_request_productList startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_method=[request.userInfo objectForKey:@"method"];
    if (!l_str_method||![l_str_method isEqualToString:(NSString*)SP_METHOD_GetProductList]) {
        return;
    }
    
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
//    DLog(@"l_dict_response ====== %@",l_dict_response);
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        
        SPProductListData *l_data_productList=[[SPProductListData alloc] init];
        
        SPPageInfoData *l_data_pageInfo=[[SPPageInfoData alloc] init];
        NSDictionary *l_dict_pageInfo=[l_dict_data objectForKey:@"PageInfo"];
        l_data_pageInfo.mPageIndex=[l_dict_pageInfo objectForKey:@"PageIndex"];
        l_data_pageInfo.mPageSize=[l_dict_pageInfo objectForKey:@"PageSize"];
        l_data_pageInfo.mRecordCount=[l_dict_pageInfo objectForKey:@"RecordCount"];
        
        l_data_productList.mpageInfo=l_data_pageInfo;
        [l_data_pageInfo release];
        
        NSMutableArray *l_arr_goods=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_good in [l_dict_data objectForKey:@"GoodsList"]) {
            SPProductListGoodData *l_data_item=[[SPProductListGoodData alloc] init];
            l_data_item.mAddTime=[l_dict_good objectForKey:@"AddTime"];
            l_data_item.mBrandID=[l_dict_good objectForKey:@"BrandID"];
            l_data_item.mCategoryID=[l_dict_good objectForKey:@"CategoryID"];
            l_data_item.mCommentCount=[l_dict_good objectForKey:@"CommentCount"];
            l_data_item.mGoodsName=[l_dict_good objectForKey:@"GoodsName"];
            l_data_item.mGoodsScore=[l_dict_good objectForKey:@"GoodsScore"];
            l_data_item.mGoodsSlogan=[l_dict_good objectForKey:@"GoodsSlogan"];
            l_data_item.mGoodsSN=[l_dict_good objectForKey:@"GoodsSN"];
            l_data_item.mGoodsSort=[l_dict_good objectForKey:@"GoodsSort"];
            l_data_item.mImgFile=[l_dict_good objectForKey:@"ImgFile"];
            l_data_item.mIntegral=[l_dict_good objectForKey:@"Integral"];
            l_data_item.mShopPrice=[l_dict_good objectForKey:@"ShopPrice"];
            l_data_item.mMarketPrice=[l_dict_good objectForKey:@"MarketPrice"];
            l_data_item.mIsNoStock=[l_dict_good objectForKey:@"IsNoStock"];
            
            [l_arr_goods addObject:l_data_item];
            [l_data_item release];
        }
        l_data_productList.mGoodsListArray=l_arr_goods;
        
        if ([(UIViewController*)m_delegate_productList respondsToSelector:@selector(onResponseProductListDataSuccess:)]) {
            [m_delegate_productList onResponseProductListDataSuccess:l_data_productList];
        }
        [l_data_productList release];
    }else{
        if ([(UIViewController*)m_delegate_productList respondsToSelector:@selector(onResponseProductListDataFail)]) {
            [m_delegate_productList onResponseProductListDataFail];
        }
    }
    m_request_productList=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_productList respondsToSelector:@selector(onResponseProductListDataFail)]) {
        [m_delegate_productList onResponseProductListDataFail];
    }
    m_request_productList=nil;
}
@end
