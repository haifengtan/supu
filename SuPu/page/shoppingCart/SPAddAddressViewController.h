//
//  SPAddAddressViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#import "SPBuildAddressAction.h"
@class sqlService;
#import "SPAddressAddOrUpdateAction.h"
#import "GCPlaceholderTextView.h"
#import "SPAddressDeleteAction.h"
@interface SPAddAddressViewController : SPBaseViewController<SPBuildAddressActionDelegate,UIPickerViewDataSource,UIPickerViewDelegate,SPAddressAddOrUpdateActionDelegate,UITextFieldDelegate,UITextViewDelegate,SPAddressDeleteActionDelegate>{
    SPBuildAddressAction  *buildAddressAction;
    
    UIPickerView *cityPicker;
    NSMutableArray *proviceArray,*cityArray,*regionArray;
    sqlService *service;


    SPAddressAddOrUpdateAction *addAction;
    NSMutableDictionary *contentDic;
    
    BOOL isModify;
    SPAddressListData *listData;
    
    BOOL buttonStatus;
    
    SPAddressDeleteAction *deleAction;
 
    BOOL isback;
}

@property(nonatomic,retain)   NSString *proviceStr,*cityStr,*areaStr;
@property(nonatomic,retain)   NSString *isDefault;
@property(nonatomic,retain)   SPAddressListData *listData;
@property(nonatomic) BOOL     isModify;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *footerView;
@property(nonatomic,retain) NSMutableArray *proviceArray,*cityArray,*regionArray;
@property(nonatomic,retain) IBOutlet UIButton *setDefaultAddressBtn;
@property(nonatomic,retain) IBOutlet UIButton *deleAddressBtn;

-(IBAction)setDefaultAddressAction:(id)sender;
-(IBAction)deleAddressAction:(id)sender;

-(void)hideCityPicker;

@end
