//
//  SPHomeViewController.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPHomeTopAction.h"
#import "SPHomeAction.h"
#import "CustomPageControl.h"
#import "SPAppDelegate.h"
#import "ZBarSDK.h"
#import "CustomUISearchBar.h"
@interface SPHomeViewController : SPBaseViewController<SPHomeActionDelegate, SPHomeTopActionDelegate,UISearchBarDelegate,ZBarReaderDelegate,UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIToolbar *headerToolBar;
@property (retain, nonatomic) IBOutlet CustomUISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UIView *headerBar;
@property (retain, nonatomic) IBOutlet OUOScrollView *newsScrollView;
@property (retain, nonatomic) IBOutlet UIView *scorllfatherview;
@property (retain, nonatomic) IBOutlet UIButton *m_btn_tiaoma;

- (IBAction)bibleButtonPressed:(id)sender;
//- (IBAction)onButtonActionOutSide:(id)sender;
-(BOOL)isAvaild:(NSString *)str;
- (IBAction)zBarItemMessage:(id)sender;

@end
