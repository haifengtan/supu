//
//  NSString+OUOExtensions.m
//  OUOKit
//
//  Created by 杨福军 on 12-9-5.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

#import "NSString+OUOExtensions.h"

@implementation NSString (OUOExtensions)

- (BOOL)isEmpty {
	return [[self trimSpaces] isEqualToString:@""];
}

- (NSString *)trimSpaces {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r\t "]];
}


- (NSString *)trim:(NSString*)chars {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:chars]];
}

@end
