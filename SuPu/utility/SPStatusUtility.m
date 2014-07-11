//
//  SPStatusUtility.m
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPStatusUtility.h"
#import "SPConfig.h"
#import "Member.h"
#import "SPBrowerData.h"
#import "SPProductDetailData.h"
#import "SDImageCache.h"
#import "sys/utsname.h"

static UIAlertView *_alertView = nil;

@implementation SPStatusUtility
#ifndef CCS_NAVIGATIONBAR_REALHEIGHT
#define CCS_NAVIGATIONBAR_REALHEIGHT 44
#endif

#ifndef MAX_BROWSER
#define MAX_BROWSER 20
#endif

+(CGFloat)getScreenHeight{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return  size.height;
}

+(CGFloat)getNavigationBarHeight
{
	return CCS_NAVIGATIONBAR_REALHEIGHT;
}

+(CGFloat)getTabBarHeight
{
	return 44;
}

+(CGFloat)getShowViewHeight
{
    if (iPad) {
        return 1004.0 - [SPStatusUtility getNavigationBarHeight] - [SPStatusUtility getTabBarHeight] - 51;
    }else{
        return 460.0 - [SPStatusUtility getNavigationBarHeight] - [SPStatusUtility getTabBarHeight];
    }
}

+(CGFloat)getShowViewWidth
{
    if (iPad) {
        return 768.0;
    }else{
        return 320.0;
    }
}

+ (void)showAlert:(NSString *)aTitle message:(NSString *)aMessage delegate:(id<UIAlertViewDelegate>)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    if (_alertView.isVisible) {
        return;
    }
    if (_alertView != nil) {
        [_alertView release],_alertView = nil;
    }
    _alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:aDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (otherButtonTitles != nil) {
        va_list args;
        va_start(args, otherButtonTitles);
        NSString* arg = nil;
        [_alertView addButtonWithTitle:otherButtonTitles];
        while ( ( arg = va_arg( args, NSString*) ) != nil ) {
            [_alertView addButtonWithTitle:arg];
        }
        va_end(args);
    }
    [_alertView show];
}

+(BOOL)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    
	
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

+(void)makeCall:(NSString*)telnum
{
	if ([[self class] checkDevice:DEVICETYPE_DESC_IPHONE] && [telnum length])
	{
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否拨打热线电话?" message:telnum
													   delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"拨打",nil];
		[alert show];
		[alert release];
		
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本设备不支持拨号功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==1){
		NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",CCS_400PHONE_NUMBER]; //number为号码字符串
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
		[num release];
	}
}

+(BOOL)isUserLogin
{ 
    if ([[Member allObjects] count]==0) {
        return NO;
    }
    return YES;
    
}

+ (NSString *)dateStringFromTimeInterval:(NSString *)intervalString {
    NSString *result = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalString.doubleValue];
    result = [formatter stringFromDate:date];
    [formatter release];
    return result;
}

+ (NSString *)dateStringFromTimeIntervalByFormatterString:(NSString *)intervalString formatterstring:(NSString *)formatterstring{
    NSString *result = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterstring];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalString.doubleValue];
    result = [formatter stringFromDate:date];
    [formatter release];
    return result;
}

/**
 *	@brief	浏览记录
 *
 *	保存浏览记录
 *
 *	@param 	l_data 	详情对象
 */
+(void)saveBrowerData:(SPBaseData*)l_data{
    SPProductDetailData *l_detail=(SPProductDetailData*)l_data;
    SPProductGoodsImage *l_img=[l_detail.mGoodsImages objectAtIndex:0];
    NSArray* l_annelArray = [[self class] loadAllBrowerData];
    for (SPBrowerData *object in l_annelArray) {
        if ([object.mgoodssn isEqualToString:l_detail.mGoodsSN]) {
            [self deleteBrowerData:object];
            continue;
        }
    }
    [SPBrowerData saveProductWithCode:l_detail.mGoodsSN
                             withName:l_detail.mGoodsName
                           withSlogan:l_detail.mGoodsSlogan
                     withCommentCount:l_detail.mCommentCount
                            withPrice:l_detail.mShopPrice
                           withOprice:l_detail.mMarketPrice
                        withIsNoStock:@"false"
                         withImageUrl:l_img.mImgFile];
    
    //让数据保存的商品数不大于MAX_BROWSER，如果大于MAX_BROWSER就删除最前面的商品数据。
    
    l_annelArray = [l_annelArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return NSOrderedDescending;
    }];
    
    if ([l_annelArray count]>MAX_BROWSER) {
        [self deleteBrowerData:(SPBrowerData *)[l_annelArray objectAtIndex:MAX_BROWSER]];
    }
}

/**
 *	@brief	浏览记录
 *
 *	删除浏览记录
 *
 *	@param 	l_data 	浏览记录对象
 */
+(void)deleteBrowerData:(SPBaseData*)l_data{
    SPBrowerData *l_data_dele=(SPBrowerData *)l_data;
  
    [l_data_dele deleteObject];
}

/**
 *	@brief	浏览记录
 *
 *	加载所有浏览记录
 *
 *	@return	浏览记录数组
 */
+(NSArray*)loadAllBrowerData{
    return [SPBrowerData allObjects];
}

/**
 *	@brief	浏览记录
 *
 *	清除浏览记录
 */
+(void)clearAllBrowerData{
    for (SPBrowerData *l_data in [[self class] loadAllBrowerData]) {
        [l_data deleteObject];
    }
}

+(void)clearAllMermoryCache{
    int l_int_sizeM=[[SDImageCache sharedImageCache] getMemorySize]/1024/1024;
    
    if (l_int_sizeM>2) {
        [[SDImageCache sharedImageCache] clearMemory];
    }
}

/**
 *	@brief	图片缓存
 *
 *	清理图片缓存
 */
+(void)clearAllImgCache{
    DLog(@"磁盘%d",[[SDImageCache sharedImageCache] getMemorySize]);
    DLog(@"内存%d",[[SDImageCache sharedImageCache] getSize]);
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] cleanDisk1];
    DLog(@"磁盘%d",[[SDImageCache sharedImageCache] getMemorySize]);
    DLog(@"内存%d",[[SDImageCache sharedImageCache] getSize]);
    if ([SPStatusUtility isAllImgCacheClean]) {
        [SPStatusUtility showAlert:nil message:@"缓存清理成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }else{
        [SPStatusUtility showAlert:nil message:@"缓存清理失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }
}

/**
 *	@brief	图片缓存
 *
 *	是否清空缓存
 *
 *	@return	yes or no
 */
+(BOOL)isAllImgCacheClean{
    
    if ([[SDImageCache sharedImageCache] getMemorySize]==0&&[[SDImageCache sharedImageCache] getSize]==0) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *	@brief	列表图片展示
 *
 *	设置列表图片是否展示
 *
 *	@param 	_isDisplay 	yes or no
 */
+(void)recordListImgDisplay:(BOOL)_isDisplay{
    
}

/**
 *	@brief	列表图片展示
 *
 *	列表图片是否展示
 *
 *	@return	yes or no
 */
+(BOOL)isListImgDisplay{
    if (YES) {
        return YES;
    }else{
        return NO;
    }
}


+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
   
    return deviceString;
}


+ (void)setObject:(id)value forKey:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(id)getObjectForKey:(NSString*)key{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}
+(void)removeObjectForKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


@end
