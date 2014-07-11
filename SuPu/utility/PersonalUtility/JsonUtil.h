//
//  JsonUtil.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"

@interface JsonUtil : NSObject

+ (id) fromSimpleObjectToSimpleJsonStr:(id)simpleObject;
+ (id) fromSimpleJsonStrToSimpleObject:(NSString *)simpleJsonStr className:(Class)className keyPath:(NSString *)keyPath keyPathDeep:(NSString *)keyPathDeep;
+ (id) fromSimpleJsonStrToSimpleObject1:(NSString *)simpleJsonStr className1:(Class)className keyPath1:(NSString *)keyPath keyPathDeep1:(NSString *)keyPathDeep;
@end
