//
//  SPAddressManagerViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#import "SPAddressListAction.h"
#import "SPAddressDeleteAction.h"

@protocol SPAddressManagerDelegate
-(void)passAddressListData:(SPAddressListData *)list;
@end

@interface SPAddressManagerViewController : SPBaseTableViewController<SPAddressListActionDelegate,SPAddressDeleteActionDelegate>{
    SPAddressListAction *listAction;
    SPAddressDeleteAction *deleAction;
    BOOL isEdit;
    id<SPAddressManagerDelegate> addressListDelegate;
}
@property(nonatomic,assign)id<SPAddressManagerDelegate> addressListDelegate;

@property(nonatomic,retain)NSString *consigneeId;
@property(nonatomic)   BOOL isEdit;
@end
