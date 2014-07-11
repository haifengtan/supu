//
//  UIPlaceHolderTextView.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView
@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;
@synthesize placeholderfont;
@synthesize placeHolderLabelHorizontalAlignment;
@synthesize placeHolderLabelVerticalAlignment;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [placeHolderLabel release]; placeHolderLabel = nil;
    [placeholderColor release]; placeholderColor = nil;
    [placeholder release]; placeholder = nil;
    [placeholderfont release];placeholderfont = nil;
    [super dealloc];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification

{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }else{
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}


- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            CGSize labelsize = [self.placeholder sizeWithFont:self.placeholderfont constrainedToSize:CGSizeMake(self.bounds.size.width, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
            float x;
            float y;
            float width = labelsize.width;
            float height = labelsize.height;
            if (self.placeHolderLabelHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                x = 10;
            }
            if (self.placeHolderLabelHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) {
                x = (self.bounds.size.width - width)/2;
            }
            if (self.placeHolderLabelHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                x = self.bounds.size.width - width - 10;
            }
            if (self.placeHolderLabelVerticalAlignment == UIControlContentVerticalAlignmentTop) {
                y = 10;
            }
            if (self.placeHolderLabelVerticalAlignment == UIControlContentVerticalAlignmentCenter) {
                y = (self.bounds.size.height - height)/2;
            }
            if (self.placeHolderLabelVerticalAlignment == UIControlContentVerticalAlignmentBottom) {
                y = self.bounds.size.height - height - 10;
            }
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,width,height)];
            placeHolderLabel.lineBreakMode = UILineBreakModeWordWrap;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = self.font;
            [placeHolderLabel setFont:self.placeholderfont];
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
           
        } 
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )    
    {   
        [[self viewWithTag:999] setAlpha:1];   
    }
    [super drawRect:rect];
}

@end
