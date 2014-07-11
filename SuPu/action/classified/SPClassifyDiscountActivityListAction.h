//
//  SPClassifyDiscountActivityListAction.h
//  SuPu
//
//  Created by cc on 12-11-7.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseAction.h"
#import "SPDataWorld.h"
#import "ASIHTTPRequest.h"
#import "SPActionUtility.h"

//创建一个委托，委托将请求数据创建，数据返回后的响应的方法交给view层处理
@protocol SPClassifyDiscountActivityActionDelegate <NSObject>

- (NSDictionary *)createDiscountActivityASIRequestPara;//创建请求数据
- (void)responseDiscountActivityDataToViewSuccess:(NSArray *)resultarr;//成功响应请求并返回数据
- (void)responseDiscountActivityDataToViewFail;//返回数据失败
@end

#warning ------------------商品详情崩溃-----------------------

@interface SPClassifyDiscountActivityListAction : SPBaseAction

@property (nonatomic,assign) id<SPClassifyDiscountActivityActionDelegate> delegate;

- (void)requestData;//请求的方法

@end
