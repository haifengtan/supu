//
//  SPProductLargeImageViewController.h
//  SuPu
//
//  Created by cc on 12-11-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"

@interface SPProductLargeImageViewController : SPBaseViewController
<UIScrollViewDelegate>{
    CGFloat offset;
}
@property (nonatomic, retain) UIScrollView *imageScrollView;
@property (retain, nonatomic) NSURL *imageurl;
@property (retain, nonatomic) NSArray *imageurlArray;
@property (assign, nonatomic) int tapIndex;
- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center;
@end
