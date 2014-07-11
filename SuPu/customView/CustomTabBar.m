//
//  RumexCustomTabBar.m
//  
//
//  Created by Oliver Farago on 19/06/2010.
//  Copyright 2010 Rumex IT All rights reserved.
//

#import "CustomTabBar.h"
#import "SPAppDelegate.h"

#define buttonHeight 49

@implementation CustomTabBar
@synthesize firstbtn;
@synthesize secondbtn;
@synthesize thridbtn;
@synthesize fourtybtn;
@synthesize fivtybtn;

- (id)init {
    if (self = [super init]) {
        [self hideTabBar];
        [self addCustomElements];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)hideTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
            view.backgroundColor = [UIColor clearColor];
			view.hidden = YES;
			break;
		}
	}
}

-(void)addCustomElements
{
    if (iPad) {
        UIImageView *mainMenuBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 924, 768, 100)];
//        mainMenuBG.backgroundColor=[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0];
        [mainMenuBG setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar" ofType:@"png"]]];
        [self.view addSubview:mainMenuBG];
        [mainMenuBG release];
        
        // Initialise our two images
        UIImage *btnImage;
        UIImage *btnImageSelected;
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_home_off" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_home_on" ofType:@"png"]];
        self.firstbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        firstbtn.frame = CGRectMake(1, 925, 153, 99);
        [firstbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [firstbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [firstbtn setTag:0];
        
        // Now we repeat the process for the other buttons
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_classify_off" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_classify_on" ofType:@"png"]];
        self.secondbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secondbtn.frame = CGRectMake(154, 925, 153, 99);
        [secondbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [secondbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [secondbtn setTag:1];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_shopping_off" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_shopping_on" ofType:@"png"]];
        self.thridbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thridbtn.frame = CGRectMake(307, 925, 153, 99);
        [thridbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [thridbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [thridbtn setTag:2];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_member_off" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_member_on" ofType:@"png"]];
        self.fourtybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fourtybtn.frame = CGRectMake(460, 925, 153, 99);
        [fourtybtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [fourtybtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [fourtybtn setTag:3];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_more_off" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"softkeybar_more_on" ofType:@"png"]];
        self.fivtybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fivtybtn.frame = CGRectMake(613, 925, 153, 99);
        [fivtybtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [fivtybtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [fivtybtn setTag:4];
    }else{
//        NSString *deviceStr = [SPStatusUtility deviceString];
//        
//        BOOL isIphone5 = [deviceStr isEqualToString:@"iPhone 5"]? YES :NO;
         
 
        UIImageView *mainMenuBG = [[UIImageView alloc] initWithFrame:CGRectMake(0,[SPStatusUtility getScreenHeight]-buttonHeight , 320, buttonHeight)];
        
 
        [mainMenuBG setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"栏_未选中" ofType:@"png"]]];
        [self.view addSubview:mainMenuBG];
        [mainMenuBG release];
        
        // Initialise our two images
        UIImage *btnImage = nil;
        UIImage *btnImageSelected = nil;
        
        CGFloat buttonY = [SPStatusUtility getScreenHeight] - buttonHeight;
        

        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"首页_未选中" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"首页_选中" ofType:@"png"]];
        self.firstbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        firstbtn.frame = CGRectMake(0, buttonY, 64, buttonHeight);
        [firstbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [firstbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [firstbtn setTag:0];
        
        // Now we repeat the process for the other buttons
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分类_未选中" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分类_选中" ofType:@"png"]];
        self.secondbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secondbtn.frame = CGRectMake(64, buttonY, 64, buttonHeight);
        [secondbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [secondbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [secondbtn setTag:1];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"购物车_未选中" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"购物车_选中" ofType:@"png"]];
        self.thridbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thridbtn.frame = CGRectMake(128, buttonY, 64, buttonHeight);
        [thridbtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [thridbtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [thridbtn setTag:2];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"会员中心_未选中" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"会员中心_选中" ofType:@"png"]];
        self.fourtybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fourtybtn.frame = CGRectMake(192, buttonY, 64, buttonHeight);
        [fourtybtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [fourtybtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [fourtybtn setTag:3];
        
        btnImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"更多_未选中" ofType:@"png"]];
        btnImageSelected = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"更多_选中" ofType:@"png"]];
        self.fivtybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fivtybtn.frame = CGRectMake(256, buttonY, 64, buttonHeight);
        [fivtybtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [fivtybtn setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
        [fivtybtn setTag:4];
    }

	// Add my new buttons to the view
	[self.view addSubview:firstbtn];
	[self.view addSubview:secondbtn];
	[self.view addSubview:thridbtn];
	[self.view addSubview:fourtybtn];
    [self.view addSubview:fivtybtn];
    
    [firstbtn setSelected:true];

	// Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
	[firstbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[secondbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[thridbtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[fourtybtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fivtybtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(id)sender
{
	int tagNum = [sender tag];
	[self selectTab:tagNum];
}

- (void)selectTab:(int)tabID
{
    DLog(@"tabID:%d", tabID);
	switch(tabID)
	{
		case 0:
            [firstbtn setSelected:YES];
			[secondbtn setSelected:NO];
			[thridbtn setSelected:NO];
			[fourtybtn setSelected:NO];
            [fivtybtn setSelected:NO];
			break;
		case 1:
			[firstbtn setSelected:NO];
            [secondbtn setSelected:YES];
			[thridbtn setSelected:NO];
			[fourtybtn setSelected:NO];
            [fivtybtn setSelected:NO];
			break;
		case 2:
			[firstbtn setSelected:NO];
			[secondbtn setSelected:NO];
			[thridbtn setSelected:YES];
			[fourtybtn setSelected:NO];
            [fivtybtn setSelected:NO];
			break;
		case 3:
			[firstbtn setSelected:NO];
			[secondbtn setSelected:NO];
			[thridbtn setSelected:NO];
			[fourtybtn setSelected:YES];
            [fivtybtn setSelected:NO];
			break;
        case 4:
			[firstbtn setSelected:NO];
			[secondbtn setSelected:NO];
			[thridbtn setSelected:NO];
			[fourtybtn setSelected:NO];
            [fivtybtn setSelected:YES];
			break;
	}
   
    UINavigationController *nav= [KAppDelegate.m_tabBarCtrl.viewControllers objectAtIndex:tabID];
    [self performBlock:^(id sender) {
        [nav popToRootViewControllerAnimated:YES];
    } afterDelay:0.1];
    
    
    //bug:再次点击回到首页
//    if(self.selectedIndex == tabID){
//        [((OUONavigationController *)[self.viewControllers objectAtIndex:tabID]) popToRootViewControllerAnimated:YES];
//    }
 
	self.selectedIndex = tabID;
    
}

- (void)dealloc {
	[firstbtn release];
	[secondbtn release];
	[thridbtn release];
	[fourtybtn release];
    [fivtybtn release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

@end
