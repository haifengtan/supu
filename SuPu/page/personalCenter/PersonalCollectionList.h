//
//  PersonalCollectionList.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"
#import "PersonalColletion.h"
#import "CollectionListCell.h"
#import "SPCollectAction.h"
@interface PersonalCollectionList : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,SPCollectActionDelegate>{
    SPCollectAction *collectAction;
}

@end
