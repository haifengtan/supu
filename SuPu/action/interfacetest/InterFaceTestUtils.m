//
//  InterFaceTestUtils.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "InterFaceTestUtils.h"

@implementation InterFaceTestUtils

+ (void)TestRequestUrl:(TestUrlPara *)testurlpara valuedict:(NSMutableDictionary *)valuedict
{
    NSURL *url = [NSURL URLWithString:testurlpara.url];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    request.delegate = self;
    request.requestMethod = testurlpara.requestmethod;
    [request setDidFinishSelector:@selector(requestDataSucc:)];
    [request setDidFailSelector:@selector(requestDataFail:)];
    NSString *sign;
    if (testurlpara.havememberid == FALSE) {
        sign = [[self md5With16:[NSString stringWithFormat:@"%@3B51ACFFC9244DC481CF9454E207429A",testurlpara.methodname]] uppercaseString];
    }else {
        sign = [[self md5With16:[NSString stringWithFormat:@"%@%@3B51ACFFC9244DC481CF9454E207429A",testurlpara.methodname,testurlpara.memberid]] uppercaseString];
        NSMutableDictionary *headerdict = [self getRequestHeaderDictionary];
        [headerdict setValue:testurlpara.memberid forKey:@"MemberId"];
        request.requestHeaders = headerdict;
    }
    [request setPostValue:sign forKey:@"sign"];
    NSArray *keyarr = [valuedict allKeys];
    for (NSString *key in keyarr) {
        [request setPostValue:[valuedict valueForKey:key] forKey:key];
    }
    [request startSynchronous];
    [request release];
}

+ (NSMutableDictionary *)getRequestHeaderDictionary
{
    RequestHeader *rh = [[RequestHeader alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([rh class], &outCount);//获取该类的所有属性
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSMutableString *property_Name = [NSString stringWithFormat:@"%s",property_getName(property)];//获得属性的名称
        //        NSArray *property_Attributes = [[NSString stringWithCString: property_getAttributes(property) encoding: NSASCIIStringEncoding] componentsSeparatedByString: @","];//获得属性的属性
        SEL selector = NSSelectorFromString(property_Name);//通过属性名称获得selector
        id property_Value = [rh performSelector:selector];//通过selector获得value
        [dict setValue:property_Value forKey:property_Name];        
    }
    [rh release];
    return [dict autorelease];
}

//md5 32位加密 （大写
+ (NSString *)md5With32:(NSString *)str 
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
+ (NSString *)md5With16:(NSString *)str 
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

+ (void)requestDataSucc:(ASIFormDataRequest *)request
{
    NSData *data = request.responseData;
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    [result release];
}

+ (void)requestDataFail:(ASIFormDataRequest *)request
{
    NSLog(@"fail");
}

@end
