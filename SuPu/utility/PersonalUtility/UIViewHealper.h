//
//  UIViewHealper.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewHealper : UIView

+ (void)helperBasicASIFailUIAlertView;

+ (void)helperBasicUIAlertView:(NSString *)title message:(NSString *)message;

+ (void)helperBasicUIAlertViewUseJsonResult:(NSString *)title jsonresult:(NSString *)jsonresult;

+ (UILabel *)createNoDataLabel:(CGRect)bounds title:(NSString *)title;

@end
