

#import "CustomPageControl.h"



@implementation CustomPageControl

@synthesize currentPage;
@synthesize numberOfPages;
@synthesize defersCurrentPageDisplay;
@synthesize hidesForSinglePage;
@synthesize wrap;
@synthesize otherColour;
@synthesize currentColor;
@synthesize controlSize;
@synthesize controlSpacing;





- (void)setup
{	
    //needs redrawing if bounds change
    //this isn't a private method, but using KVC avoids having to import <QuartzCore>
    [self.layer setValue:[NSNumber numberWithBool:YES] forKey:@"needsDisplayOnBoundsChange"];
    
	//set defaults
    self.currentColor = [UIColor whiteColor];
	self.otherColour = [UIColor colorWithWhite:0.0 alpha:0.25];
	controlSpacing = 10.0;
	controlSize = 6.0;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		[self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		[self setup];
	}
	return self;
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    CGFloat width = controlSize + (controlSize + controlSpacing) * (numberOfPages - 1);
    return CGSizeMake(width, fmax(controlSize, 36));
}

- (void)updateCurrentPageDisplay
{
    if (defersCurrentPageDisplay)
    {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
	if (numberOfPages > 1 || !hidesForSinglePage)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		CGFloat width = [self sizeForNumberOfPages:numberOfPages].width;
		CGFloat offset = (self.frame.size.width - width) / 2;
		
		for (int i = 0; i < numberOfPages; i++)
		{
			CGContextSetFillColorWithColor(context, [(i == currentPage)? currentColor: otherColour CGColor]);
			CGContextFillEllipseInRect(context, CGRectMake(offset + (controlSize + controlSpacing) * i, (self.frame.size.height / 2) - (controlSize / 2), controlSize, controlSize));
		}
	}
}

- (NSInteger)clampedPageValue:(NSInteger)page
{
	if (wrap)
    {
        return (page + numberOfPages) % numberOfPages;
    }
    else
    {
        return MIN(MAX(0, page), numberOfPages - 1);
    }
}

- (void)setCurrentPage:(NSInteger)page
{
    currentPage = [self clampedPageValue:page];
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)pages
{
	if (numberOfPages != pages)
    {
        numberOfPages = pages;
        if (currentPage >= numberOfPages)
        {
            currentPage = numberOfPages - 1;
        }
        [self setNeedsDisplay];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint point = [touch locationInView:self];
	currentPage = [self clampedPageValue:currentPage + ((point.x > self.frame.size.width/2)? 1: -1)];
    if (!defersCurrentPageDisplay)
    {
        [self setNeedsDisplay];
    }
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	return [super beginTrackingWithTouch:touch withEvent:event];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(self.superview.bounds.size.width, [self sizeForNumberOfPages:1].height);
}

- (void)dealloc
{	
	[currentColor release];
	[otherColour release];	
    [super dealloc];
}

@end
