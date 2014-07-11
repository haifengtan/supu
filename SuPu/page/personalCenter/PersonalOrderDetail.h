//
//  PersonalOrderDetail.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "PersonalOrder.h"
#import "SPOrderDetailsAction.h"
@interface PersonalOrderDetail : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,SPOrderDetailsActionDelegate>{
    SPOrderDetailsAction *orderDetailsAction;
}

@property (retain, nonatomic) PersonalOrder *personalorder;
@property (assign,nonatomic) BOOL isStyle;
@property (retain, nonatomic) NSString *orderSN;

@end
