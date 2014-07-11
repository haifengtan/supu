//
//  UIView+OUOExtensions.h
//  OUOKit
//
//  Created by 杨福军 on 12-9-4.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO:增加更多的测量准则
typedef enum {
    OUOViewDistanceMeasureGuidelineLeftToLeft,      //从左边到左边
    OUOViewDistanceMeasureGuidelineLeftToRight,     //从左边到右边
    OUOViewDistanceMeasureGuidelineTopToTop,       //从顶边到顶边
    OUOViewDistanceMeasureGuidelineTopToButtom    //从顶边到底边
} OUOViewDistanceMeasureGuideline;

@interface UIView (OUOExtensions)

///////////////////////////////////////////////////////
#pragma mark - 位置、大小

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

-(void)verticalCenterInView:(UIView*)aView;
-(void)horizontalCenterInView:(UIView*)aView;
-(void)rightAlignInView:(UIView*)aView margin:(CGFloat)margin;
-(void)bottomAlignInView:(UIView*)aView margin:(CGFloat)margin;

///////////////////////////////////////////////////////
#pragma mark - 层级

-(int)getSubviewIndex;

-(void)bringToFront;
-(void)sentToBack;

-(void)bringOneLevelUp;
-(void)sendOneLevelDown;

-(BOOL)isInFront;
-(BOOL)isAtBack;

-(void)swapDepthsWithView:(UIView*)swapView;

///////////////////////////////////////////////////////
#pragma mark - NIB

+ (id)loadFromNIB;

///////////////////////////////////////////////////////
#pragma mark -

- (void)removeAllSubviews;

///////////////////////////////////////////////////////
#pragma mark -

/**
 * 锁定到目标视图之间的距离
 *
 * @param  distance  距离
 * @param  targetView  目标视图
 * @param  guideline  距离的测量准则（从哪条边到哪条边的距离）
 */
- (void)lockDistance:(CGFloat)distance
              toView:(UIView *)targetView
    measureGuideline:(OUOViewDistanceMeasureGuideline)guideline;

- (void)alwaysCenterInContainerHorizontally:(BOOL)horizontally
                                  vetically:(BOOL)vertically;
@end
