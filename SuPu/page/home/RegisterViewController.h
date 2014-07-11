//
//  RegisterViewController.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface RegisterViewController : SPBaseViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate>

@property (copy, nonatomic) void (^registerSuccessBlock)(void);

@end
