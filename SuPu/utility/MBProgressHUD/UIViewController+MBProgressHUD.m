/*
 *  UIViewController+MBProgressHUD.m
 *
 *  Created by Adam Duke on 10/20/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "MBProgressHUD.h"
#import "UIViewController+MBProgressHUD.h"
#import <objc/runtime.h>
#import "SPActionUtility.h"
/* This key is used to dynamically create an instance variable
 * within the MBProgressHUD category using objc_setAssociatedObject
 */
const char *progressHUDKey = "progressHUDKey";

/* This key is used to dynamically create an instance variable
 * within the MBProgressHUD category using objc_setAssociatedObject
 */
const char *finishedHandlerKey = "finishedHandlerKey";

@interface UIViewController (MBProgressHUD_Private)

@property (nonatomic, retain) MBProgressHUD *progressHUD;
@property (nonatomic, copy) HUDFinishedHandler finishedHandler;

@end

@implementation UIViewController (MBProgressHUD)

- (MBProgressHUD *)progressHUD
{
    MBProgressHUD *hud = objc_getAssociatedObject(self, progressHUDKey);
    if(!hud)
    {
//        NSUInteger windowsSum = [UIApplication sharedApplication].windows.count;
        UIView *hudSuperView = nil;
//        if (windowsSum > 1) {
            hudSuperView = [[UIApplication sharedApplication].windows objectAtIndex:0];
//        } else {
//            hudSuperView = self.view;
//        }
        
        hud = [[[MBProgressHUD alloc] initWithView:hudSuperView] autorelease];
        hud.dimBackground = NO;
        hud.removeFromSuperViewOnHide = YES;
        [hudSuperView addSubview:hud];
        self.progressHUD = hud;
        
//        UIView *hudSuperView = self.view;
//        hud = [[[MBProgressHUD alloc] initWithView:hudSuperView] autorelease];
//        hud.dimBackground = NO;
//        hud.removeFromSuperViewOnHide = YES;
//        [hudSuperView addSubview:hud];
//        self.progressHUD = hud;
    }
    return hud;
}

- (void)setProgressHUD:(MBProgressHUD *)progressHUD
{
    objc_setAssociatedObject(self, progressHUDKey, progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HUDFinishedHandler)finishedHandler
{
    HUDFinishedHandler block = objc_getAssociatedObject(self, finishedHandlerKey);
    return block;
}

- (void)setFinishedHandler:(HUDFinishedHandler)completionBlock
{
    objc_setAssociatedObject(self, finishedHandlerKey, completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)_showHUDWithMessage:(NSString *)message
{
    self.progressHUD.labelText = message;
    if(self.progressHUD.taskInProgress)
    {
        return;
    }
    self.progressHUD.taskInProgress = YES;
    [self.progressHUD show:YES];
}

- (void)showHUD
{
     
    [self _showHUDWithMessage:nil];
 
}

- (void)showHUDWithAutoreleasePool
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self showHUD];
    [pool release];
}

- (void)showHUDWithMessage:(NSString *)message
{
    [self _showHUDWithMessage:message];
}

- (void)hideHUD
{
    if(!self.progressHUD.taskInProgress)
    {
        return;
    }
    self.progressHUD.taskInProgress = NO;
    [self.progressHUD hide:YES];
    self.progressHUD = nil;
}

- (void)hideHUDWithAutoreleasePool
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self hideHUD];
    [pool release];
}

- (void)hideHUDWithCompletionMessage:(NSString *)message
{
    self.progressHUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	self.progressHUD.mode = MBProgressHUDModeCustomView;
    self.progressHUD.labelText = message;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
}

- (void)hideHUDWithFailedMessage:(NSString *)message
{
    self.progressHUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x.png"]] autorelease];
	self.progressHUD.mode = MBProgressHUDModeCustomView;
    self.progressHUD.labelText = message;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
}

- (void)hideHUDWithCompletionMessage:(NSString *)message finishedHandler:(HUDFinishedHandler)finishedHandler
{
    self.progressHUD.delegate = self;
    self.finishedHandler = finishedHandler;
    [self hideHUDWithCompletionMessage:message];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if(self.finishedHandler)
    {
        self.finishedHandler();
        self.finishedHandler = nil;
    }
    self.progressHUD.delegate = nil;
}

@end
