//
//  CheckHelper.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-11.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "CheckHelper.h"

@implementation CheckHelper

+ (BOOL)helperTextFieldCheckNull:(UITextField *)field fieldtitle:(NSString *)fieldtitle
{
    BOOL result = YES;
    if (field.text == nil) {
        result =  NO;
    }else {
        NSMutableString *textstr = [[NSMutableString alloc] init];
        [textstr appendString:field.text];
        if (textstr.length == 0) {
            result = NO;
        }else {
            CFStringTrimWhitespace((CFMutableStringRef)textstr);
            if ([textstr isEqual:@""]) {
                result = NO;
            }
        }
        [textstr release];
    }
    if (result == NO) {
        NSString *alertmessage = [[NSString alloc] initWithFormat:@"%@不能为空",fieldtitle];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:alertmessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
        [alertmessage release];
    }
    return result;
}

+ (BOOL)helperTextFieldCheckWithRegex:(UITextField *)field regex:(NSString *)regex wrongmessage:(NSString *)wrongmessage
{
    BOOL result = YES;
    if (field.text == nil) {
        result =  NO;
    }else {
        NSMutableString *textstr = [[NSMutableString alloc] init];
        [textstr appendString:field.text];
        if (textstr.length == 0) {
            result = NO;
        }else {
            CFStringTrimWhitespace((CFMutableStringRef)textstr);
            if ([textstr isEqual:@""]) {
                result = NO;
            }
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if (![predicate evaluateWithObject:textstr]) {
            result = NO;
        }
        [textstr release];
    }
    if (result == NO) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:wrongmessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
    }
    return result;
}

+ (BOOL)helperTextViewCheckNull:(UITextView *)textview viewtitle:(NSString *)viewtitle
{
    BOOL result = YES;
    if (textview.text == nil) {
        result =  NO;
    }else {
        NSMutableString *textstr = [[NSMutableString alloc] init];
        [textstr appendString:textview.text];
        if (textstr.length == 0) {
            result = NO;
        }else {
            CFStringTrimWhitespace((CFMutableStringRef)textstr);
            if ([textstr isEqual:@""]) {
                result = NO;
            }
        }
        [textstr release];
    }
    if (result == NO) {
        NSString *alertmessage = [[NSString alloc] initWithFormat:@"%@不能为空",viewtitle];
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:alertmessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
        [alertmessage release];
    }
    return result;
}

+ (BOOL)helperTextFieldCheckPassword:(UITextField *)passwordtextfield verifypasswordtextfield:(UITextField *)verifypasswordfield
{
    BOOL result = YES;
    if (passwordtextfield.text == nil ) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
        result = NO;
    }else if(verifypasswordfield.text == nil){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
        result = NO;
    }else {
        NSMutableString *password = [[NSMutableString alloc] init];
        [password appendString:passwordtextfield.text];
        NSMutableString *verifypassword = [[NSMutableString alloc] init];
        [verifypassword appendString:verifypasswordfield.text];
        if (password!=nil && password.length >0) {
            CFStringTrimWhitespace((CFMutableStringRef)password);
        }
        if (verifypassword!=nil && verifypassword.length >0) {
            CFStringTrimWhitespace((CFMutableStringRef)verifypassword);
        }
        if ([password isEqual:@""]) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
            [alertview release];
            result = NO;
        }else if([verifypassword isEqual:@""]){
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
            [alertview release];
            result = NO;
        }else if (![password isEqual:verifypassword]) {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码必须一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertview show];
            [alertview release];
            result = NO;
        }
        [password release];
        [verifypassword release];
    }
    return result;
}

+ (BOOL)helperTextFieldCheckEmail:(UITextField *)emailtextfield
{
    BOOL result = YES;
    NSString *emailregex = [[NSString alloc] initWithFormat:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
    NSPredicate *emailpredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailregex];
    [emailregex release];
    if (![emailpredicate evaluateWithObject:emailtextfield.text]) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
        [alertview release];
        result = NO;
    }
    return result;
}

@end
