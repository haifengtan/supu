//
//  SPConfig.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+Helper.h"

#define isOS5() \
([[[UIDevice currentDevice] systemVersion] floatValue]>=5.0)

#define kTabbarHeight 49.0
#define kNavHeight 44.0

//加密令牌
#define SP_ACTION_TOKEN @"3B51ACFFC9244DC481CF9454E207429A"

//@"温馨提示"
#define DEFAULTTIP_TITLE @""
#define SP_DEFAULTTITLE  @"速普提示"
#define SP_ERROR_TITLE @"服务器错误"
//电话号码
#define CCS_400PHONE_NUMBER         @"4006180055"
#define CCS_DISPLAY400PHONE_NUMBER  @"4000-021-081"

#define DEVICETYPE_DESC_IPHONE @"iPhone"
#define DEVICETYPE_DESC_IPOD @"iPod"
#define DEVICETYPE_DESC_IPAD @"iPad"

#define SP_BASEURL @"http://pic.supuy.com/"
//__sn:商品编号  __name:图片名称
#define URLForImage(__sn, __name) [NSURL URLWithString:__name]

#define URLImagePath(path)  [NSURL URLWithString:path]

#define  SP_NOTIFICATION_PAYRESULT  @"SP_notification_payResult"

#define kShowPicture      @"showpicture"
#define KPUSHMESSAGE      @"pushmessage"
#define kDefaultImage     [UIImage imageNamed:@"noimage.png"]

#define KNETWORKERROR   @"网络连接失败，请确保设备已经连网"

#define kNotifyRefreshAddressListKey @"refreshAddressListKey"
@interface SPConfig : NSObject

@end
