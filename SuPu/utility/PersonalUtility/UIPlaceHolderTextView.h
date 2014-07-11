//
//  UIPlaceHolderTextView.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, retain) UIFont *placeholderfont;
@property (nonatomic) UIControlContentHorizontalAlignment placeHolderLabelHorizontalAlignment;
@property (nonatomic) UIControlContentVerticalAlignment placeHolderLabelVerticalAlignment;

- (void)textChanged:(NSNotification *)notification;

@end
