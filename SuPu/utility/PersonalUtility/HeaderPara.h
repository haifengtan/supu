//
//  HeaderPara.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderPara : NSObject

@property (retain, nonatomic) NSString *Platform;//客户端类型
@property (retain, nonatomic) NSString *Udid;//设备号
@property (retain, nonatomic) NSString *PhoneModel;//手机型号
@property (retain, nonatomic) NSString *Imsi;//手机sim卡
@property (retain, nonatomic) NSString *Imei;//手机硬件识别号
@property (retain, nonatomic) NSString *Source;//客户端来源标识
@property (retain, nonatomic) NSString *Language;//语言
@property (retain, nonatomic) NSString *Operator;//运营商
@property (retain, nonatomic) NSString *SmsNumber;//短信中心号码
@property (retain, nonatomic) NSString *ScreenSize;//屏幕分辨率
@property (retain, nonatomic) NSString *ApiVersion;//接口版本号
@property (retain, nonatomic) NSString *ClientVersion;//客户端版本号

@end
