//
//  SPAppDelegate.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAppDelegate.h"

#import "SPHomeViewController.h"
#import "SPClassifyViewController.h"
#import "SPShoppingCartViewController.h"
#import "SPPersonalCenterViewController.h"
#import "SPMoreViewController.h"
#import "Member.h"

//测试请求
#import "SPHomeAction.h"
#import "SPHomeTopAction.h"
//#import "SPShoppingCartAction.h"
#import <sys/utsname.h>
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "SPApsAction.h"

#import "SPGuidePageViewController.h"

#import "SPGuidePageViewController.h"
@implementation SPAppDelegate

@synthesize window = _window;
@synthesize m_tabBarCtrl;
@synthesize loginModelViewMotherViewName;
@synthesize guideController;

- (void)dealloc
{
    [m_tabBarCtrl release];
    [_window release];
    [loginModelViewMotherViewName release];
    [super dealloc];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    //设置缓存大小
    int cacheSizeMemory = 4*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"] autorelease];
    [NSURLCache setSharedURLCache:sharedCache];

    ////////////////////////////////友盟统计////////////////////////////////////////////
    
    [MobClick startWithAppkey:iPad ? @"51e4c45256240b6e340cc8f1":@"51e4c43756240bd693186fce"];
    
    
    if ([SPStatusUtility isUserLogin]) {
        [SPActionUtility recoverUserDataFromDB];
        
        [self registerPushNotification];
    }
    

    NSString *isOpen =  [SPStatusUtility getObjectForKey:kShowPicture];
       
    if ([strOrEmpty(isOpen) isEqualToString:@""]) {
        [SPStatusUtility setObject:@"ON" forKey:kShowPicture];
    }

    
    // Override point for customization after application launch.
     
    
    guideController = [[SPGuidePageViewController alloc] init];
    guideController.m_delegate = self;
//    [self creatTabBarCtrl];  
    [self.window addSubview:guideController.view];
    [_window makeKeyAndVisible];
  
    return YES;
}
#pragma mark  SPGuidePageViewControllerDelegate
-(void)guideComplete{
    if (guideController.view) {
        [guideController.view removeFromSuperview];
    }
    [self creatTabBarCtrl];
    [guideController release];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{   
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)creatTabBarCtrl{
    m_tabBarCtrl=[[CustomTabBar alloc] init];
    m_tabBarCtrl.delegate = self;
    SPHomeViewController *l_ctrl_home= nil;
    if (iPad) {
        l_ctrl_home=[[[SPHomeViewController alloc] initWithNibName:@"SPHomePadViewController" bundle:nil] autorelease];
    }else{
        l_ctrl_home=[[[SPHomeViewController alloc] initWithNibName:@"SPHomeViewController" bundle:nil] autorelease];
    }
    UIImage *l_ctrl_home_image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"首页_选中" ofType:@"png"]];
    [l_ctrl_home.tabBarItem initWithTitle:@"首页" image:l_ctrl_home_image tag:1];
    [l_ctrl_home_image release];
    OUONavigationController *l_nav_home=[[OUONavigationController alloc] initWithRootViewController:l_ctrl_home];
    
    SPClassifyViewController *l_ctrl_classify = nil;
    if (iPad) {
        l_ctrl_classify=[[[SPClassifyViewController alloc] initWithNibName:@"SPClassifyPadViewController" bundle:nil] autorelease];
    }else{
        l_ctrl_classify=[[[SPClassifyViewController alloc] initWithNibName:@"SPClassifyViewController" bundle:nil] autorelease];
    }
    UIImage *l_ctrl_classify_image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分类_选中" ofType:@"png"]];
    [l_ctrl_classify.tabBarItem initWithTitle:@"分类" image:l_ctrl_classify_image tag:2];
    [l_ctrl_classify_image release];
    OUONavigationController *l_nav_classify=[[OUONavigationController alloc] initWithRootViewController:l_ctrl_classify];
    
    SPShoppingCartViewController *l_ctrl_shopCart = nil;
    if (iPad) {
        l_ctrl_shopCart=[[[SPShoppingCartViewController alloc] initWithNibName:@"SPShoppingCartPadViewController" bundle:nil] autorelease];
    }else{
        l_ctrl_shopCart=[[[SPShoppingCartViewController alloc] initWithNibName:@"SPShoppingCartViewController" bundle:nil] autorelease];
    }
    UIImage *l_ctrl_shopCart_image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"购物车_选中" ofType:@"png"]];
    [l_ctrl_shopCart.tabBarItem initWithTitle:@"购物车" image:l_ctrl_shopCart_image tag:3];
    [l_ctrl_shopCart_image release];
    OUONavigationController *l_nav_shopCart=[[OUONavigationController alloc] initWithRootViewController:l_ctrl_shopCart];
    
    SPPersonalCenterViewController *l_ctrl_personal = nil;
    if (iPad) {
        l_ctrl_personal=[[[SPPersonalCenterViewController alloc] initWithNibName:@"SPPersonalCenterPadViewController" bundle:nil] autorelease];
    }else{
        l_ctrl_personal=[[[SPPersonalCenterViewController alloc] initWithNibName:@"SPPersonalCenterViewController" bundle:nil] autorelease];
    }
    UIImage *l_ctrl_personal_image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"会员中心_选中" ofType:@"png"]];
    [l_ctrl_personal.tabBarItem initWithTitle:@"会员中心" image:l_ctrl_personal_image tag:4];
    [l_ctrl_personal_image release];
    OUONavigationController *l_nav_personal=[[OUONavigationController alloc] initWithRootViewController:l_ctrl_personal];
    
    SPMoreViewController *l_ctrl_more= nil;
    if (iPad) {
        l_ctrl_more = [[[SPMoreViewController alloc] initWithNibName:@"SPMorePadViewController" bundle:nil] autorelease];
    }else{
        l_ctrl_more = [[[SPMoreViewController alloc] initWithNibName:@"SPMoreViewController" bundle:nil] autorelease];
    }
    UIImage *l_ctrl_more_image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"更多_选中" ofType:@"png"]];
    [l_ctrl_more.tabBarItem initWithTitle:@"更多" image:l_ctrl_more_image tag:5];
    [l_ctrl_more_image release];
    OUONavigationController *l_nav_more=[[OUONavigationController alloc] initWithRootViewController:l_ctrl_more];
    
    m_tabBarCtrl.viewControllers = [NSArray arrayWithObjects:l_nav_home,l_nav_classify,l_nav_shopCart,l_nav_personal,l_nav_more,nil];
    
    [m_tabBarCtrl selectTab:0];
    
 
    m_tabBarCtrl.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    
    [_window addSubview:m_tabBarCtrl.view];
    
}
 
 
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parseURL:url application:application];
	return YES;
}

#pragma -
#pragma mark 推送服务
-(void)registerPushNotification
{
    NSString *isSet =  [SPStatusUtility getObjectForKey:KPUSHMESSAGE];
    
    if ([strOrEmpty(isSet) isEqualToString:@""])
    {
        [SPStatusUtility setObject:@"ON" forKey:KPUSHMESSAGE];
    }
    else if([strOrEmpty(isSet) isEqualToString:@"OFF"])
    {
       
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        return ;
    }
 
     

    // 先将数字置0
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	// 注册push通知
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
	 
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
    NSString *token=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token=[[token description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    DLog(@"deviceToken ---------------------------------  %@",token);
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:(NSString*)CCS_KEY_DEVICETOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [SPDataInterface setCommonParam:CCS_KEY_DEVICETOKEN value:token];
    
    if ([SPStatusUtility isUserLogin]) {
        [self requestSubmitDeviceToken:token];
    }
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
 
    DLog(@"FailToRegister error: ------------------------- %@",error);
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    DLog(@"收到推送消息 ： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"推送通知"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

//#pragma mark 请求服务器的推送的token
- (void)requestSubmitDeviceToken:(NSString *)token
{
    SPApsAction *apsaction = [[SPApsAction alloc] init];
    [apsaction requestData:SP_URL_PUSH methodName:SP_METHOD_PUSH createParaBlock:^NSDictionary *{
        return [NSDictionary dictionaryWithObjectsAndKeys:token,@"DeviceToken", nil];
    } requestSuccessBlock:^(id object) {
        NSLog(@"push 得到的数据 ------------  %@",object);
    } requestFailureBlock:^(ASIHTTPRequest *request) {
        
    }];
}
 
#pragma -
#pragma mark 解析支付宝url
- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
 
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
    DLog(@"%@", [result description]);
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			/*
			 *用公钥验证签名
			 */
			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
             
                [[NSNotificationCenter defaultCenter] postNotificationName:SP_NOTIFICATION_PAYRESULT object:result];
           
			}//验签错误
			else {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
																	 message:@"签名错误"
																	delegate:nil
														   cancelButtonTitle:@"确定"
														   otherButtonTitles:nil];
				[alertView show];
				[alertView release];
                
			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
 
            [[NSNotificationCenter defaultCenter] postNotificationName:SP_NOTIFICATION_PAYRESULT object:result];
		}
		
	}	
}
@end
