//
//  SPInvoiceListAction.h
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPInvoiceList.h"

@protocol SPInvoiceListActionDelegate <NSObject>

-(void)onResponseInvoiceListSuccess:(SPInvoiceList *)list;
-(void)onResponseInvoiceListFail;

@end
@interface SPInvoiceListAction : SPBaseAction{
    ASIHTTPRequest *_http_request;
    
}
@property (nonatomic,assign) id<SPInvoiceListActionDelegate> delegate;

-(void)requestInvoiceList;
-(void)onRequestFinish:(ASIHTTPRequest *)request;
-(void)onRequestFail:(ASIHTTPRequest *)request;
@end
