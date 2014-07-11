//
//  NSString+Category.m
//  SuPu
//
//  Created by xingyong on 13-3-15.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSString*) URLEncode{
	
//	NSString *encodedString = (  NSString *)CFURLCreateStringByAddingPercentEscapes(
//                                                                                                    NULL,
//                                                                                                    (  CFStringRef)self,
//                                                                                                    NULL,
//                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                                                                    kCFStringEncodingUTF8 );
//	
//	return encodedString;
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) self, NULL, (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ", kCFStringEncodingUTF8);
    return [(NSString *) encoded autorelease];
	//return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}

@end
