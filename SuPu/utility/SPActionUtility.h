//
//  SPActionUtility.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPActionUtility : NSObject

/**
 *	@brief	从数据库中取数据
 *
 */
+(void)recoverUserDataFromDB ;
/**
 *	@brief	用户注销登陆
 *
 */
+(void)userLogout;
/**
 *	@brief	判断是否有网络
 *	@return	
 */
+(BOOL)isNetworkReachable;

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestJSONSuccess:(NSDictionary*)jsonDict;

/**
 *	@brief	签名
 *	
 *	方法名+userid+token
 *
 *	@param 	methodName 	方法名
 *
 *	@return	sign
 */
+(NSString*)createSignWithMethod:(NSString*)methodName;

/**
 *	@brief	跳转到支付宝
 *	
 *
 *	@param 	orderID 	订单号
 *	@param 	orderMoney 	订单价格
 */
+(void)go2AlipayClientWithOrder:(NSString*)orderID orderAmount:(NSString*)orderMoney;

+(NSURL*)getSPCategoryListImgURL:(NSString*)l_str;
@end
