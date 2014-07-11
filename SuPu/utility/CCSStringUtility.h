//
//  CCSStringUtility.h
//  QiMeiLady
//
//  Created by user on 11-7-8.
//  Copyright 2011 chichuang.com All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CCSStringUtility : NSObject {

}
/**
 安全获取字符串
 @param str 字符串
 @returns 若字符串为nil，则返回空字符串，否则直接返回字符串
 */
+(NSString*)strOrEmpty:(NSString*)str;
/**
 去掉首尾空格
 @param str 字符串
 @returns 去掉首尾空格的字符串
 */
+(NSString*)stripWhiteSpace:(NSString*)str;
/**
 去掉首尾空格和换行符
 @param str 字符串
 @returns 去掉首尾空格和换行符的字符串
 */
+(NSString*)stripWhiteSpaceAndNewLineCharacter:(NSString*)str;
/**
 将字符串转换为MD5码
 @param str 字符串
 @returns 已转码为MD5的字符串
 */
+(NSString*)CCSMD5:(NSString*)str;

/**
	判断字符串是否符合Email格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isEmail:(NSString *)input;

/**
	判断字符串是否符合手机号格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isPhoneNum:(NSString *)input;

//邮编
+(BOOL)isZipCode:(NSString *)input;

/**
	判断字符串是否符合电话格式。
	@param input 字符串
	@returns 布尔值 YES: 符合 NO: 不符合
 */
+(BOOL)isMobileNum:(NSString *)input;

+(BOOL)isPostNum:(NSString *)input;

/**
 根据指定的字体，和宽度计算字符串的高度
 @param input 字符串
 @param font  使用的字体
 @param width 宽度
 */
+(CGFloat)getStringHight:(NSString*)input font:(UIFont*)font width:(CGFloat)width;

/**
 根据指定字符串进行base64编码
 @param input 字符串
 */
+(NSString*)encodeBase64:(NSString*)input;

/**
 *	@brief	拼接字符串
 *	
 *	根据需要把字符串拼接成自己想要的字符串
 *
 *	@param 	parameters 	字符串字典
 *
 *	@return	字符串
 */
+ (NSString *)serializeGoodsStr:(NSMutableDictionary*)parameters;
+ (NSString *)serializeGoodsStr:(NSMutableDictionary*)parameters arithmetic:(NSString *)arith;

@end

/*
 如果字符串==nil 返回 @"" 否则返回 str
 */
extern BOOL stringIsEmpty(NSString* str);
extern NSString* strOrEmpty(NSString *str);
/*
 返回当前时间
 */
extern NSString* nowTimestamp(void);
extern NSString* CCSMD5( NSString *str );
extern NSString* stripWhiteSpace(NSString *str);

