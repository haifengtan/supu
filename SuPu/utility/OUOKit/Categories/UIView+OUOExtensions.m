//
//  UIView+OUOExtensions.m
//  OUOKit
//
//  Created by 杨福军 on 12-9-4.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

#import "UIView+OUOExtensions.h"

@implementation UIView (OUOExtensions)

///////////////////////////////////////////////////////
#pragma mark - 位置、大小

- (void)pixelAlign {
    self.frameX = floorf(self.frameX);
    self.frameY = floorf(self.frameY);
    self.frameWidth = floorf(self.frameWidth);
    self.frameHeight = floorf(self.frameHeight);
}

- (void)verticalCenterInView:(UIView*)aView {
    self.frameY = floorf(aView.frameHeight/2 - self.frameHeight/2);
}

- (void)horizontalCenterInView:(UIView*)aView {
    self.frameX = floorf(aView.frameWidth/2 - self.frameWidth/2);
}

- (void)rightAlignInView:(UIView*)aView margin:(CGFloat)margin {
    self.frameX = aView.frameWidth - self.frameWidth - margin;
}

- (void)bottomAlignInView:(UIView*)aView margin:(CGFloat)margin {
    self.frameY = aView.frameHeight - self.frameHeight - margin;
}

- (CGPoint)frameOrigin {
    return self.frame.origin;
}

- (void)setFrameOrigin:(CGPoint)newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)newSize {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newSize.width, newSize.height);
}

- (CGFloat)frameX {
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)newX {
    self.frame = CGRectMake(newX, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameY {
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)newY {
    self.frame = CGRectMake(self.frame.origin.x, newY,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight {
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom {
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
                            self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            self.frame.size.width, newHeight);
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

///////////////////////////////////////////////////////
#pragma mark - 层级

-(int)getSubviewIndex
{
	return [self.superview.subviews indexOfObject:self];
}

-(void)bringToFront
{
	[self.superview bringSubviewToFront:self];
}

-(void)sentToBack
{
	[self.superview sendSubviewToBack:self];
}

-(void)bringOneLevelUp
{
	int currentIndex = [self getSubviewIndex];
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

-(void)sendOneLevelDown
{
	int currentIndex = [self getSubviewIndex];
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

-(BOOL)isInFront
{
	return ([self.superview.subviews lastObject]==self);
}

-(BOOL)isAtBack
{
	return ([self.superview.subviews objectAtIndex:0]==self);
}

-(void)swapDepthsWithView:(UIView*)swapView
{
	[self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

///////////////////////////////////////////////////////
#pragma mark - NIB

+ (NSString*)nibName {
    return [self description];
}


+ (id)loadFromNIB {
    Class klass = [self class];
    NSString *nibName = [self nibName];
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    
    for (id object in objects) {
        if ([object isKindOfClass:klass]) {
            return object;
        }
    }
    
    [NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one UIView, and its class must be '%@'", nibName, NSStringFromClass(klass)];
    
    return nil;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)removeAllSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [subview removeFromSuperview];
    }];
}

///////////////////////////////////////////////////////
#pragma mark -

//TODO:增加更多的测量准则
- (void)lockDistance:(CGFloat)distance
              toView:(UIView *)targetView
    measureGuideline:(OUOViewDistanceMeasureGuideline)guideline {
    __block typeof(self) bself = self;
    [targetView addObserverForKeyPath:@"frame" task:^(id obj, NSDictionary *change) {
        switch (guideline) {
            case OUOViewDistanceMeasureGuidelineLeftToLeft:
                bself.frameX = targetView.frameX + distance;
                break;
            case OUOViewDistanceMeasureGuidelineLeftToRight:
                bself.frameX = targetView.frameRight + distance;
                break;
            case OUOViewDistanceMeasureGuidelineTopToTop:
                bself.frameY = targetView.frameY + distance;
                break;
            case OUOViewDistanceMeasureGuidelineTopToButtom:
                bself.frameY = targetView.frameBottom + distance;
                break;
            default:
                break;
        }
    }];
}

- (void)alwaysCenterInContainerHorizontally:(BOOL)horizontally
                                  vetically:(BOOL)vertically {
    if (self.superview != nil) {
        [self.superview addObserverForKeyPath:@"frame" task:^(id obj, NSDictionary *change) {
            self.center = CGPointMake(horizontally ? self.superview.frameWidth / 2. : self.center.x, vertically ? self.superview.frameHeight / 2. : self.center.y);
        }];
    }
}

@end
