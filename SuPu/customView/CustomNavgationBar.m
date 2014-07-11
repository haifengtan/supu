//
//  CustomNavgationBar.m
//  SuPu
//
//  Created by cc on 12-12-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "CustomNavgationBar.h"

@implementation CustomNavgationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGRect barFrame = self.frame;
//    if (iPad) {
//        barFrame.size.height = 70;
//    }
//    self.frame = barFrame;
//}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (iPad) {
        UIImage *image = [UIImage imageNamed:@"titlebar.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }else{
        UIImage *image = [UIImage imageNamed:@"信息栏.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}


@end
