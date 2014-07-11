//
//  JsonUtil.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "JsonUtil.h"
#import <objc/runtime.h>
#import "Member.h"
@implementation JsonUtil

+ (id) fromSimpleObjectToSimpleJsonStr:(id)simpleObject
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([simpleObject class], &outCount);//获取该类的所有属性
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSMutableString *property_Name = [NSString stringWithFormat:@"%s",property_getName(property)];//获得属性的名称
        //        NSArray *property_Attributes = [[NSString stringWithCString: property_getAttributes(property) encoding: NSASCIIStringEncoding] componentsSeparatedByString: @","];//获得属性的属性
        SEL selector = NSSelectorFromString(property_Name);//通过属性名称获得selector
        id property_Value = [simpleObject performSelector:selector];//通过selector获得value
        [dict setValue:property_Value forKey:property_Name];        
    }
    return [dict JSONString];
}

//根据传过来的字符串，转成一个对象的数组
+ (id) fromSimpleJsonStrToSimpleObject:(NSString *)simpleJsonStr className:(Class)className keyPath:(NSString *)keyPath keyPathDeep:(NSString *)keyPathDeep
{ 
    NSObject *dict;
    if (keyPath == nil || [keyPath isEqualToString:@""]) {//加入传入的keypath为nil，就直接将整个字符串转成dict
        dict = [simpleJsonStr objectFromJSONString];
    }else {//加入传入的keypath有值，表示需要获取json中的部分内容
        NSArray *keypatharr = [keyPath componentsSeparatedByString:@"."];//将路径通过.分开
        NSArray *keypathdeeparr = nil;
        if (keyPathDeep != nil && ![keyPathDeep isEqualToString:@""]) {
            //如果对里面的arr的层级有要求，则传入keydeeppath
            keypathdeeparr = [keyPathDeep componentsSeparatedByString:@"."];
        }
        dict = [simpleJsonStr objectFromJSONString];
        int k = [dict isKindOfClass:[NSArray class]] == YES?0:1;
        //如果字符串传进来就是一个不以中括号开头的json。这个时候，我们的层级的书写对于dict需要进行减一的操作，否则直接按照层级关系进行就可以了
        for (int i=0; i<keypatharr.count; i++) {
            NSString *keypathstr = [keypatharr objectAtIndex:i];
            if ([dict isKindOfClass:[NSArray class]]) {
                if (keypathdeeparr == nil) {//如果对层级没有要求，就直接拿里面的第一个
                    dict = [(NSArray *)dict objectAtIndex:0];
                }else {
                    int deep = [(NSString *)[keypathdeeparr objectAtIndex:i-k] intValue];
                    dict = [(NSArray *)dict objectAtIndex:deep];
                }
            }
            
            dict = [(NSDictionary *)dict objectForKey:keypathstr];

        }
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        NSMutableArray *resultarr = [[[NSMutableArray alloc] init] autorelease];
        for (NSDictionary *dictarrobj in (NSArray *)dict) {
            id simpleObject = [[className alloc] init];
            unsigned int outCount, i;
            objc_property_t *properties = class_copyPropertyList(className, &outCount);//获取该类的所有属性
            for (i=0; i<outCount; i++) {
                objc_property_t property = properties[i];
                NSMutableString *property_Name = [NSString stringWithFormat:@"%s",property_getName(property)];
                NSRange upperRange = {0,1};//第一个是locaiton，第二个是length
                NSRange lowRange = {1,property_Name.length-1};
                NSString *upperstr = [[property_Name substringWithRange:(upperRange)] uppercaseString];
                NSString *lowerstr = [property_Name substringWithRange:(lowRange)];
                NSMutableString *setMethodName = [NSString stringWithFormat:@"set%@%@:",upperstr,lowerstr];
                SEL selector = NSSelectorFromString(setMethodName);
                id setValue = [dictarrobj objectForKey:property_Name];
                [simpleObject performSelector:selector withObject:setValue];
            }
            [resultarr addObject:simpleObject];
            [simpleObject release];
        }
        return resultarr;
    }
    if ([dict isKindOfClass:[NSDictionary class]]) {
        id simpleObject = [[[className alloc] init] autorelease];
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(className, &outCount);//获取该类的所有属性
        for (i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            NSMutableString *property_Name = [NSString stringWithFormat:@"%s",property_getName(property)];
            NSRange upperRange = {0,1};//第一个是locaiton，第二个是length
            NSRange lowRange = {1,property_Name.length-1};
            NSString *upperstr = [[property_Name substringWithRange:(upperRange)] uppercaseString];
            NSString *lowerstr = [property_Name substringWithRange:(lowRange)];
            NSMutableString *setMethodName = [NSString stringWithFormat:@"set%@%@:",upperstr,lowerstr];
            SEL selector = NSSelectorFromString(setMethodName);
            id setValue = [(NSDictionary *)dict objectForKey:property_Name];
            [simpleObject performSelector:selector withObject:setValue];
        }
        return simpleObject;
    }
    return nil;
}
/******
 *上面那种方式有限制的
 *当属性名称和服务器上返回的名称不一致的时候就会解析不到数据
 *为了能解析数据处理如下
 *用处处理结算中心的现金不能取的的bug
 */
+ (id) fromSimpleJsonStrToSimpleObject1:(NSString *)simpleJsonStr className1:(Class)className keyPath1:(NSString *)keyPath keyPathDeep1:(NSString *)keyPathDeep
{ 
    NSDictionary *dict = [simpleJsonStr objectFromJSONString];
    Member *simpleObject = (Member *)[[[className alloc] init] autorelease];
    NSDictionary *memberDict = [[dict objectForKey:@"Data"] objectForKey:@"Member"];
    simpleObject.maccount = [memberDict objectForKey:@"Account"];
    simpleObject.mimageUrl = [memberDict objectForKey:@"ImageUrl"];
    simpleObject.mlevel = [memberDict objectForKey:@"Level"];
    simpleObject.mmemberId = [memberDict objectForKey:@"MemberId"];
    simpleObject.mprice = [memberDict objectForKey:@"Price"];
    simpleObject.mscores = [memberDict objectForKey:@"Scores"];
    return simpleObject;
}

@end
