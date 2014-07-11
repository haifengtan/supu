//
//  OUOPageControl.m
//  QiMeiLady
//
//  Created by user on 12-9-11.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

#import "OUOPageControl.h"

@interface OUOPageControl ()
- (void)customizeDots;
- (void)configure;
@end

@implementation OUOPageControl

@synthesize activeImage = activeImage_;
@synthesize inactiveImage = inactiveImage_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    [activeImage_ release];
    activeImage_ = nil;
    [inactiveImage_ release];
    inactiveImage_ = nil;
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)configure {
    self.hidesForSinglePage = YES;
    self.userInteractionEnabled = NO;
    [self customizeDots];
}

- (void)customizeDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGRect newFrame = dot.frame;
        newFrame.size.width = self.inactiveImage.size.width / 2;
        newFrame.size.height = self.inactiveImage.size.height / 2;
        
        dot.frame = newFrame;
        
        if (i == self.currentPage) {
            dot.image = activeImage_;
        } else {
            dot.image = inactiveImage_;
        }
    }
}

//////////////////////////////////////////////////////////////////
#pragma mark -

- (id)initWithCoder:(NSCoder *)aDecoder
{    
    if (self = [super initWithCoder:aDecoder]) {
        [self configure];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self customizeDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    [super setNumberOfPages:numberOfPages];
    [self customizeDots];
}

@end
