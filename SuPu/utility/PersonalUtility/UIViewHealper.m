//
//  UIViewHealper.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "UIViewHealper.h"
#import <objc/runtime.h>
#import "JSONKit.h"

@implementation UIViewHealper

+ (void)helperBasicASIFailUIAlertView
{
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void)helperBasicUIAlertView:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void)helperBasicUIAlertViewUseJsonResult:(NSString *)title jsonresult:(NSString *)jsonresult
{
    NSMutableDictionary *dict = [jsonresult objectFromJSONString];
    NSString *message = [dict objectForKey:@"Message"];
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (UILabel *)createNoDataLabel:(CGRect)bounds title:(NSString *)title
{
    UILabel *nodatalabel = [[UILabel alloc] initWithFrame:bounds];
    nodatalabel.text = title;
    nodatalabel.textAlignment = UITextAlignmentCenter;
    if (iPad) {
        nodatalabel.font = [UIFont systemFontOfSize:28];
    }else{
        nodatalabel.font = [UIFont systemFontOfSize:16];
    }
    nodatalabel.textColor = [UIColor lightGrayColor];
//内存警告------------------
    return [nodatalabel autorelease] ;
}

@end
