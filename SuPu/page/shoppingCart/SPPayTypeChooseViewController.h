//
//  SPPayTypeChooseViewController.h
//  SuPu
//
//  Created by cc on 13-1-5.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "UPPayPluginDelegate.h"
#import "SPUPPayPluginAction.h"
@interface SPPayTypeChooseViewController : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UPPayPluginDelegate,SPUPPayPluginActionDelegate>
{
//    UIActivityIndicatorView *indicator;
//    UIAlertView* alertView;
    SPUPPayPluginAction *payPluginAction;
}
@property(nonatomic,retain)NSString *orderNo;
@property(nonatomic,retain)NSString *orderAmount;
@end
