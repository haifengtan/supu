//
//  SPBaseTableViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPBaseTableView.h"
@interface SPBaseTableViewController : SPBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    SPBaseTableView *_tableView;
    
    
}
@property(nonatomic,retain)NSString *navTitle;
@end
