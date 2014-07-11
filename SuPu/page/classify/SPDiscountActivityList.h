//
//  SPDiscountActivityList.h
//  SuPu
//
//  Created by cc on 12-11-7.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"

@interface SPDiscountActivityList : SPBaseViewController
<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSArray *discountactivityarr;

@end
