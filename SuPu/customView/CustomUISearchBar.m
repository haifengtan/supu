//
//  CustomUISearchBar.m
//  SuPu
//
//  Created by 持创 on 13-3-25.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "CustomUISearchBar.h"

@implementation CustomUISearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect {
    [[[self subviews] objectAtIndex:0] setAlpha:0.0];
    UIImage *image = [UIImage imageNamed: @"搜索栏"];
    if (iPad) {
        image = [UIImage imageNamed: @"search_bar"];
    }
    
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
