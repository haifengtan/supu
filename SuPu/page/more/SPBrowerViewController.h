//
//  SPBrowerViewController.h
//  SuPu
//
//  Created by xx on 12-11-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SPBrowerViewController : SPBaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *m_tableView;
@property(nonatomic,retain)NSArray *m_arr_brower;

@property (retain, nonatomic) IBOutlet UILabel *m_label_noResult;
-(void)clearBrowerData;
@end
