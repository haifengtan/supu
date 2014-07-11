//
//  LoginViewController.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"
#import "SPDeviceAction.h"
@interface LoginViewController : SPBaseViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SSPDeviceActionDelegate>

@property (copy, nonatomic) void (^LoginSuccessBlock)(void);

@end
