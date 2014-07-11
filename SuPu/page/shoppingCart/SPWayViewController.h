//
//  SPWayViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#import "SPPaymentStyleAction.h"
#import "SPTableViewDelegate.h"
@interface SPWayViewController : SPBaseTableViewController<SPPaymentStyleActionDelegate>{
    SPPaymentStyleAction *paymentStyleAction;
    id<SPTableViewDelegate>delegate;

}
@property(nonatomic,assign) id<SPTableViewDelegate>delegate;
@property(nonatomic,retain)  NSString *paymentId;
@property(nonatomic,retain)  NSString *areaId;
@property(nonatomic)   BOOL wayState;
@property(nonatomic, retain)  NSIndexPath * lastIndexPath;
@property(nonatomic, retain) NSString *lastselectname;
@end
