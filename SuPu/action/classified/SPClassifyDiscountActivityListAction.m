//
//  SPClassifyDiscountActivityListAction.m
//  SuPu
//
//  Created by cc on 12-11-7.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyDiscountActivityListAction.h"
#import "SPDiscountActivity.h"

@implementation SPClassifyDiscountActivityListAction
@synthesize delegate;

- (void)dealloc
{
    delegate = nil;
    [super dealloc];
}

-(void)requestData
{
////////////////////////////
    if (baseactionrequest!=nil && [baseactionrequest isFinished]) return;
    
    NSMutableDictionary *l_requestparamdict;
    if ([delegate respondsToSelector:@selector(createDiscountActivityASIRequestPara)]) {
        l_requestparamdict=[NSMutableDictionary dictionaryWithDictionary:[delegate createDiscountActivityASIRequestPara]];
    }else{//有的请求是不需要提交参数的
        l_requestparamdict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //进行签名
    [l_requestparamdict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETGOODSACTIVITIES] forKey:SP_KEY_SIGN];
    //请求
    baseactionrequest=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETGOODSACTIVITIES
                                       postParams:l_requestparamdict
                                           object:self
                                 onFinishedAction:@selector(requestDataFinish:)
                                   onFailedAction:@selector(requestDataFail:)];
    
    [baseactionrequest startAsynchronous];
}

-(void)requestDataFinish:(ASIHTTPRequest*)request{
    NSString *l_response_str=[request responseString];
    
    NSDictionary *l_response_dict=[l_response_str objectFromJSONString];
    if ([SPActionUtility isRequestJSONSuccess:l_response_dict]) {
        if (delegate!=nil && [delegate respondsToSelector:@selector(responseDiscountActivityDataToViewSuccess:)]) {
            //对数据进行处理
            NSArray *discountactivityarr = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[SPDiscountActivity class] keyPath:@"Data.ActivityList" keyPathDeep:nil];
            //将处理完的数据结果通过委托返回给view层进行处理
            [delegate responseDiscountActivityDataToViewSuccess:discountactivityarr];
        }
    }else{
        if (delegate!=nil && [delegate respondsToSelector:@selector(responseDiscountActivityDataToViewFail)]) {
            [delegate responseDiscountActivityDataToViewFail];
        }
    }
    baseactionrequest = nil;
}

- (void)requestDataFail:(ASIHTTPRequest *)request{
    if ([delegate respondsToSelector:@selector(responseDiscountActivityDataToViewFail)]) {
        [delegate responseDiscountActivityDataToViewFail];
    }
    baseactionrequest = nil;
}

@end
