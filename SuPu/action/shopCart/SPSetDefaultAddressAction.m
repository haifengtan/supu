//
//  SPSetDefaultAddressAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPSetDefaultAddressAction.h"

@implementation SPSetDefaultAddressAction
@synthesize m_delegate_setDefault;


-(void)requestAddressSetDefault{
//    if (m_request_setDefault!=nil && [m_request_setDefault isFinished]) {
//        return;
//    }
//    
//    NSDictionary *l_dict_request=[QMActionUtility getRequestAllDict:[m_delegate_setDefault onRequestAddressSetDefaultAction]];
//    m_request_setDefault=[[KDATAWORLD httpEngineQM] buildRequest:(NSString*)QM_URL_GET_SETDEFAULTADDRESS
//                                                      postParams:l_dict_request
//                                                          object:self
//                                                onFinishedAction:@selector(onRequestAddressSetDefaultFinishResponse:)
//                                                  onFailedAction:@selector(onRequestAddressSetDefaultFailResponse:)];
//    [m_request_setDefault startAsynchronous];
////////////////////////////
    if (m_request_setDefault!=nil&&[m_request_setDefault isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict;
    if (nil) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:nil];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GetDefaultConsignee] forKey:SP_KEY_SIGN];
    m_request_setDefault=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GetDefaultConsignee
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestAddressSetDefaultFinishResponse:)
                                                  onFailedAction:@selector(onRequestAddressSetDefaultFailResponse::)];
    
    [m_request_setDefault startAsynchronous];

}

-(void)onRequestAddressSetDefaultFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        NSDictionary* l_dict_result=[l_dict_response objectForKey:@"Data"];
        NSDictionary *detailsDic=[l_dict_result objectForKey:@"Consignee"];
        
        SPAddressListData *addressList=[[SPAddressListData alloc] init];
        
        if ([detailsDic isKindOfClass:[NSDictionary class]]&&[detailsDic allKeys].count != 0) {
            addressList.mAddress=[detailsDic objectForKey:@"Address"];
            addressList.mAddressInfo = [detailsDic objectForKey:@"AddressInfo"];
            addressList.mAreaId=[detailsDic objectForKey:@"AreaID"];
            addressList.mCityId=[detailsDic objectForKey:@"CityID"];
            addressList.mConsignee=[detailsDic objectForKey:@"Consignee"];
            addressList.mConsigneeID=[detailsDic objectForKey:@"ConsigneeID"];
            //            l_data_address.mEmail=[l_dict_address objectForKey:@"Email"];
            addressList.mTel=[detailsDic objectForKey:@"Tel"];
            addressList.mProvinceID=[detailsDic objectForKey:@"ProvinceID"];
            addressList.mZipCode=[detailsDic objectForKey:@"ZipCode"];
            addressList.mMobile=[detailsDic objectForKey:@"Mobile"];
        }
        
        if ([(UIViewController*)m_delegate_setDefault respondsToSelector:@selector(onResponseAddressSetDefaultSuccess:)]) {
            [m_delegate_setDefault onResponseAddressSetDefaultSuccess:addressList];
        }
        [addressList release];
        
    }else{
        
        if ([(UIViewController*)m_delegate_setDefault respondsToSelector:@selector(onResponseAddressSetDefaultFail)]) {
            [m_delegate_setDefault onResponseAddressSetDefaultFail];
        }
        
    }
    m_request_setDefault=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressSetDefaultFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_setDefault respondsToSelector:@selector(onResponseAddressSetDefaultFail)]) {
        [m_delegate_setDefault onResponseAddressSetDefaultFail];
    }
    m_request_setDefault=nil;
}
@end


