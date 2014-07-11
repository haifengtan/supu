//
//  CheckHelper.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckHelper : NSObject

+ (BOOL)helperTextFieldCheckNull:(UITextField *)field fieldtitle:(NSString *)fieldtitle;

+ (BOOL)helperTextFieldCheckWithRegex:(UITextField *)field regex:(NSString *)regex wrongmessage:(NSString *)wrongmessage;

+ (BOOL)helperTextFieldCheckPassword:(UITextField *)passwordtextfield verifypasswordtextfield:(UITextField *)verifypasswordfield;

+ (BOOL)helperTextViewCheckNull:(UITextView *)textview viewtitle:(NSString *)viewtitle;

+ (BOOL)helperTextFieldCheckEmail:(UITextField *)emailtextfield;

@end
