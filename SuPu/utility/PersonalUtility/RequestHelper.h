//
//  RequestHelper.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "ASIFormDataRequest.h"
#import "HeaderPara.h"

#define SIGN @"3B51ACFFC9244DC481CF9454E207429A"

@interface RequestHelper : NSObject

@property (assign) BOOL havememberid;
@property (retain,nonatomic) ASIFormDataRequest *m_request;

- (id)initWithUrl:(NSString *)url methodName:(NSString *)methodName memberid:(NSString *)memberid;

- (void)RequestUrl:(NSMutableDictionary *)valuedict succ:(SEL)succ fail:(SEL)fail responsedelegate:(id)responsedelegate;

@end
