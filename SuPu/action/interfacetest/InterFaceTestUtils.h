//
//  InterFaceTestUtils.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "ASIFormDataRequest.h"
#import "RequestHeader.h"
#import "TestUrlPara.h"
#define TEST001_MEMBERID @"pg+z00vxiKsV1N3RVgIMpg=="

@interface InterFaceTestUtils : NSObject

+ (void)TestRequestUrl:(TestUrlPara *)testurlpara valuedict:(NSMutableDictionary *)valuedict;

+ (NSMutableDictionary *)getRequestHeaderDictionary;

+ (NSString *)md5With32:(NSString *)str;

+ (NSString *)md5With16:(NSString *)str;

+ (void)requestDataSucc:(ASIFormDataRequest *)request;

+ (void)requestDataFail:(ASIFormDataRequest *)request;

@end
