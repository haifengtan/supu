//
//  NSString+OUOExtensions.h
//  OUOKit
//
//  Created by 杨福军 on 12-9-5.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OUOExtensions)

/**
 * 去掉字符串首尾所有的空格、换行符和制表符等
 */
- (NSString *)trimSpaces;
- (NSString *)trim:(NSString*)chars;

/**
 * 字符串是否被填充（去掉字符串首尾所有的空格、换行符和制表符等）
 */
- (BOOL)isEmpty;

@end
