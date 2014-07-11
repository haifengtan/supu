//
//  UIImageView+Helper.m
//  SuPu
//
//  Created by xingyong on 13-3-27.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "UIImageView+Helper.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImageView (Helper)
-(void)imageViewLayer{
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:1];
    self.userInteractionEnabled = YES;
}
@end
