//
//  SPBabyBibleArticleDetailViewController.h
//  SuPu
//
//  Created by 杨福军 on 12-10-31.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OUOBaseTableViewController.h"
#import "SPArticleDetailAction.h"

@interface SPBabyBibleArticleDetailViewController : SPBaseViewController<SPArticleDetailActionDelegate,UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIView *webviewfather;

- (id)initWithArticleID:(NSString *)identifier;

@end
