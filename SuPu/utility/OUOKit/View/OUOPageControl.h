//
//  OUOPageControl.h
//  QiMeiLady
//
//  Created by user on 12-9-11.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OUOPageControl : UIPageControl {
 @private
    UIImage* activeImage_;
    UIImage* inactiveImage_;
}

@property (retain, nonatomic) UIImage *activeImage;
@property (retain, nonatomic) UIImage *inactiveImage;

@end
