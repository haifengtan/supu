//
//  OUOValidator.m
//  SportsTogether
//
//  Created by 杨福军 on 12-8-28.
//
//

#import "OUOValidator.h"

@implementation OUOValidator

+ (BOOL)validateEmailAddress:(NSString *)input
{
    NSString *emailRegex = @"^[[:alnum:]!#$%&'*+/=?^_`{|}~-]+((\\.?)[[:alnum:]!#$%&'*+/=?^_`{|}~-]+)*@[[:alnum:]-]+(\\.[[:alnum:]-]+)*(\\.[[:alpha:]]+)+$";
    
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:input];
}

+ (BOOL)validatePhoneNumber:(NSString *)input {
    NSString *phoneRegex = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})";
    
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phonePredicate evaluateWithObject:input];
}

+ (BOOL)validateMobilePhoneNumber:(NSString *)input {
    NSString *phoneRegex = @"^(13[0-9]|15[0-9]|18[0-9])\\d{8}$";
    
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phonePredicate evaluateWithObject:input];
}

+ (BOOL)validateNONEmptyString:(NSString *)string {
    return [string isEmpty];
}

+ (BOOL)validateNONEmptyStrings:(NSArray *)strings {
    __block BOOL valid = YES;
    [strings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString *)obj isEmpty]) {
            valid = NO;
            *stop = YES;
        }
    }];
    return valid;
}

@end
