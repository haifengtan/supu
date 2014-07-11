//
//  SPClassifyGoodsDescriprionAction.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyGoodsDescriprionAction.h"

@implementation SPClassifyGoodsDescriprionAction
@synthesize delegate;

- (void)dealloc {
    delegate=nil;
    [m_request_classifyAction setUserInfo:nil];
    [m_request_classifyAction clearDelegatesAndCancel];
    [m_request_classifyAction release];m_request_classifyAction=nil;
    [super dealloc];
}

 

-(void)requestData
{
////////////////////////////
    if (m_request_classifyAction!=nil && [m_request_classifyAction isFinished]) return;
    
    NSMutableDictionary *l_requestparamdict;
    if ([delegate respondsToSelector:@selector(createGoodsDescriptionASIRequestPara)]) {
        l_requestparamdict=[NSMutableDictionary dictionaryWithDictionary:[delegate createGoodsDescriptionASIRequestPara]];
    }else{//有的请求是不需要提交参数的
        l_requestparamdict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //进行签名
    [l_requestparamdict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETGOODSDESCRIPTION] forKey:SP_KEY_SIGN];
    //请求
    m_request_classifyAction = [KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETGOODSDESCRIPTION
                                                 postParams:l_requestparamdict
                                                     object:self
                                           onFinishedAction:@selector(requestDataFinish:)
                                             onFailedAction:@selector(requestDataFail:)];
    
    [m_request_classifyAction startAsynchronous];
}

-(void)requestDataFinish:(ASIHTTPRequest*)request{
    NSString *l_response_str=[request responseString];
    
    NSDictionary *l_response_dict=[l_response_str objectFromJSONString];
    
    if ([SPActionUtility isRequestJSONSuccess:l_response_dict]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(responseGoodsDescriptionDataToViewSuccess:)]) {
            [self.delegate responseGoodsDescriptionDataToViewSuccess:l_response_dict];
        }

        
    }else{
        if ([delegate respondsToSelector:@selector(responseGoodsDescriptionDataToViewFail)]) {
            [delegate responseGoodsDescriptionDataToViewFail];
        }
    }
    m_request_classifyAction  = nil;
}

- (void)requestDataFail:(ASIHTTPRequest *)request{
    if ([delegate respondsToSelector:@selector(responseGoodsDescriptionDataToViewFail)]) {
        [delegate responseGoodsDescriptionDataToViewFail];
    }
    m_request_classifyAction = nil;
}

@end
