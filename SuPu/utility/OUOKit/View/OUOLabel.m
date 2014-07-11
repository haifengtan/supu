//
//  OUOLabel.m
//  QiMeiLady
//
//  Created by user on 12-9-12.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

#import "OUOLabel.h"

@implementation OUOLabel

@synthesize sizeAdjustMode = sizeAdjustMode_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        sizeAdjustMode_ = OUOLabelAutoAdjustModeNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setText:(NSString *)text {
    [super setText:text];
    
    switch (sizeAdjustMode_) {
        case OUOLabelAutoAdjustModeNone:
        {

        }
            break;
        case OUOLabelAutoAdjustModeWidthToFit:
        {
            self.numberOfLines = 1;
            self.lineBreakMode = UILineBreakModeTailTruncation;
            
            CGFloat newWidth = 0.0f;
            newWidth = [text sizeWithFont:self.font
                         constrainedToSize:CGSizeMake(HUGE_VALF, self.frameHeight)
                             lineBreakMode:self.lineBreakMode].width;
            self.frameWidth = newWidth;
        }
            break;
        case OUOLabelAutoAdjustModeHeightToFit:
        {
            self.numberOfLines = 0;
            self.lineBreakMode = UILineBreakModeWordWrap;
            
            CGFloat newHeight = 0.0f;
            newHeight = [text sizeWithFont:self.font
                         constrainedToSize:CGSizeMake(self.frameWidth, HUGE_VALF)
                             lineBreakMode:self.lineBreakMode].height;
            self.frameHeight = newHeight;
        }
            break;
        default:
            break;
    }
}

@end
