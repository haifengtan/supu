//
//  OUOMacros.h
//  OUOKit
//
//  Created by 杨福军 on 12-9-5.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//
///////////////////////////////////////////////////////
#pragma mark - 判断硬件是不是ipad
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

///////////////////////////////////////////////////////
#pragma mark - 内存释放
#define OUOSafeRelease(__v) ([__v release], __v = nil);
#define OUOSuperDealoc() [super dealloc];

///////////////////////////////////////////////////////
#pragma mark - 弹出信息

#define OUOAlertWithDelegate(_title, _message, _aDelegate)  \
UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:_aDelegate cancelButtonTitle:@"确定" otherButtonTitles:nil];                          \
[alertView show];                                                                  \
[alertView release];                                                               \

#define OUOAlert(_title, _message) OUOAlertWithDelegate(_title, _message, nil)

///////////////////////////////////////////////////////
#pragma mark -
#define OUO_RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define OUO_COLOR_PATTERNIMAGE(name) [UIColor colorWithPatternImage:[UIImage imageNamed:(name)]]
#define OUO_IMAGE(name) [UIImage imageNamed:(name)]
#define OUO_URL(__url) [NSURL URLWithString:__url]
#define OUOLocalizedStringWithFormat(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]
#define OUO_RECT(x, y, w, h) CGRectMake((x), (y), (w), (h))
#define OUO_FONT(__size) [UIFont systemFontOfSize:__size]
#define OUO_FONT_BOLD(__s) [UIFont boldSystemFontOfSize:__s]
#define OUO_BUTTON(__type) [UIButton buttonWithType:__type]

///////////////////////////////////////////////////////
#pragma mark - 角度转换
#define OUODegreesToRadian(x) (M_PI * (x) / 180.0)
#define OUORadianToDegrees(x) (M_PI * 180.0 / (x))

///////////////////////////////////////////////////////
#pragma mark -
// wrap to have non-retaining self pointers in blocks: safeSelf(dispatch_async(myQ, ^{[self doSomething];});
// use with care! can lead to crashes if self suddelny vanishes...
#define safeSelf(...) do {              \
__typeof__(self) __x = self;            \
__block __typeof__(self) self = __x;    \
__VA_ARGS__;                            \
} while (0)

// 软件版本
#define OUO_APPVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// 文件路径
#define OUO_FILEPATH4DOCUMENT(_value) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_value]
#define OUO_FILEPATH4BUNDLE(_value) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_value]
#define OUO_URL4FILEPATH(_value) [NSURL fileURLWithPath:_value]
#define OUO_URL4DOCUMENT(_value) [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:_value]]
#define OUO_URL4BUNDLE(_value) [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_value]]

// 排序
#define OUO_SORTED(arr,by,asc) [arr sortedArrayUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:by ascending:asc] autorelease]]]
#define OUO_SORT(arr,by,asc) [arr sortUsingDescriptors:[NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:by ascending:asc] autorelease]]];

// value or nil
#define OUO_NUMBER_INT(value) (value ? [NSNumber numberWithInt:value] : [NSNumber numberWithInt:0])
#define OUO_NUMBER_FLOAT(value) (value ? [NSNumber numberWithDouble:(double)value] : [NSNumber numberWithDouble:(double)0.0])
#define OUO_NUMBER_BOOL(value) (value ? [NSNumber numberWithBool:value] : [NSNumber numberWithBool:NO])
#define OUO_NULL [NSNull null]

#define OUO_SAFE_OBJECT(obj) ((NSNull *)(obj) == [NSNull null] ? nil : (obj))

// collection shortcuts
#define OUO_STRING_FORMAT(...) [NSString stringWithFormat: __VA_ARGS__]
#define OUO_ARRAY(...) [NSArray arrayWithObjects: __VA_ARGS__, nil]
#define OUO_DICT(...) [NSDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]
#define OUO_MUTARRAY(...) [NSMutableArray arrayWithObjects: __VA_ARGS__, nil]
#define OUO_MUTDICT(...) [NSMutableDictionary dictionaryWithObjectsAndKeys: __VA_ARGS__, nil]

// 排序因子
#define OUO_SORT_ASCENDING(a,b) ([a compare:b] == NSOrderedAscending)
#define OUO_SORT_DESCENDING(a,b) ([a compare:b] == NSOrderedDescending)

///////////////////////////////////////////////////////
#pragma mark - 消息中心
#define OUO_NOTIFICATIONCENTER [NSNotificationCenter defaultCenter]
#define OUO_NOTIFICATIONCENTER_ADD(n,sel) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:n object:nil];
#define OUO_NOTIFICATIONCENTER_REMOVE [[NSNotificationCenter defaultCenter] removeObserver:self];
#define OUO_NOTIFICATIONCENTER_POST(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];

///////////////////////////////////////////////////////
#pragma mark - 创建单例
#undef	AS_SINGLETION
#define AS_SINGLETION( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETION
#define DEF_SINGLETION( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
