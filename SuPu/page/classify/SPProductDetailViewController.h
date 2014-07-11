//
//  SPProductDetailViewController.h
//  SuPu
//
//  Created by 杨福军 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductDetailAction.h"
#import "SPAddToShoppingCartAction.h"
#import "SPAddCollectListAction.h"
//#import "SPClassifyDiscountActivityListAction.h"

@interface SPProductDetailViewController : SPBaseViewController
<SPProductDetailActionDelegate, SPAddToShoppingCartActionDelegate,SPAddCollectListActionDelegate,UIActionSheetDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithGoodsSN:(NSString *)goodsSN;

@end
