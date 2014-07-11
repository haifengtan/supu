//
//  UIPickerTitleView.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3

@interface UIPickerTitleView : UIActionSheet

@property (retain, nonatomic) NSString *pickviewtitle;
@property (retain, nonatomic) UIPickerView *pickerview;
@property (assign, nonatomic) id delegate;

- (void)showInView:(UIView *)view;

@end
