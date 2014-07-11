//
//  TKCustomMiddleLineLable.m
//  BanggoMall
//
//  Created by Guwei.Z on 11-2-26.
//  Copyright 2011 ccs.com All rights reserved.
//

#import "YKCustomMiddleLineLable.h"


@implementation YKCustomMiddleLineLable

@synthesize enabled_middleLine;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.enabled_middleLine = YES;
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)drawRect:(CGRect)rect {
	
	if ( enabled_middleLine == YES) {
		CGSize sizeToDraw = [self.text sizeWithFont:self.font];
		CGContextRef ctx = UIGraphicsGetCurrentContext();
        /*
        UIColor *uicolor = self.textColor;
        CGFloat R, G, B;
        CGColorRef color = [uicolor CGColor];
        int numComponents = CGColorGetNumberOfComponents(color);
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color);
            R = components[0];
            G = components[1];
            B = components[2];
            CGContextSetRGBStrokeColor(ctx, R, G, B, 1.0f); // RGBA
        } else if (numComponents == 2) {
            const CGFloat *components = CGColorGetComponents(color);
            R = components[0];
            G = components[0];
            B = components[1];
        } else {
            CGContextSetRGBStrokeColor(ctx, 152.0/255.0, 154.0/255.0, 158.0/255.0, 1.0f); // RGBA
        }
		*/
        CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);
        
		CGContextSetLineWidth(ctx, 1.5f);
		float x_start = 0 ;
		if ( self.textAlignment == UITextAlignmentLeft) {
			x_start = 0;
		}else if ( self.textAlignment == UITextAlignmentCenter) {
			x_start = ( self.bounds.size.width-sizeToDraw.width )/2;
		}else if ( self.textAlignment == UITextAlignmentRight){
			x_start = ( self.bounds.size.width-sizeToDraw.width );
		}

		CGContextMoveToPoint(ctx, x_start, self.bounds.size.height/2 );
		CGContextAddLineToPoint(ctx, sizeToDraw.width+x_start, self.bounds.size.height/2 );
		
		CGContextStrokePath(ctx);
	} 
    [super drawRect:rect];  
}

@end
