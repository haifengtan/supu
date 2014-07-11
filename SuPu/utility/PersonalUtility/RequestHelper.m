//
//  RequestHelper.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "RequestHelper.h"
#import "Reachability.h"
#import "SPAppDelegate.h"
#import "NSString+Category.h"
#import "NSString+URLEncoding.h"

@interface RequestHelper ()

@property (retain, nonatomic) NSString *url;
@property (retain, nonatomic) NSString *methodname;
@property (retain, nonatomic) NSString *memberid;
@property (retain, nonatomic) NSString *requestmethod;

- (NSMutableDictionary *)getRequestHeaderDictionary:(id)object;
- (NSString *)getSign:(BOOL)havememberid method:(NSString *)method memberid:(NSString *)memberid;
- (NSString *)md5With32:(NSString *)str;
- (NSString *)md5With16:(NSString *)str;

@end

@implementation RequestHelper
@synthesize url = _url;
@synthesize methodname = _methodname;
@synthesize memberid = _memberid;
@synthesize requestmethod = _requestmethod;
@synthesize havememberid = _havememberid;
@synthesize m_request;

- (id)init
{
    if (self ) {
        _havememberid = TRUE;
        _requestmethod = @"POST";
    }
    return self;
}

- (id)initWithUrl:(NSString *)url methodName:(NSString *)methodName memberid:(NSString *)memberid
{
    [self init];
    if (self) {
        
        DLog(@"memner id  ---------------------  %@",memberid);
        [url retain];
        [_url release];
        _url = url;
        [methodName retain];
        [_methodname release];
        _methodname = methodName;
        [memberid retain];
        [_memberid release];
        _memberid = memberid;
 
    }
    return self;
}
-(NSString *)getScreenSize{
    //    得到当前屏幕的尺寸
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    // 获得scale
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    return [NSString stringWithFormat:@"%0.f*%0.f",size_screen.width*scale_screen , size_screen.height*scale_screen];
}
- (void)RequestUrl:(NSMutableDictionary *)valuedict succ:(SEL)succ fail:(SEL)fail responsedelegate:(id)responsedelegate
{
    if (![self isInternetWorking]) {
        return;
    }
    NSURL *url = [[NSURL alloc] initWithString:_url];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    [url release];
    request.delegate = responsedelegate;
    [request setDidFinishSelector:succ];
    [request setDidFailSelector:fail];
    request.requestMethod = _requestmethod;
    HeaderPara *hp = [[HeaderPara alloc] init];
 
    NSString *platformvalue = iPad?@"ipad":@"iphone";
    NSDictionary *headerdict_temp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
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
                                 CCS_VALUE_CLIENT_VER,CCS_KEY_CLIENT_VER,
                                 
                                 nil];
    
    NSMutableDictionary *headerdict = [NSMutableDictionary dictionaryWithDictionary:headerdict_temp];
    
    if (_havememberid == TRUE) {
        [headerdict setObject:[_memberid URLEncodedString] forKey:SP_KEY_MEMBERID];
    }
    request.requestHeaders = headerdict;
    [hp release];
    NSString *sign = [SPActionUtility createSignWithMethod:_methodname];
 
    [request setPostValue:sign forKey:@"sign"];
  
    NSArray *keyarr = [valuedict allKeys];
    for (NSString *key in keyarr) {
        [request setPostValue:[valuedict valueForKey:key] forKey:key];
    }
    [request startAsynchronous];
    
    [request release];
}

- (NSString *)getSign:(BOOL)havememberid method:(NSString *)method memberid:(NSString *)memberid
{
    NSString *sign;
    if (havememberid == FALSE) {
        sign = [[self md5With16:[NSString stringWithFormat:@"%@%@",method,SIGN]] uppercaseString];
    }else {
        //字符串编码
        sign = [[self md5With16:[NSString stringWithFormat:@"%@%@%@",method,[memberid URLEncodedString],SIGN]] uppercaseString];
    }
    return sign;
}

- (NSMutableDictionary *)getRequestHeaderDictionary:(id)object
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);//获取该类的所有属性
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSMutableString *property_Name = [NSString stringWithFormat:@"%s",property_getName(property)];//属性名
        SEL selector = NSSelectorFromString(property_Name);//通过属性名称获得selector
        id property_Value = [object performSelector:selector];//通过selector获得value
        [dict setValue:property_Value forKey:property_Name];        
    }
    return [dict autorelease];
}

//md5 32位加密 （大写
- (NSString *)md5With32:(NSString *)str 
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"xxxxxxxxxxxxxxxx",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]];
}

//md5 16位加密 （大写）
- (NSString *)md5With16:(NSString *)str 
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];  
}

-(BOOL)isInternetWorking{
    Reachability* curReach = [Reachability reachabilityWithHostName:SUPUHOST];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status == NotReachable) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:DEFAULTTIP_TITLE
//                                                        message:@"网络连接失败，请确保设备已经连网"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
        [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:@"网络连接失败，请确保设备已经连网" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        return NO;
    }else{
        return YES;
    }
}

- (void)dealloc
{
    [_url release];
    [_methodname release];
    [_memberid release];
    [_requestmethod release];
    [super dealloc];
}

@end
