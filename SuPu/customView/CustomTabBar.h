//
//  RumexCustomTabBar.h
//  
//
//  Created by Oliver Farago on 19/06/2010.
//  Copyright 2010 Rumex IT All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UITabBarController {
	UIButton *firstbtn;
	UIButton *secondbtn;
	UIButton *thridbtn;
	UIButton *fourtybtn;
    UIButton *fivtybtn;
}

@property (nonatomic, retain) UIButton *firstbtn;
@property (nonatomic, retain) UIButton *secondbtn;
@property (nonatomic, retain) UIButton *thridbtn;
@property (nonatomic, retain) UIButton *fourtybtn;
@property (nonatomic, retain) UIButton *fivtybtn;

-(void)hideTabBar;
-(void) addCustomElements;
-(void) selectTab:(int)tabID;
- (void)buttonClicked:(id)sender;


@end
