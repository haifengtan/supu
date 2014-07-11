//
//  DiscountCardList.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"
#import "SPTableViewDelegate.h"
#import "SPUseCouponsAction.h"
@interface DiscountCardList : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SPUseCouponsActionDelegate>{
    id<SPTableViewDelegate>delegate;
}

@property(nonatomic,assign) id<SPTableViewDelegate>delegate;
@property (retain, nonatomic) NSString *parentcontrolname;
@property (nonatomic,retain) NSString *fromWhereToThis;
@end
