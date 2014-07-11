//
//  SPInvoiceListAction.m
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "SPInvoiceListAction.h"

@implementation SPInvoiceListAction

-(void)dealloc{
    self.delegate = nil;
    [_http_request setUserInfo:nil];
    [_http_request clearDelegatesAndCancel];
    [_http_request release];
    _http_request = nil;
    [super dealloc];
}

-(void)requestInvoiceList{
    if (_http_request!=nil && [_http_request isFinished]){
        return;
    }
    id params = @{SP_KEY_SIGN:[SPActionUtility createSignWithMethod:@"GetInvoiceInfos"]};
    _http_request =[[KDATAWORLD httpEngineSP] buildRequest:@"http://www.supuy.com/api/phone/GetInvoiceInfos" postParams:params object:self onFinishedAction:@selector(onRequestFinish:) onFailedAction:@selector(onRequestFail:)];
    [_http_request startAsynchronous];
                  
}
-(void)onRequestFinish:(ASIHTTPRequest *)request{
    NSString *response = [request responseString];
    NSDictionary *dict = [response objectFromJSONString];
    if ([SPActionUtility isRequestJSONSuccess:dict]){
        id data = dict[@"Data"];
        SPInvoiceList *list = [[SPInvoiceList alloc] init];
        list.items = [data[@"InvoiceList"] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1[@"Ordering"] intValue]-[obj2[@"Ordering"] intValue];
        }];
        if (self.delegate){
            [self.delegate onResponseInvoiceListSuccess:list];
        }
        [list release];
    }else{
        if (self.delegate){
            [self.delegate onResponseInvoiceListFail];
        }
    }
    _http_request =nil;
}
-(void)onRequestFail:(ASIHTTPRequest *)request{
    if (self.delegate){
        [self.delegate onResponseInvoiceListFail];
    }
    _http_request = nil;
}

@end


