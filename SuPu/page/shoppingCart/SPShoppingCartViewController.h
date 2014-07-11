//
//  SPShoppingCartViewController.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPShoppingCartAction.h"
#import "SPUpdateShopCartAction.h"
#import "TPKeyboardAvoidingTableView.h"

@class SPShoppingCartData;
@interface SPShoppingCartViewController : SPBaseViewController<SPUpdateShopCartActionDelegate,UITextFieldDelegate,SPShoppingCartActionDelegate>{

    UIBarButtonItem *leftBarBtn;

    
    BOOL barstate;
    
    NSString *slabelContent;
    SPShoppingCartAction *shopCartAction;
    SPUpdateShopCartAction *updateAction;
    SPShoppingCartData *shopCartData;
    
    BOOL   isDelete;
    
    NSString *deleGoodSN;
    
    UITextField *m_textField_current;
    
    BOOL isRefresh;
    
    BOOL isSubmit;
}
@property(nonatomic,retain) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property(nonatomic,retain) IBOutlet UIImageView *clearShopCartImageView;
@property(nonatomic,retain) IBOutlet UILabel *tipLabel;
@property(nonatomic,retain) IBOutlet UIView *bottomlabel;
@property(nonatomic,retain) IBOutlet UILabel *discountlabel;


@end
