//
//  HeaderPara.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "HeaderPara.h"

@implementation HeaderPara
@synthesize Platform;
@synthesize Udid;
@synthesize PhoneModel;
@synthesize Imsi;
@synthesize Imei;
@synthesize Source;
@synthesize Language;
@synthesize Operator;
@synthesize SmsNumber;
@synthesize ScreenSize;
@synthesize ApiVersion;
@synthesize ClientVersion;

- (id)init
{
    self.Platform = [[UIDevice currentDevice] name];
    self.Udid = @"";
    self.PhoneModel = [[UIDevice currentDevice] model];
    self.Imsi = @"";
    self.Imei = @"";
    self.Source = @"";
    self.Language = @"";
    self.Operator = @"";
    self.SmsNumber = @"";
//    self.ScreenSize = @"320x480";
    self.ApiVersion = @"1.3";
    NSLog(@"==========CFBundleVersion=====%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]);
    self.ClientVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
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

- (void)dealloc
{
    [Platform release];
    [Udid release];
    [PhoneModel release];
    [Imsi release];
    [Imei release];
    [Source release];
    [Language release];
    [Operator release];
    [SmsNumber release];
    [ScreenSize release];
    [ApiVersion release];
    [ClientVersion release];
    [super dealloc];
}

@end
