//
//  SPClassifyGoodsConsultAction.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyGoodsConsultAction.h"
#import "SPGoodsConsult.h"
#import "PageingMessage.h"

@implementation SPClassifyGoodsConsultAction
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
    if ([delegate respondsToSelector:@selector(createGoodsConsultASIRequestPara)]) {
        l_requestparamdict=[NSMutableDictionary dictionaryWithDictionary:[delegate createGoodsConsultASIRequestPara]];
    }else{//有的请求是不需要提交参数的
        l_requestparamdict=[NSMutableDictionary dictionaryWithCapacity:1];
    }
    //进行签名
    [l_requestparamdict setObject:[SPActionUtility createSignWithMethod:(NSString*)SP_METHOD_GETGOODSCONSULT] forKey:SP_KEY_SIGN];
    //请求
    baseactionrequest=[KDATAWORLD.httpEngineSP buildRequest:(NSString*)SP_URL_GETGOODSCONSULT
                                                 postParams:l_requestparamdict
                                                     object:self
                                           onFinishedAction:@selector(requestDataFinish:)
                                             onFailedAction:@selector(requestDataFail:)];
    
    [baseactionrequest startAsynchronous];
}

-(void)requestDataFinish:(ASIHTTPRequest*)request{
    
    NSDictionary *l_response_dict=[request.responseString objectFromJSONString];
    
//    NSLog(@"商品咨询列表 -------------------- %@",l_response_dict);
    
    SPPageInfoData *pageInfo = [[SPPageInfoData alloc] init];
    
    if ([SPActionUtility isRequestJSONSuccess:l_response_dict]) {
        
        NSMutableArray *l_arr_data = [NSMutableArray array];
        
        NSArray *consultlist = [[l_response_dict objectForKey:@"Data"] objectForKey:@"ConsultList"];
        for (NSDictionary *consult in consultlist) {
            
            SPGoodsConsult *sc = [[SPGoodsConsult alloc] init];
            sc.ConsultId        = [[consult objectForKey:@"Consult"] objectForKey:@"Id"];
            sc.ConsultContent   = [[consult objectForKey:@"Consult"] objectForKey:@"ConsultContent"];
            sc.ConsultTime      = [[consult objectForKey:@"Consult"] objectForKey:@"ConsultTime"];
            sc.ReplyId          = [[consult objectForKey:@"Reply"] objectForKey:@"Id"];
            sc.ReplyContent     = [[consult objectForKey:@"Reply"] objectForKey:@"ReplyContent"];
            sc.ReplyTime        = [[consult objectForKey:@"Reply"] objectForKey:@"ReplyTime"];
            sc.Account          = [[[consult objectForKey:@"Member"] objectAtIndex:0] objectForKey:@"Account"];
            sc.LevelCode        = [[[consult objectForKey:@"Member"] objectAtIndex:0] objectForKey:@"LevelCode"];
            sc.ImageUrl         = [[[consult objectForKey:@"Member"] objectAtIndex:0] objectForKey:@"ImageUrl"];
            [l_arr_data addObject:sc];
            [sc release];
        }
        pageInfo.mPageArray = l_arr_data;
        NSDictionary *pageDict = [[l_response_dict objectForKey:@"Data"] objectForKey:@"PageInfo"];
        pageInfo.mRecordCount = [pageDict objectForKey:@"RecordCount"];
        
        if ([delegate respondsToSelector:@selector(responseGoodsConsultDataToViewSuccess:)]) {
            [delegate responseGoodsConsultDataToViewSuccess:pageInfo];
        }

        [pageInfo release];
        
    }else{
        if ([delegate respondsToSelector:@selector(responseGoodsConsultDataToViewFail)]) {
            [delegate responseGoodsConsultDataToViewFail];
        }
    }
    baseactionrequest = nil;
}

- (void)requestDataFail:(ASIHTTPRequest *)request{
    if ([delegate respondsToSelector:@selector(responseGoodsConsultDataToViewFail)]) {
        [delegate responseGoodsConsultDataToViewFail];
    }
    baseactionrequest = nil;
}

@end
