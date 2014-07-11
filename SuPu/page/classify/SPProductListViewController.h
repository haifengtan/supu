//
//  SPProductListViewController.h
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SPBaseViewController.h"
#import "SPProductListAction.h"
#import "SPFilterAction.h"
#import "SPFilterViewController.h"

@interface SPProductListViewController : SPBaseViewController<UITableViewDataSource,UITableViewDelegate,SPProductListActionDelegate,SPFilterActionDelegate,SPProductFilterDelegate>{
    int m_int_lastSort;
    
    int m_int_lastPage;
    int m_int_currPage;
    int m_int_totalPage;
    int m_int_pageSize;
    
    BOOL _isSalesUp;
    BOOL _isPriceUp;
    BOOL _isCommentUp;
    
    BOOL _firstFilter;
    int first;
    int second;
    int page;
}

@property(retain,nonatomic)NSString *m_str_categoryId;
@property(retain,nonatomic)NSString *m_str_barcode;
@property(retain,nonatomic)NSString *m_str_brandId;
@property(retain,nonatomic)NSString *m_str_keyword;
@property(retain,nonatomic)NSString *m_str_title;
@property(retain,nonatomic)NSString *m_str_startPrice;
@property(retain,nonatomic)NSString *m_str_endPrice;
@property(retain,nonatomic)SPProductListData *m_data_productList;
@property (retain, nonatomic) IBOutlet UITableView *m_tableView;
@property (retain, nonatomic) IBOutlet UIImageView *m_imgView_saleArrow;
@property (retain, nonatomic) IBOutlet UIImageView *m_imgView_priceArrow;
@property (retain, nonatomic) IBOutlet UIImageView *m_imgView_commentArrow;
@property(nonatomic,retain)SPProductListAction *m_action_productList;
@property(nonatomic,retain)NSString *m_str_SortField;

@property(nonatomic,retain)NSMutableArray *m_arr_productList;

@property(nonatomic,retain)NSMutableDictionary *m_dict_filterData;
@property(nonatomic,retain)NSMutableDictionary *m_dict_userFilterData;
@property(nonatomic,retain)SPFilterAction *m_action_filter;

@property(retain,nonatomic)NSString *m_str_categoryId_pre;
@property(retain,nonatomic)NSString *m_str_brandId_pre;

- (IBAction)onButtonActionSort:(id)sender;
-(void)resetDataSource;
-(void)onActionFilterButtonPressed:(id)sender;
 
@end
