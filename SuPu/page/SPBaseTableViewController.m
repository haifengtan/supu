//
//  SPBaseTableViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#define CELL_IDENTIFIER @"CELL_IDENTIFIER"
@interface SPBaseTableViewController ()

@property BOOL isPad;

@end

@implementation SPBaseTableViewController
@synthesize navTitle=_navTitle;
@synthesize isPad;
///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(_tableView);

    [super dealloc];
}


///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{
  
    
    [super viewDidLoad];

      self.isPad = iPad;
    if (self.isPad) {
        _tableView = [[SPBaseTableView alloc] initWithFrame:OUO_RECT(0, 0, 768, 860) style:UITableViewStyleGrouped];
    }else{
        _tableView = [[SPBaseTableView alloc] initWithFrame:OUO_RECT(0, 0, 320, [SPStatusUtility getScreenHeight] - kTabbarHeight - kNavHeight - 20) style:UITableViewStyleGrouped];
    }
    
    //如果系统版本大于ios  table上移  2014-7-14
       if (IS_IOS7) {
           CGRect tableFarm=_tableView.frame;
            _tableView.frame = CGRectMake(tableFarm.origin.x,tableFarm.origin.y-35, tableFarm.size.width, tableFarm.size.height+35);
        }
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.frame = 
//    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
}

- (void)viewDidUnload
{
    _tableView=nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
