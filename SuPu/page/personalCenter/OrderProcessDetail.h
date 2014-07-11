//
//  OrderProcessDetail.h
//  SuPu
//
//  Created by cc on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"

@interface OrderProcessDetail : SPBaseViewController
<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSArray *processarr;

@end
