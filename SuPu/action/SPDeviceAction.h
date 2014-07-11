//
//  SPDeviceAction.h
//  SuPu
//
//  Created by 持创 on 13-3-28.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPDeviceObject.h"
@protocol SSPDeviceActionDelegate
-(NSDictionary *)onRequestDeviceAction;
-(void)onResponseDeviceDataSuccess:(SPDeviceObject *)device_object;
-(void)onResponseDeviceDataFail;

@end

@interface SPDeviceAction : SPBaseAction{
    ASIHTTPRequest *m_request_orderList;
    id<SSPDeviceActionDelegate> m_delegate_orderList;
}

@property(nonatomic,assign)id<SSPDeviceActionDelegate> m_delegate_orderList;


-(void)requestPersonalInfomationData;
-(void)onRequestDeviceDataFinishResponse:(ASIHTTPRequest*)request;
-(void)onRequestDeviceDataFailResponse:(ASIHTTPRequest*)request;
@end
