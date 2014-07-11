//
//  SPAppDelegate.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
#import "CustomTabBar.h"
#import "SPPushAction.h"
#define KAppDelegate ((SPAppDelegate *)([UIApplication sharedApplication].delegate))
#define SUPUHOST @"www.supuy.com"
#import "SPGuidePageViewController.h"
@interface SPAppDelegate : UIResponder <UIApplicationDelegate,SPGuidePageViewControllerDelegate,UIAlertViewDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CustomTabBar *m_tabBarCtrl;
@property (nonatomic, retain) NSString *loginModelViewMotherViewName;
@property (nonatomic,retain) SPGuidePageViewController *guideController;
 


- (void)creatTabBarCtrl;
- (void)testInterface;
- (void)parseURL:(NSURL *)url application:(UIApplication *)application;
@end
