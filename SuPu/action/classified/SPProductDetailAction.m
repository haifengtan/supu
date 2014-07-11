//
//  SPProductDetailAction.m
//  SuPu
//
//  Created by xx on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductDetailAction.h"

@implementation SPProductDetailAction
@synthesize m_delegate_productDetail;

- (void)dealloc {
    m_delegate_productDetail=nil;
    [m_request_productDetail setUserInfo:nil];
    [m_request_productDetail clearDelegatesAndCancel];
    [m_request_productDetail release];
    [super dealloc];
}

/**
 *	@brief	发出请求
 *	
 *	发出商品详情请求
 */
-(void)requestProductDetailData{
////////////////////////////
    if (m_request_productDetail!=nil&&[m_request_productDetail isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if ([(UIViewController*)m_delegate_productDetail respondsToSelector:@selector(onResponseProductDetailAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_productDetail onResponseProductDetailAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetGoodsDetails] forKey:SP_KEY_SIGN];
    m_request_productDetail=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetGoodsDetails 
                                                     postParams:l_dict 
                                                         object:self 
                                               onFinishedAction:@selector(onRequestProductDetailDataFinishResponse:) 
                                                 onFailedAction:@selector(onRequestProductDetailDataFailResponse:)];
    
    [m_request_productDetail startAsynchronous];
}

/**
 *	@brief	请求完成
 *	
 *	asi请求完成回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductDetailDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
//   
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        NSDictionary *l_dict_goods=[l_dict_data objectForKey:@"Goods"];
        
        SPProductDetailData *l_data_productDetail=[[SPProductDetailData alloc] init];
        l_data_productDetail.mBrandID=[l_dict_goods objectForKey:@"BrandID"];
        l_data_productDetail.mCategoryID=[l_dict_goods objectForKey:@"CategoryID"];
        l_data_productDetail.mCommentCount=[l_dict_goods objectForKey:@"CommentCount"];
        l_data_productDetail.mConsultCount=[l_dict_goods objectForKey:@"ConsultCount"];
        l_data_productDetail.mGoodsName=[l_dict_goods objectForKey:@"GoodsName"];
        l_data_productDetail.mGoodsScore=[l_dict_goods objectForKey:@"GoodsScore"];
        l_data_productDetail.mGoodsSlogan=[l_dict_goods objectForKey:@"GoodsSlogan"];
        l_data_productDetail.mGoodsSN=[l_dict_goods objectForKey:@"GoodsSN"];
        l_data_productDetail.mMarketPrice=[l_dict_goods objectForKey:@"MarketPrice"];
        l_data_productDetail.mShopPrice = [l_dict_goods objectForKey:@"ShopPrice"];
        l_data_productDetail.mShareText = [l_dict_goods objectForKey:@"ShareText"];
        l_data_productDetail.mIsNoStock = [l_dict_goods objectForKey:@"IsNoStock"];
        
        NSMutableArray *l_arr_goodsImg=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *l_dict_goodImg in [l_dict_goods objectForKey:@"GoodsImages"]) {
            SPProductGoodsImage *l_data_goodImg=[[SPProductGoodsImage alloc] init];
            l_data_goodImg.mImgFile=[l_dict_goodImg objectForKey:@"ImgFile"];
            l_data_goodImg.mSmallImgFile = [l_dict_goodImg objectForKey:@"SmallImgFile"];
            
//            l_data_goodImg.mName=OUO_STRING_FORMAT(@"%@%@", [l_dict_goodImg objectForKey:@"SmallImgFile"], [l_dict_goodImg objectForKey:@"Extension"]);
            
            [l_arr_goodsImg addObject:l_data_goodImg];
            [l_data_goodImg release];
        }
        l_data_productDetail.mGoodsImages=l_arr_goodsImg;
        
        if ([(UIViewController*)m_delegate_productDetail respondsToSelector:@selector(onResponseProductDetailDataSuccess:)]) {
            [m_delegate_productDetail onResponseProductDetailDataSuccess:l_data_productDetail];
        }
        [l_data_productDetail release];
    }else{
        if ([(UIViewController*)m_delegate_productDetail respondsToSelector:@selector(onResponseProductDetailDataFail)]) {
            [m_delegate_productDetail onResponseProductDetailDataFail];
        }
    }
    m_request_productDetail=nil;
}

/**
 *	@brief	请求失败
 *	
 *	asi请求失败回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestProductDetailDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_productDetail respondsToSelector:@selector(onResponseProductDetailDataFail)]) {
        [m_delegate_productDetail onResponseProductDetailDataFail];
    }
    m_request_productDetail=nil;
}
@end
