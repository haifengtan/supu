//
//  OUOSearchBar.m
//  SuPu
//
//  Created by 杨福军 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OUOSearchBar.h"

@implementation OUOSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    if (backgroundColor == [UIColor clearColor]) {
        for (UIView *subview in self.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [subview removeFromSuperview];
                break;
            }
        }
    }
}

@end
