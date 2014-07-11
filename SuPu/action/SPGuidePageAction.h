//
//  SPGuidePageAction.h
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPGuidePageObject.h"
@protocol SPGuidePageActionDelegate
-(NSDictionary *)onRequestGuidePageAction;
-(void)onResponseGuidePageDataSuccess:(SPPage *)device_object;
-(void)onResponseGuidePageDataFail;

@end

@interface SPGuidePageAction : SPBaseAction{
    ASIHTTPRequest *m_request_orderList;
    id<SPGuidePageActionDelegate> m_delegate_orderList;
}

@property(nonatomic,assign)id<SPGuidePageActionDelegate> m_delegate_orderList;


-(void)requestGuidePageData;
-(void)onRequestGuidePageFinishResponse:(ASIHTTPRequest*)request;
-(void)onRequestGuidePageFailResponse:(ASIHTTPRequest*)request;

@end
