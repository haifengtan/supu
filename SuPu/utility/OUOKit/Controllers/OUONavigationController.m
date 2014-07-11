//
//  CMNavigationController.m
//
//  Created by Constantine Mureev on 19.03.12.
//  Copyright (c) 2012 Team Force LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "OUONavigationController.h"
//#import "PrettyNavigationBar.h"
#import "CustomNavgationBar.h"

@interface OUONavigationController ()

- (void)setup;

@end

@implementation OUONavigationController

///////////////////////////////////////////////////////
#pragma mark -

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setup];
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setup {
    self.view.backgroundColor = [UIColor clearColor];
    CustomNavgationBar *navBar = [[CustomNavgationBar alloc] init];
//    PrettyNavigationBar *navBar = [[PrettyNavigationBar alloc] init];
//    navBar.topLineColor = [UIColor clearColor];
//    navBar.bottomLineColor = [UIColor clearColor];
//    navBar.gradientStartColor =  [UIColor colorWithRed:0.83 green:0.00 blue:0.05 alpha:1.00];
//    navBar.gradientEndColor = [UIColor colorWithRed:0.48 green:0.00 blue:0.00 alpha:1.00];
    [self setValue:navBar forKey:@"navigationBar"];
    [navBar release];
}

@end
