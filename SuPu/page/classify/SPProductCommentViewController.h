//
//  SPProductCommentViewController.h
//  SuPu
//
//  Created by 杨福军 on 12-11-4.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OUOBaseTableViewController.h"
#import "SPProductCommentListAction.h"

@interface SPProductCommentViewController : SPBaseViewController<SPProductCommentListActionDelegate,UITableViewDataSource,UITableViewDelegate>{

    int currentPageNumber;
}

 

@property(nonatomic,retain)NSString *goodsSN;
@property(nonatomic,retain)UITableView *tableView;

@property(nonatomic,retain) SPPageInfoData *pageInfo;

@end
