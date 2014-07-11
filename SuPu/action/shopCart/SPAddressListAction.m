//
//  SPAddressListAction.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressListAction.h"

@implementation SPAddressListAction

@synthesize m_delegate_addresslist;

- (void)dealloc {
    m_delegate_addresslist=nil;
    [m_request_addresslist setUserInfo:nil];
    [m_request_addresslist clearDelegatesAndCancel];
    [m_request_addresslist release];m_request_addresslist=nil;
    [super dealloc];
}

/**
 *	@brief	发出请求
 *
 *	请求地址列表数据
 */
-(void)requestAddressListData{
////////////////////////////
    if (m_request_addresslist!=nil&&[m_request_addresslist isFinished]) {
        return;
    }
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_addresslist respondsToSelector:@selector(onRequestAddressListDataAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_addresslist onRequestAddressListDataAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    [l_dict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETCONSIGNEELIST] forKey:SP_KEY_SIGN];
    
    m_request_addresslist=[[KDATAWORLD httpEngineSP] buildRequest:(NSString*)SP_URL_GETCONSIGNEELIST
                                                      postParams:l_dict
                                                          object:self
                                                onFinishedAction:@selector(onRequestAddressListDataFinishResponse:)
                                                  onFailedAction:@selector(onRequestAddressListDataFailResponse:)];
    [m_request_addresslist startAsynchronous];

}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressListDataFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        NSDictionary* l_dict_result=[l_dict_response objectForKey:@"Data"];
        NSArray *l_array_addresses=[l_dict_result objectForKey:@"Consigneelist"];
        
        
        NSMutableArray *l_array_addresslist=[NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *l_dict_address in l_array_addresses) {
            SPAddressListData *l_data_address=[[SPAddressListData alloc] init];
            l_data_address.mAddress=[l_dict_address objectForKey:@"Address"];
            l_data_address.mAreaId=[l_dict_address objectForKey:@"AreaID"];
            l_data_address.mCityId=[l_dict_address objectForKey:@"CityID"];
            l_data_address.mConsignee=[l_dict_address objectForKey:@"Consignee"];
            l_data_address.mConsigneeID=[l_dict_address objectForKey:@"ConsigneeID"];
            l_data_address.mEmail=[l_dict_address objectForKey:@"Email"];
            l_data_address.mTel=[l_dict_address objectForKey:@"Tel"];
            l_data_address.mProvinceID=[l_dict_address objectForKey:@"ProvinceID"];
            l_data_address.mZipCode=[l_dict_address objectForKey:@"ZipCode"];
            l_data_address.mMobile=[l_dict_address objectForKey:@"Mobile"];
            l_data_address.mIsDefault=[l_dict_address objectForKey:@"IsDefault"];
            l_data_address.mAddressInfo=[l_dict_address objectForKey:@"AddressInfo"];
            
            [l_array_addresslist addObject:l_data_address];
            [l_data_address release];
        }
        
        if ([(UIViewController*)m_delegate_addresslist respondsToSelector:@selector(onResponseAddressListDataSuccess:)]) {
            [m_delegate_addresslist onResponseAddressListDataSuccess:l_array_addresslist];
  
        }
    }else{
        
        if ([(UIViewController*)m_delegate_addresslist respondsToSelector:@selector(onResponseAddressListDataFail)]) {
            [m_delegate_addresslist onResponseAddressListDataFail];
        }
        
    }
    m_request_addresslist=nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestAddressListDataFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_addresslist respondsToSelector:@selector(onResponseAddressListDataFail)]) {
        [m_delegate_addresslist onResponseAddressListDataFail];
    }
    m_request_addresslist=nil;
}
@end