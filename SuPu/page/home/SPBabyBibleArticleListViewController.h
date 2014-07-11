//
//  SPBabyBibleArticleListViewController.h
//  SuPu
//
//  Created by 杨福军 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OUOBaseTableViewController.h"
#import "SPArticleListAction.h"

@interface SPBabyBibleArticleListViewController : OUOBaseTableViewController<SPArticleListActionDelegate>

- (id)initWithCategoryID:(NSString *)cateID;

@end
