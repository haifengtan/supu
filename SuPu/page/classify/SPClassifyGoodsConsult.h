//
//  SPClassifyGoodsConsult.h
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPClassifyGoodsConsultAction.h"

@interface SPClassifyGoodsConsult : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,SPClassifyGoodsConsultActionDelegate>{
    SPClassifyGoodsConsultAction *consultAction;
}

@property (retain, nonatomic) NSString *goodssn;

@end
