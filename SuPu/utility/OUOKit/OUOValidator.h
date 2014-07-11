//
//  OUOValidator.h
//  SportsTogether
//
//  Created by 杨福军 on 12-8-28.
//
//

#import "NSString+OUOExtensions.h"

@interface OUOValidator : NSObject

+ (BOOL)validateEmailAddress:(NSString *)input;

/**
 * 是否是有效的固定电话号码
 */
+ (BOOL)validatePhoneNumber:(NSString *)input;

/**
 * 是否是有效的移动电话号码
 */
+ (BOOL)validateMobilePhoneNumber:(NSString *)input;

/**
 * 检验目标字符串是否非空（长度为0，所有字符均为空格，换行符）
 */
+ (BOOL)validateNONEmptyString:(NSString *)string;
/**
 * 一组字符串里是否有空串
 */
+ (BOOL)validateNONEmptyStrings:(NSArray *)strings;

@end
