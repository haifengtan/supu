//
//  SPCategoryViewController.h
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPCategoryListAction.h"
#import "SPBrandListAction.h"

@interface SPCategoryViewController : SPBaseViewController<SPBrandListActionDelegate,SPCategoryListActionDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *m_tableView;
@property(nonatomic,retain)NSString *m_str_categoryID;
@property(nonatomic,retain)NSString *m_str_parentID;
@property(nonatomic,retain)NSArray *m_arr_category;
@property(nonatomic,retain)NSString *m_str_title;

@property(nonatomic,retain)SPCategoryListAction *m_action_category;//品类
@property(nonatomic,retain)SPBrandListAction *m_action_brand;//品牌
@end
