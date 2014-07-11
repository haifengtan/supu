//
//  SPActionUtility.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPActionUtility.h"
#import "SPGetAliPayDataAction.h"
#import "CCSStringUtility.h"
#import "SPStatusUtility.h"
#import <netinet/in.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/sysctl.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "SPConfig.h"
#import "SPResultData.h"
#import "AlixPayOrder.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "Member.h"
#import "NSString+URLEncoding.h"

@implementation SPActionUtility

+(void)userLogout{
    for (Member *l_data in [Member  allObjects]) {
        [l_data deleteObject];
    }
    [SPDataInterface setCommonParam:SP_KEY_MEMBERID value:@""];
 
}
+(void)recoverUserDataFromDB{
    Member *l_data=[[Member allObjects] objectAtIndex:0];
    DLog(@"用户 id ---------------- %@",l_data.mmemberId);
    [SPDataInterface setCommonParam:SP_KEY_MEMBERID value:l_data.mmemberId];
}

/**
 *	@brief	判断是否有网络
 *	@return	
 */
+(BOOL)isNetworkReachable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestJSONSuccess:(NSDictionary*)jsonDict{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    BOOL isSuccess = YES;
	if (jsonDict == nil) { // 网络错误
       
        if (![[self class] isNetworkReachable]){
            [SPStatusUtility showAlert:SP_DEFAULTTITLE 
                               message:@"网络连接失败，请确保设备已经连网" 
                              delegate:nil 
                     cancelButtonTitle:@"确定" 
                     otherButtonTitles:nil];
        }else{
            [SPStatusUtility showAlert:SP_DEFAULTTITLE 
                               message:@"网络连接失败，请稍后再试" 
                              delegate:nil 
                     cancelButtonTitle:@"确定" 
                     otherButtonTitles:nil];
        }
        isSuccess = NO;
	}else{
         
        SPResultData* _data = [[[SPResultData alloc] init] autorelease];
        
        _data.mErrorCode=[jsonDict objectForKey:@"ErrorCode"];
        _data.mMessage=[jsonDict objectForKey:@"Message"];
        
        if (![_data.mErrorCode isEqualToString:@"0"]) {
            
            [SPStatusUtility showAlert:SP_DEFAULTTITLE 
                               message:[NSString stringWithFormat:@"%@",_data.mMessage]
                              delegate:nil 
                     cancelButtonTitle:@"确定" 
                     otherButtonTitles:nil];
            isSuccess = NO;
        }
    }
    [pool release];
	return isSuccess;
}

/**
 *	@brief	签名
 *	
 *	方法名+userid+token
 *
 *	@param 	methodName 	方法名
 *
 *	@return	sign
 */
+(NSString*)createSignWithMethod:(NSString*)methodName{
    NSMutableString *l_str_noSign=[NSMutableString stringWithCapacity:0];
    
    NSString *l_str_memeberId=[SPDataInterface commonParam:SP_KEY_MEMBERID];
      
    [l_str_noSign appendFormat:@"%@%@%@",strOrEmpty(methodName),strOrEmpty([l_str_memeberId URLEncodedString]),SP_ACTION_TOKEN];
    
    return [CCSMD5(l_str_noSign) uppercaseString];
}


+(void)go2AlipayClientWithOrder:(NSString*)orderID orderAmount:(NSString*)orderMoney{
    /*
	 *商户的唯一的parnter和seller。
	 *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
	 */
	//如果partner和seller数据存于其他位置,请改写下面两行代码
	NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
	
	//partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。"
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	/*
	 *生成订单信息及签名
	 */
	//将商品信息赋予AlixPayOrder的成员变量
    
	AlixPayOrder *order = [[[AlixPayOrder alloc] init] autorelease];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = orderID; //订单ID（由商家自行制定）
	order.productName = @"素朴商城"; //商品标题
//	order.productDescription = @"卓越品质"; //商品描述
	order.amount =  orderMoney ;  //商品价格
	order.notifyURL = @"http://222.66.209.181:8889/mm/servlet/CallBack"; //回调URL
 
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
	NSString *appScheme = @"supu";
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	NSLog(@"orderSpec = %@",orderSpec);
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
 	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
     DLog(@"私钥 ----------  %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
     DLog(@"公钥 ----------  %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
 	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
 	if (signedString != nil) {
 		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                        orderSpec, signedString, @"RSA"];
 	}
    
//    SPGetAliPayDataAction *alipayAction = [[SPGetAliPayDataAction alloc] init];
//    [alipayAction requestData:SP_URL_GetAliPayData methodName:SP_METHOD_GetAliPayData createParaBlock:^NSDictionary *{
//        return [NSDictionary dictionaryWithObjectsAndKeys:orderID,@"OrderSN", nil];
//        
//    } requestSuccessBlock:^(id resultdict) {
 
        AlixPay * alixpay = [AlixPay shared];
//        NSString *orderString = [[resultdict objectForKey:@"Data"] objectForKey:@"AliPayData"];
//         
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝钱包的客户端，请先装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
            [alertView release];
        }
        else if (ret == kSPErrorSignError) {
            NSLog(@"签名错误！");
        }
        
        
//    } requestFailureBlock:^(ASIHTTPRequest *as) {
//        
//        
//    }];
    
}

+(NSURL*)getSPCategoryListImgURL:(NSString*)l_str{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.supuy.com/images/phonecategorys/%@",l_str]];
}
@end
