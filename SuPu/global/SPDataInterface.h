//
//  SPDataInterface.h
//  SuPu
//
//  Created by xx on 12-9-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#import <Foundation/Foundation.h>

/**
 请求的URL
 */
extern const NSString *SP_URL_LOGIN;                    //登陆
extern const NSString *SP_METHOD_LOGIN;                 
extern const NSString *SP_URL_REGISTER;                 //注册
extern const NSString *SP_METHOD_REGISTER;
extern const NSString *SP_URL_GETMEMBERTOPGOODS;                 //获得会员中心推荐商品
extern const NSString *SP_METHOD_GETMEMBERTOPGOODS;
extern const NSString *SP_URL_GETORDERLIST;                 //订单详情
extern const NSString *SP_METHOD_GETORDERLIST;
extern const NSString *SP_URL_GETORDER;                 //订单详细信息
extern const NSString *SP_METHOD_GETORDER;
extern const NSString *SP_URL_GETORDERPROCESSINFORMATION;                 //物流查询
extern const NSString *SP_METHOD_GETORDERPROCESSINFORMATION;
extern const NSString *SP_URL_GETFAVORITES;                 //收藏列表
extern const NSString *SP_METHOD_GETFAVORITES;
extern const NSString *SP_URL_REMOVEFAVORITES;                 //删除收藏
extern const NSString *SP_METHOD_REMOVEFAVORITES;
extern const NSString *SP_URL_GETUSERMESSAGE;                 //用户信息列表
extern const NSString *SP_METHOD_GETUSERMESSAGE;
extern const NSString *SP_URL_USERMESSAGETOREAD;                 //更新信息状态
extern const NSString *SP_METHOD_USERMESSAGETOREAD;
extern const NSString *SP_URL_GETTICKETLIST;                 //优惠劵列表
extern const NSString *SP_METHOD_GETTICKETLIST;
extern const NSString *SP_URL_GETTICKET;                 //优惠劵详细
extern const NSString *SP_METHOD_GETTICKET;
extern const NSString *SP_URL_BINDTICKET;                 //添加优惠劵
extern const NSString *SP_METHOD_BINDTICKET;

extern const NSString *SP_URL_GETCONSIGNEELIST ; //地址列表
extern const NSString *SP_METHOD_GETCONSIGNEELIST ;
extern const NSString *SP_URL_GETALLDISTRICT ;   //获取全部城市列表
extern const NSString *SP_METHOD_GETALLDISTRICT ;

extern const NSString *SP_URL_GETABOUTUS; //关于我们
extern const NSString *SP_METHOD_GETABOUTUS;
extern const NSString *SP_URL_POSTFEEDBACK; //提交建议
extern const NSString *SP_METHOD_POSTFEEDBACK;
extern const NSString *SP_URL_UPDATE; //获取版本信息
extern const NSString *SP_METHOD_UPDATE;

extern const NSString *SP_URL_GETINDEXTOPGOODS;            //首页优惠信息
extern const NSString *SP_METHOD_GETINDEXTOPGOODS;
extern const NSString *SP_URL_GETINDEXTOPIMG;            //首页top焦点图
extern const NSString *SP_METHOD_GETINDEXTOPIMG;
extern const NSString *SP_URL_GETSHOPPINGCART;            //购物车
extern const NSString *SP_METHOD_GETSHOPPINGCART;
extern const NSString *SP_URL_GetArticleCategoryList;            //文章分类列表
extern const NSString *SP_METHOD_GetArticleCategoryList;
extern const NSString *SP_URL_GetArticleList;            //文章列表
extern const NSString *SP_METHOD_GetArticleList;
extern const NSString *SP_URL_GetArticleInfo;            //文章详细
extern const NSString *SP_METHOD_GetArticleInfo;
extern const NSString *SP_URL_GetCategoryList;            //分类列表
extern const NSString *SP_METHOD_GetCategoryList;
extern const NSString *SP_URL_GetBrandList;            //品牌列表
extern const NSString *SP_METHOD_GetBrandList;
extern const NSString *SP_URL_GetProductList;            //商品列表
extern const NSString *SP_METHOD_GetProductList;
extern const NSString *SP_URL_GetGoodsDetails;            //商品详情
extern const NSString *SP_METHOD_GetGoodsDetails;
extern const NSString *SP_URL_GETGOODSACTIVITIES;            //获取活动信息
extern const NSString *SP_METHOD_GETGOODSACTIVITIES;
extern const NSString *SP_URL_GETGOODSDESCRIPTION;            //获取商品详情
extern const NSString *SP_METHOD_GETGOODSDESCRIPTION;
extern const NSString *SP_URL_GETGOODSCONSULT;            //获取商品咨询列表
extern const NSString *SP_METHOD_GETGOODSCONSULT;
extern const NSString *SP_URL_GETACTIVITY;            //获取活动详细信息
extern const NSString *SP_METHOD_GETACTIVITY;

extern const NSString *SP_METHOD_AddOrMoidfyConsignee;  //添加和修改地址
extern const NSString *SP_URL_AddOrMoidfyConsignee;

extern const NSString *SP_URL_GetDefaultConsignee;    //设置默认收货地址
extern const NSString *SP_METHOD_GetDefaultConsignee;

extern const NSString *SP_URL_GETSHIPPINGFEE;    //获得运费
extern const NSString *SP_METHOD_GETSHIPPINGFEE;

extern const NSString *SP_URL_MODIFYSHOPPINGCART; //修改购物车
extern const NSString *SP_METHOD_MODIFYSHOPPINGCART;

extern const NSString *SP_URL_SUBMITORDER;  // 提交订单
extern const NSString *SP_METHOD_SUBMITORDER;

extern const NSString *SP_URL_GetPaymentShipping;   //获取支付方式，和送货方式
extern const NSString *SP_METHOD_GetPaymentShipping;

extern const NSString *SP_METHOD_DeleteConsignee; //删除收货地址
extern const NSString *SP_URL_DeleteConsignee;

extern const NSString *SP_URL_GetProductCommentList;            //商品列表
extern const NSString *SP_METHOD_GetProductCommentList;

extern const NSString *SP_URL_GetScreeningInfo;            //筛选数据列表
extern const NSString *SP_METHOD_GetScreeningInfo;

extern const NSString *SP_URL_GetActivity;            //活动详情
extern const NSString *SP_METHOD_GetActivity;

extern const NSString *SP_URL_AddFavorites;            //加入收藏
extern const NSString *SP_METHOD_AddFavorites;

extern const NSString *SP_URL_GETORDERSUCCESS;//提交订单成功后查询订单的提示信息
extern const NSString *SP_METHOD_GETORDERSUCCESS;

extern const NSString *SP_URL_GetUPPayData;
extern const NSString *SP_METHOD_GetUPPayData;  //网银支付成功返回的数据

extern const NSString *SP_URL_GetAliPayData;
extern const NSString *SP_METHOD_GetAliPayData;  //支付宝接口

extern const NSString *SP_URL_GETMEMBERINFO;//获取会员信息
extern const NSString *SP_METHOD_GETMEMBERINFO;

extern const NSString *SP_URL_GETTICKETINFO;//获取优惠劵可用信息
extern const NSString *SP_METHOD_GETTICKETINFO;

extern const NSString *SP_URL_PUSH;//推送
extern const NSString *SP_METHOD_PUSH;

extern const NSString *SP_URL_GetPushMessage;
extern const NSString *SP_METHOD_GetPushMessage;

extern const NSString *SP_URL_iPhonePush;
extern const NSString *SP_METHOD_iPhonePush;


//extern const NSString *SP_URL_GetTicketInfo;
//extern const NSString *SP_METHOD_GetTicketInfo;
/**
 公用字段
 参数名称	参数类型	是否为空	说明	请求方式
 MemberId	c	Y	用户ID	Httpheader中
 Platform	c	N	客户端类型（iphone r android）	Httpheader中
 Udid	c	Y	设备号，symbian和android有可能返回的是imei。	Httpheader中
 PhoneModel	c	Y	手机型号	HttpHeader中
 Imsi	c	Y	手机sim卡标示	HttpHeader中
 Imei	c	N	手机硬件识别号	httpHeader中
 Source	c	N	客户端来源标识	HttpHeader中
 Language	c	Y	语言	HttpHeader中
 Operator	c	Y	运营商信息	HttpHeader中
 SmsNumber	c	Y	短信中心号码	HttpHeader中
 ScreenSize	c	N	屏幕分辨率320x480	HttpHeader中
 ApiVersion	c  	N	接口版本号1.0/2.0	HttpHeader中
 ClientVersion	c	N	客户端版本号	HttpHeader中
 */
extern const NSString* CCS_KEY_DEVICETOKEN;
extern const NSString* CCS_KEY_APPKEY;					// 软件身份Key
extern const NSString* CCS_VALUE_APPKEY;				// 软件身份Key
extern const NSString* CCS_KEY_VERSION_NO;				//  软件版本
extern const NSString* CCS_VALUE_VERSION_NO;			//  软件版本
extern const NSString* CCS_KEY_SESSION_ID;				//  API GATEWAY负责为每个运行客户端的终端分配一个session_id，生命期为永久有效，作为未登陆用户的标识。 
extern const NSString* CCS_VALUE_SESSION_ID;			// API GATEWAY负责为每个运行客户端的终端分配一个session_id，生命期为永久有效，作为未登陆用户的标识。 
extern const NSString* CCS_KEY_PLATFORM;				// 客户端平台名称
extern const NSString* CCS_VALUE_PLATFORM;				// 客户端平台名称
extern const NSString* CCS_KEY_AUTH_TYPE;				// 加密格式	md5
extern const NSString* CCS_VALUE_AUTH_TYPE; 	        // 加密格式	md5
extern const NSString* CCS_KEY_AUTH_TYPESHA;//加密各式 sha
extern const NSString* CCS_KEY_OS_VER;					// 客户端系统版本
extern const NSString* CCS_VALUE_OS_VER;				// 客户端系统版本
extern const NSString* CCS_KEY_UD_ID;					// 设备号
extern const NSString* CCS_VALUE_UD_ID;					// 设备号
extern const NSString* CCS_KEY_IOS_APNSTOKEN;			// 用于IOS系统的Push机制，其他平台可为空 
extern const NSString* CCS_VALUE_IOS_APNSTOKEN;         // 用于IOS系统的Push机制，其他平台可为空 
extern const NSString* CCS_KEY_CLIENT_VER;				// APP客户端版本号 
extern const NSString* CCS_VALUE_CLIENT_VER;			// APP客户端版本号 
extern const NSString* CCS_KEY_CONTENT_TYPE;			// 返回的数据格式
extern const NSString* CCS_VALUE_CONTENT_TYPE;			// 返回的数据格式
extern const NSString* CCS_KEY_DEVICE_NAME;				// 手机设备型号
extern const NSString* CCS_VALUE_DEVICE_NAME;			// 手机设备型号
extern const NSString* CCS_KEY_IMSI;					// 手机sim卡标示 
extern const NSString* CCS_VALUE_IMSI;                  // 手机sim卡标示 
extern const NSString* CCS_KEY_SOURCE_ID;				// 客户端推广渠道来源标识 
extern const NSString* CCS_VALUE_SOURCE_ID;				// 客户端推广渠道来源标识 
extern const NSString* CCS_KEY_LANGUAGE;				// APP语言版本 
extern const NSString* CCS_VALUE_LANGUAGE;				// APP语言版本 
extern const NSString* CCS_KEY_CARRIER;					// 运营商信息  
extern const NSString* CCS_VALUE_CARRIER;				// 运营商信息 
extern const NSString* CCS_KEY_SMS_CENTER_NUMBER;		// 短信中心号码  
extern const NSString* CCS_VALUE_SMS_CENTER_NUMBER;		// 短信中心号码   
extern const NSString* CCS_KEY_WANTYPE;		// 网络连接类型：Wifi、3G，等  
extern const NSString* CCS_VALUE_WANTYPE;				// 网络连接类型：Wifi、3G，等
extern const NSString* CCS_KEY_SCREENSIZE;              //屏幕分辨率
extern const NSString* CCS_VALUE_SCREENSIZE;            //屏幕分辨率

extern const NSString* SP_KEY_MEMBERID;                //用户ID
extern const NSString* SP_KEY_SIGN;                    //签名

@interface SPDataInterface : NSObject

+(void) initialize;
+(void)initializeCommonParams;
+(void) setCommonParam:(id)key value:(id)value;
+(id) commonParam:(id) key;
+(NSMutableDictionary *)commonParams;
+(void)walkDataInterface;
+(NSString *)getScreenSize;
@end
