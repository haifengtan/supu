//
//  SPDataInterface.m
//  SuPu
//
//  Created by xx on 12-9-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPDataInterface.h"
/**
 请求的URL
 */
const NSString *SP_URL_LOGIN = @"http://www.supuy.com/api/phone/Login";                 //登陆
//const NSString *SP_URL_LOGIN = @"http://123.234.70.98:8012/api/phone/Login";                 //登陆
const NSString *SP_METHOD_LOGIN = @"Login";
const NSString *SP_URL_REGISTER = @"http://www.supuy.com/api/phone/Register";           //注册
const NSString *SP_METHOD_REGISTER = @"Register";
const NSString *SP_URL_GETMEMBERTOPGOODS = @"http://www.supuy.com/PhoneApi/GetMemberTopGoods";//会员中心推荐商品
const NSString *SP_METHOD_GETMEMBERTOPGOODS = @"GetMemberTopGoods";
const NSString *SP_URL_GetDefaultConsignee = @"http://www.supuy.com/api/phone/GetDefaultConsignee";     //设置默认收货地址
const NSString *SP_METHOD_GetDefaultConsignee= @"GetDefaultConsignee";
const NSString *SP_URL_GETORDER = @"http://www.supuy.com/api/phone/GetOrder";     //订单详细信息
//const NSString *SP_URL_GETORDER = @"http://123.234.70.98:8012/api/phone/GetOrder";     //订单详细信息
const NSString *SP_METHOD_GETORDER = @"GetOrder";
const NSString *SP_URL_GETORDERPROCESSINFORMATION = @"http://www.supuy.com/api/phone/GetOrderProcessInformation";//物流查询
const NSString *SP_METHOD_GETORDERPROCESSINFORMATION = @"GetOrderProcessInformation";
const NSString *SP_URL_GETFAVORITES = @"http://www.supuy.com/api/phone/GetFavorites";  //收藏列表
const NSString *SP_METHOD_GETFAVORITES = @"GetFavorites";
const NSString *SP_URL_GETUSERMESSAGE = @"http://www.supuy.com/api/phone/GetUserMessage";//用户信息列表
const NSString *SP_METHOD_GETUSERMESSAGE = @"GetUserMessage";
const NSString *SP_URL_USERMESSAGETOREAD = @"http://www.supuy.com/api/phone/UserMessageToRead";//更新信息状态
const NSString *SP_METHOD_USERMESSAGETOREAD = @"UserMessageToRead";
const NSString *SP_URL_REMOVEFAVORITES = @"http://www.supuy.com/api/phone/RemoveFavorites";//删除收藏
const NSString *SP_METHOD_REMOVEFAVORITES =@"RemoveFavorites";
const NSString *SP_URL_GETTICKETLIST = @"http://www.supuy.com/api/phone/GetTicketList";//优惠劵列表
const NSString *SP_METHOD_GETTICKETLIST = @"GetTicketList";

const NSString *SP_URL_GETINVOICELIST = @"http://www.supuy.com/api/phone/GetInvoiceInfos";//发票列表
const NSString *SP_METHOD_GETINVOICELIST = @"GetInvoiceInfos";



const NSString *SP_URL_GETTICKET = @"http://www.supuy.com/api/phone/GetTicket";                 //优惠劵详细
const NSString *SP_METHOD_GETTICKET = @"GetTicket";
const NSString *SP_URL_BINDTICKET = @"http://www.supuy.com/api/phone/BindTicket";                 //添加优惠劵
const NSString *SP_METHOD_BINDTICKET = @"BindTicket";
const NSString *SP_URL_GETCONSIGNEELIST = @"http://www.supuy.com/api/phone/GetConsigneeList"; //地址列表
const NSString *SP_METHOD_GETCONSIGNEELIST = @"GetConsigneeList";
const NSString *SP_URL_GETALLDISTRICT=@"http://www.supuy.com/api/phone/GetAllDistrict";   //获取全部城市列表
const NSString *SP_METHOD_GETALLDISTRICT=@"GetAllDistrict";
const NSString *SP_METHOD_AddOrMoidfyConsignee=@"AddOrMoidfyConsignee"; //添加和修改地址
const NSString *SP_URL_AddOrMoidfyConsignee=@"http://www.supuy.com/api/phone/AddOrMoidfyConsignee";

const NSString *SP_METHOD_DeleteConsignee=@"DeleteConsignee"; //删除收货地址
const NSString *SP_URL_DeleteConsignee=@"http://www.supuy.com/api/phone/DeleteConsignee";
const NSString *SP_URL_GETACTIVITY = @"http://www.supuy.com/api/phone/GetActivity";//获取活动详细信息
const NSString *SP_METHOD_GETACTIVITY = @"GetActivity";
const NSString *SP_URL_GETSHIPPINGFEE = @"http://www.supuy.com/api/phone/GetShippingFee";    //获得运费
const NSString *SP_METHOD_GETSHIPPINGFEE = @"GetShippingFee";




const NSString *SP_URL_GETABOUTUS = @"http://www.supuy.com/PhoneApi/GetAboutUs"; //关于我们
const NSString *SP_METHOD_GETABOUTUS = @"GetAboutUs";
const NSString *SP_URL_POSTFEEDBACK = @"http://www.supuy.com/PhoneApi/PostFeedBack"; //提交建议
const NSString *SP_METHOD_POSTFEEDBACK = @"PostFeedBack";
const NSString *SP_URL_UPDATE = @"http://www.supuy.com/PhoneApi/Update"; //获取版本信息
const NSString *SP_METHOD_UPDATE = @"Update";

const NSString *SP_URL_GETINDEXTOPGOODS=@"http://www.supuy.com/PhoneApi/GetIndexTopGoods";    //首页优惠信息
const NSString *SP_METHOD_GETINDEXTOPGOODS=@"GetIndexTopGoods";
const NSString *SP_URL_GETINDEXTOPIMG=@"http://www.supuy.com/PhoneApi/GetPicList";            //首页top焦点图
const NSString *SP_METHOD_GETINDEXTOPIMG=@"GetPicList";
const NSString *SP_URL_GETSHOPPINGCART=@"http://www.supuy.com/api/phone/GetShoppingCart";            //购物车
const NSString *SP_METHOD_GETSHOPPINGCART=@"GetShoppingCart";
const NSString *SP_URL_GetArticleCategoryList=@"http://www.supuy.com/PhoneApi/GetArticleCategoryList";            //文章分类列表
const NSString *SP_METHOD_GetArticleCategoryList=@"GetArticleCategoryList";
const NSString *SP_URL_GetArticleList=@"http://www.supuy.com/PhoneApi/GetArticleList";;            //文章列表
const NSString *SP_METHOD_GetArticleList=@"GetArticleList";
const NSString *SP_URL_GetArticleInfo=@"http://www.supuy.com/PhoneApi/GetArticleInfo";;            //文章详细
const NSString *SP_METHOD_GetArticleInfo=@"GetArticleInfo";
const NSString *SP_URL_GetCategoryList=@"http://www.supuy.com/api/phone/GetCategoryList";            //分类列表
const NSString *SP_METHOD_GetCategoryList=@"GetCategoryList";
const NSString *SP_URL_GetBrandList=@"http://www.supuy.com/api/phone/GetBrandList";            //品牌列表
const NSString *SP_METHOD_GetBrandList=@"GetBrandList";
const NSString *SP_URL_GetProductList=@"http://www.supuy.com/api/phone/GetGoodsList";            //商品列表
const NSString *SP_METHOD_GetProductList=@"GetGoodsList";
const NSString *SP_URL_GetProductCommentList=@"http://www.supuy.com/api/phone/GetGoodsComment";            //商品列表
const NSString *SP_METHOD_GetProductCommentList=@"GetGoodsComment";
const NSString *SP_URL_GetGoodsDetails=@"http://www.supuy.com/api/phone/GetGoodsDetails";            //商品详情
const NSString *SP_METHOD_GetGoodsDetails=@"GetGoodsDetails";
const NSString *SP_URL_GetScreeningInfo=@"http://www.supuy.com/api/phone/GetScreeningInfo";            //筛选数据列表
const NSString *SP_METHOD_GetScreeningInfo=@"GetScreeningInfo";

const NSString *SP_URL_GETGOODSACTIVITIES = @"http://www.supuy.com/api/phone/GetGoodsActivities";//获取活动信息
const NSString *SP_METHOD_GETGOODSACTIVITIES = @"GetGoodsActivities";
const NSString *SP_URL_GETGOODSDESCRIPTION = @"http://www.supuy.com/api/phone/GetGoodsDescription";//获取商品详情
const NSString *SP_METHOD_GETGOODSDESCRIPTION = @"GetGoodsDescription";
const NSString *SP_URL_GETGOODSCONSULT = @"http://www.supuy.com/api/phone/GetGoodsConsult";//获取商品咨询列表
const NSString *SP_METHOD_GETGOODSCONSULT = @"GetGoodsConsult";

const NSString *SP_URL_MODIFYSHOPPINGCART=@"http://www.supuy.com/api/phone/ModifyShoppingCart";   //修改购物车
const NSString *SP_METHOD_MODIFYSHOPPINGCART=@"ModifyShoppingCart";

//const NSString *SP_URL_SUBMITORDER=@"http://123.234.70.98:8012/api/phone/SubmitOrder";   //提交订单
const NSString *SP_URL_SUBMITORDER=@"http://www.supuy.com/api/phone/SubmitOrder";   //提交订单
const NSString *SP_METHOD_SUBMITORDER=@"SubmitOrder";

//const NSString *SP_URL_GETORDERLIST=@"http://123.234.70.98:8012/api/phone/GetOrderList";   //获得订单列表
const NSString *SP_URL_GETORDERLIST=@"http://www.supuy.com/api/phone/GetOrderList";   //获得订单列表
const NSString *SP_METHOD_GETORDERLIST=@"GetOrderList";

const NSString *SP_URL_GetPaymentShipping=@"http://www.supuy.com/api/phone/GetPaymentShipping";   //获取支付方式，和送货方式
const NSString *SP_METHOD_GetPaymentShipping=@"GetPaymentShipping";

const NSString *SP_URL_GetActivity=@"http://www.supuy.com/api/phone/GetActivity";       //活动详情
const NSString *SP_METHOD_GetActivity=@"GetActivity";

const NSString *SP_URL_AddFavorites=@"http://www.supuy.com/api/phone/AddFavorites";            //加入收藏
const NSString *SP_METHOD_AddFavorites=@"AddFavorites";

//const NSString *SP_URL_GETORDERSUCCESS = @"http://123.234.70.98:8012/api/phone/GetOrderSuccess";//提交订单成功后查询订单的提示信息
const NSString *SP_URL_GETORDERSUCCESS = @"http://www.supuy.com/api/phone/GetOrderSuccess";//提交订单成功后查询订单的提示信息
const NSString *SP_METHOD_GETORDERSUCCESS = @"GetOrderSuccess";

const NSString *SP_URL_GetUPPayData = @"http://www.supuy.com/api/phone/GetUPPayData";
const NSString *SP_METHOD_GetUPPayData = @"GetUPPayData";  //获取网银支付成功

const NSString *SP_URL_GetAliPayData = @"http://www.supuy.com/api/phone/GetAliPayData";
const NSString *SP_METHOD_GetAliPayData = @"GetAliPayData";  //获取支付宝的接口

const NSString *SP_URL_GETMEMBERINFO = @"http://www.supuy.com/api/phone/GetMemberInfo";//获取会员信息
const NSString *SP_METHOD_GETMEMBERINFO = @"GetMemberInfo";

const NSString *SP_URL_iPhonePush = @"http://www.supuy.com/api/phone/iPhonePush";
const NSString *SP_METHOD_iPhonePush = @"iPhonePush";
//const NSString *SP_URL_GETTICKETINFO = @"http://123.234.70.98:8012/api/phone/GetTicketInfo";//获取优惠劵可用信息
const NSString *SP_URL_GETTICKETINFO = @"http://www.supuy.com/api/phone/GetTicketInfo";//获取优惠劵可用信息
const NSString *SP_METHOD_GETTICKETINFO = @"GetTicketInfo";

const NSString *SP_URL_PUSH = @"http://www.supuy.com/api/phone/iPhonePush";//推送
const NSString *SP_METHOD_PUSH = @"iPhonePush";

const NSString *SP_URL_GetPushMessage = @"http://www.supuy.com/api/phone/iPhonePush";//推送消息
const NSString *SP_METHOD_GetPushMessage = @"GetPushMessage";

//const NSString *SP_URL_GetTicketInfo = @"http://www.supuy.com/api/phone/GetTicketInfo";
//const NSString *SP_METHOD_GetTicketInfo = @"GetTicketInfo";
/**
 公用字段
 */
const NSString* CCS_KEY_DEVICETOKEN = @"devicetokenkey";
const NSString* CCS_KEY_APPKEY = @"appkey";						// 软件身份Key
const NSString* CCS_VALUE_APPKEY = @"223111";					// 软件身份Key
const NSString* CCS_KEY_VERSION_NO = @"ApiVersion";				//  软件版本
const NSString* CCS_VALUE_VERSION_NO = @"1.3";					//  软件版本
const NSString* CCS_KEY_SESSION_ID = @"session_id";				//  API GATEWAY负责为每个运行客户端的终端分配一个session_id，生命期为永久有效，作为未登陆用户的标识。 
const NSString* CCS_VALUE_SESSION_ID = @"testSession";			// API GATEWAY负责为每个运行客户端的终端分配一个session_id，生命期为永久有效，作为未登陆用户的标识。 
const NSString* CCS_KEY_PLATFORM = @"Platform";					// 客户端平台名称
const NSString* CCS_VALUE_PLATFORM = @"iphone";					// 客户端平台名称
const NSString* CCS_KEY_AUTH_TYPE = @"authtype";					// 加密格式	md5
const NSString* CCS_VALUE_AUTH_TYPE = @"MD5";					// 加密格式	md5
const NSString* CCS_KEY_AUTH_TYPESHA = @"password";

const NSString* CCS_KEY_OS_VER = @"os_ver";						// 客户端系统版本
const NSString* CCS_VALUE_OS_VER = @"ios4.2";					// 客户端系统版本
const NSString* CCS_KEY_UD_ID = @"Udid";                        // 设备号
const NSString* CCS_VALUE_UD_ID = @"";                          // 设备号
const NSString* CCS_KEY_IOS_APNSTOKEN = @"iosApnstoken";			// 用于IOS系统的Push机制，其他平台可为空 
const NSString* CCS_VALUE_IOS_APNSTOKEN = @"";					// 用于IOS系统的Push机制，其他平台可为空 
const NSString* CCS_KEY_CLIENT_VER = @"ClientVersion";				// APP客户端版本号 
const NSString* CCS_VALUE_CLIENT_VER = @"1.3";					//APP客户端版本号 
const NSString* CCS_KEY_CONTENT_TYPE = @"content_type";			// 返回的数据格式
const NSString* CCS_VALUE_CONTENT_TYPE = @"json";					// 返回的数据格式
const NSString* CCS_KEY_DEVICE_NAME = @"PhoneModel";			// 手机设备型号
const NSString* CCS_VALUE_DEVICE_NAME = @"";
const NSString* CCS_KEY_IMSI =@"Imsi";							// 手机sim卡标示 
const NSString* CCS_VALUE_IMSI =@"";								// 手机sim卡标示 
const NSString* CCS_KEY_SOURCE_ID =@"Source";					// 客户端推广渠道来源标识 
const NSString* CCS_VALUE_SOURCE_ID =@"spAppstore";			// 客户端推广渠道来源标识 
const NSString* CCS_KEY_LANGUAGE =@"Language";					// APP语言版本 
const NSString* CCS_KEY_CARRIER =@"Operator";						// 运营商信息  
const NSString* CCS_VALUE_CARRIER =@"";							// 运营商信息 
const NSString* CCS_KEY_SMS_CENTER_NUMBER =@"SmsNumber"; // 短信中心号码  
const NSString* CCS_VALUE_SMS_CENTER_NUMBER =@"";				// 短信中心号码   
const NSString* CCS_KEY_WANTYPE =@"wantype";			// 网络连接类型：Wifi、3G，等  
const NSString* CCS_VALUE_WANTYPE =@"";
const NSString* CCS_KEY_SCREENSIZE = @"ScreenSize";              //屏幕分辨率
const NSString* CCS_VALUE_SCREENSIZE = @"320x480";            //屏幕分辨率

const NSString* SP_KEY_MEMBERID=@"MemberId";           //用户ID
const NSString* SP_KEY_SIGN=@"sign";                    //签名

@implementation SPDataInterface
static NSMutableDictionary* commonParams;

+(void) initialize{
	commonParams = [[NSMutableDictionary alloc] init];
	[[self class] initializeCommonParams];
}

+(void)initializeCommonParams{
//	CGFloat screenWidth = 320.0f;
//	CGFloat screenHeight = 480.0f;
//	UIScreen* _screen = [UIScreen mainScreen];
	
	if (isRetina) {
//		UIScreenMode* _mode = [_screen currentMode];
//		screenWidth = _mode.size.width;  
//		screenHeight = _mode.size.height;  
	}
	
	[commonParams setValuesForKeysWithDictionary:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [self getScreenSize], @"screensize",
      CCS_VALUE_CLIENT_VER,CCS_KEY_CLIENT_VER,
      CCS_VALUE_PLATFORM,CCS_KEY_PLATFORM,
      [NSString stringWithFormat:@"%.0f",[[[UIDevice currentDevice] systemVersion] floatValue]],CCS_KEY_OS_VER,
      nil]];
}
+(NSString *)getScreenSize{
    //    得到当前屏幕的尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    // 获得scale
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    return [NSString stringWithFormat:@"%0.f*%0.f",size_screen.width*scale_screen , size_screen.height*scale_screen];
}
// 获取数据字典
+(NSMutableDictionary *)commonParams{
	return commonParams;
}

+(void)setCommonParam:(id)key value:(id)value{
	[commonParams setValue:value forKey:key];
	[[self class] walkDataInterface];
}

+(id)commonParam:(id) key{
	return [commonParams objectForKey:key];
}

+(void)walkDataInterface{
	NSLog(@"= walkDataInterface =");
	for (id _k in [commonParams allKeys]) {
		DLog(@"key:<%@>, value:<%@>",_k, [commonParams objectForKey:_k]);
	}
	DLog(@"= end walkDataInterface =");
}
@end
