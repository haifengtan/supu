//
//  afaa.m
//  OUOKit
//
//  Created by 杨福军 on 12-9-5.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

#import "OUOFunctions.h"

static inline BOOL ouoIsEmpty(id thing) {
	return thing == nil ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

BOOL ouoAnyEmpty(id obj, ...) {
	id v;
	va_list argumentList;
	if (obj) {
		NSMutableArray* list = [NSMutableArray arrayWithObject:obj];
		va_start(argumentList, obj);
		while ((v = va_arg(argumentList, id))) {
			[list addObject:v];
		}
		va_end(argumentList);
        
		for (id each in list) {
			if (ouoIsEmpty(each)) return YES;
		}
	}
    
	return NO;
}


UIButton *OUOButtonMake(NSString *imageName, SEL handler, id target) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:OUO_IMAGE(OUO_STRING_FORMAT(@"%@_normal", imageName)) forState:UIControlStateNormal];
    [button setBackgroundImage:OUO_IMAGE(OUO_STRING_FORMAT(@"%@_selected", imageName)) forState:UIControlStateSelected];
    [button setBackgroundImage:OUO_IMAGE(OUO_STRING_FORMAT(@"%@_highLight", imageName)) forState:UIControlStateHighlighted];
    button.frame = OUO_RECT(0., 0., button.currentBackgroundImage.size.width / 2, button.currentBackgroundImage.size.height / 2);
    [button addTarget:target action:handler forControlEvents:UIControlEventTouchUpInside];
    return button;
}
