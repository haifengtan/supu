//
//  SPGuidePageAction.m
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPGuidePageAction.h"

@implementation SPGuidePageAction
@synthesize m_delegate_orderList;

- (void)dealloc {
    m_delegate_orderList=nil;
    [m_request_orderList setUserInfo:nil];
    [m_request_orderList clearDelegatesAndCancel];
    [m_request_orderList release];m_request_orderList=nil;
    [super dealloc];
}

-(void)requestGuidePageData{
    //    if (![super isInternetWorking]) {
    //        return;
    //    }
    if (m_request_orderList!=nil&&[m_request_orderList isFinished]) {
        return;
    }
    
    NSMutableDictionary *l_dict=nil;
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onRequestGuidePageAction)]) {
        l_dict=[NSMutableDictionary dictionaryWithDictionary:[m_delegate_orderList onRequestGuidePageAction]];
    }else{
        l_dict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //签名
    [l_dict setObject:[SPActionUtility createSignWithMethod:@"GetBanner"] forKey:SP_KEY_SIGN];
    
    m_request_orderList=[KDATAWORLD.httpEngineSP buildRequest:@"http://www.supuy.com/api/phone/GetBanner"
                                                   postParams:l_dict
                                                       object:self
                                             onFinishedAction:@selector(onRequestGuidePageFinishResponse:)
                                               onFailedAction:@selector(onRequestGuidePageFailResponse:)];
    
    [m_request_orderList startAsynchronous];
}

-(void)onRequestGuidePageFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
//    NSLog(@"引导页的试图---------------- %@",l_dict_response);
    
    
    if ([SPActionUtility isRequestJSONSuccess:l_dict_response]) {
        SPPage *page = [[SPPage alloc] init];
        
        NSDictionary *l_dict_data=[l_dict_response objectForKey:@"Data"];
        NSArray *bannerList = [l_dict_data objectForKey:@"BannerList"];
        NSMutableArray *temp_array = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in bannerList) {
            SPGuidePageObject *guide = [[SPGuidePageObject alloc] init];
            guide.m_PicUrl = [dict objectForKey:@"PicUrl"];
            guide.m_BeginTime = [dict objectForKey:@"BeginTime"];
            guide.m_EndTime = [dict objectForKey:@"EndTime"];
            [temp_array addObject:guide];
            [guide release];
        }
        
        page.m_pageArray = temp_array;
         
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseGuidePageDataSuccess:)]) {
            [m_delegate_orderList onResponseGuidePageDataSuccess:page];
        }
        [page release];
        
        
    }else{
        if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseGuidePageDataFail)]) {
            [m_delegate_orderList onResponseGuidePageDataFail];
        }
    }
    
    m_request_orderList=nil;
    
}

-(void)onRequestGuidePageFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate_orderList respondsToSelector:@selector(onResponseGuidePageDataFail)]) {
        [m_delegate_orderList onResponseGuidePageDataFail];
    }
     m_request_orderList=nil;
}
@end
