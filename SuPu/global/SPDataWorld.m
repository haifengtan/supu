//
//  SPDataWorld.m
//  SuPu
//
//  Created by xx on 12-9-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPDataWorld.h"
#import "SPDataInterface.h"
#import "CCSStringUtility.h"
#import "NSString+URLEncoding.h"

static SPDataWorld* s_dataWorld;

@implementation SPDataWorld

+(SPDataWorld *)shareData
{
    @synchronized(self)
    {
        if (s_dataWorld==nil) {
            s_dataWorld = [[SPDataWorld alloc] init];
            
        }
    }
    return s_dataWorld;
}
-(NSString *)getScreenSize{
    //    得到当前屏幕的尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    // 获得scale
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    return [NSString stringWithFormat:@"%0.f*%0.f",size_screen.width*scale_screen , size_screen.height*scale_screen];
}
// 速普服务器Http请求引擎
- (CCSHttpEngine *)httpEngineSP
{
//    @synchronized(self)
//	{
    if (m_spHttpEngine) {
        m_spHttpEngine=nil;
    }
    
		if (m_spHttpEngine==nil)
		{
            /*
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
            
//            NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//            NSArray* languages = [defs objectForKey:@"AppleLanguages"];
//            NSString* preferredLang = [languages objectAtIndex:0];
            
            
            NSString *platformvalue = iPad?@"ipad":@"iphone";
            NSString *boundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            NSDictionary *l_headerDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                         strOrEmpty([[SPDataInterface commonParam:SP_KEY_MEMBERID] URLEncodedString]),SP_KEY_MEMBERID,
                                         CCS_VALUE_APPKEY, CCS_KEY_APPKEY,
                                         platformvalue,CCS_KEY_PLATFORM,
                                         CCS_VALUE_UD_ID,CCS_KEY_UD_ID,
                                         [CCSStringUtility strOrEmpty:[[UIDevice currentDevice] model]] ,CCS_KEY_DEVICE_NAME,
                                         CCS_VALUE_IMSI,CCS_KEY_IMSI,
                                         CCS_VALUE_SOURCE_ID,CCS_KEY_SOURCE_ID,
                                         CCS_VALUE_CARRIER,CCS_KEY_CARRIER,
                                          [[NSLocale preferredLanguages] objectAtIndex:0],CCS_KEY_LANGUAGE,
                                         CCS_VALUE_SMS_CENTER_NUMBER,CCS_KEY_SMS_CENTER_NUMBER,
                                         [self getScreenSize],CCS_KEY_SCREENSIZE,
                                         CCS_VALUE_VERSION_NO,CCS_KEY_VERSION_NO,
                                         boundleVersion,CCS_KEY_CLIENT_VER,
                                         
                                         nil];
            
			m_spHttpEngine = [[CCSHttpEngine engineWithHeaderParams:l_headerDic] retain];
            [m_spHttpEngine setM_timeInterval_timeout:10.0f];
            [l_headerDic release];
		}
//	}
	return m_spHttpEngine;
}
@end
