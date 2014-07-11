//
//  SPStatusUtility.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseData.h"

@interface SPStatusUtility : NSObject

+ (CGFloat)getScreenHeight; //得到屏幕高度
+ (CGFloat)getNavigationBarHeight;//返回导航栏高度

+ (CGFloat)getTabBarHeight;//返回tabbar高度

+ (CGFloat)getShowViewHeight;//返回可显示区域的高度

+ (CGFloat)getShowViewWidth;//根据硬件类型返回显示区域的宽度

+(void)showAlert:(NSString *)aTitle message:(NSString *)aMessage delegate:(id<UIAlertViewDelegate>)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;//显示alert

/**
 * 打电话
 */
+(void)makeCall:(NSString*)telnum;

+(BOOL)isUserLogin;

/**
 * 把从1970年到目标日期所经过的秒数（字符串类型）转换成年月日字符串
 *  示例：@"1336742480" -> @"2012-5-11"
 *
 * @param  intervalString  从1970年到目标日期所经过的秒数
 * @return      年月日字符串
 */
+ (NSString *)dateStringFromTimeInterval:(NSString *)intervalString;


+ (NSString *)dateStringFromTimeIntervalByFormatterString:(NSString *)intervalString formatterstring:(NSString *)formatterstring;


/**
 *	@brief	浏览记录
 *	
 *	保存浏览记录
 *
 *	@param 	l_data 	详情对象
 */
+(void)saveBrowerData:(SPBaseData*)l_data;

/**
 *	@brief	浏览记录
 *	
 *	删除浏览记录
 *
 *	@param 	l_data 	浏览记录对象
 */
+(void)deleteBrowerData:(SPBaseData*)l_data;

/**
 *	@brief	浏览记录
 *	
 *	加载所有浏览记录
 *
 *	@return	浏览记录数组
 */
+(NSArray*)loadAllBrowerData;

/**
 *	@brief	浏览记录
 *	
 *	清除浏览记录
 */
+(void)clearAllBrowerData;

/**
 *	@brief	图片内存缓存
 *
 *	清理图片缓存
 */
+(void)clearAllMermoryCache;

/**
 *	@brief	图片缓存
 *	
 *	清理图片缓存
 */
+(void)clearAllImgCache;

/**
 *	@brief	图片缓存
 *	
 *	是否清空缓存
 *
 *	@return	yes or no
 */
+(BOOL)isAllImgCacheClean;

/**
 *	@brief	列表图片展示
 *	
 *	设置列表图片是否展示
 *
 *	@param 	_isDisplay 	yes or no
 */
+(void)recordListImgDisplay:(BOOL)_isDisplay;

/**
 *	@brief	列表图片展示
 *	
 *	列表图片是否展示
 *
 *	@return	yes or no
 */
+(BOOL)isListImgDisplay;

/**
 *	@brief	判断当前的设备
 *
 *	@return	设备名称
 */
+ (NSString*)deviceString;

/**
 *	@brief	根据 key 存储数据
 *
 *
 *	@param 	key 	key
 */
+ (void)setObject:(id)value forKey:(NSString*)key;
 
/**
 *	@brief	根据ke 获取数据
 *
 *
 *	@param 	key 	key
 */
+(id)getObjectForKey:(NSString*)key;
 
/**
 *	@brief	根据key 移除内存的数据
 *
 *
 *	@param 	key 	key
 */
+(void)removeObjectForKey:(NSString*)key;


@end
