//
//  SPResultData.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPResultData : SPBaseData

@property(nonatomic,retain)NSString *mErrorCode;//服务器响应代码
@property(nonatomic,retain)NSString *mMessage;//服务器提示信息
@end
