//
//  SPClassifyGoodsConsultAction.h
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPDataWorld.h"
#import "ASIHTTPRequest.h"
#import "SPActionUtility.h"
#import "SPPageInfoData.h"

//创建一个委托，委托将请求数据创建，数据返回后的响应的方法交给view层处理
@protocol SPClassifyGoodsConsultActionDelegate <NSObject>

- (NSDictionary *)createGoodsConsultASIRequestPara;//创建请求数据
- (void)responseGoodsConsultDataToViewSuccess:(SPPageInfoData *)pageInfo;//成功响应请求并返回数据
- (void)responseGoodsConsultDataToViewFail;//返回数据失败
@end

@interface SPClassifyGoodsConsultAction : SPBaseAction

@property (nonatomic,assign) id<SPClassifyGoodsConsultActionDelegate> delegate;

- (void)requestData;//请求的方法

@end
