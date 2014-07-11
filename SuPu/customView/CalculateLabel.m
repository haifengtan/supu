//
//  CalculateLabel.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "CalculateLabel.h"

@implementation CalculateLabel
@synthesize slabelContent=_slabelContent;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {

        self.text=@"200";
        
    }
    return self;
}
-(void)setSlabelContent:(NSString *)slabelContent{
    if (slabelContent!=_slabelContent) {
        [_slabelContent release];
        _slabelContent=[slabelContent retain];
        
//        int wordcount = [self textLength:_slabelContent];
        int wordcount = _slabelContent.length;
        
        NSInteger count  = 200 - wordcount;
        if (count < 0)
        {
            count= 0;
            [self setTextColor:[UIColor redColor]];
            
        }
        else
        {
            [self setTextColor:[UIColor blackColor]];
            
        }
        
        [self setText:[NSString stringWithFormat:@"%i",count]];

    }
}
- (int)textLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 
 
 + (void)calculateTextLength:(UILabel *)label contentTextView:(UITextView *)textView{


*/

@end
