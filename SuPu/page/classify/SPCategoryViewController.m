//
//  SPCategoryViewController.m
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPCategoryViewController.h"
#import "SPClassifyTableCell.h"

@interface SPCategoryViewController ()

@property BOOL isPad;

@end

@implementation SPCategoryViewController
@synthesize m_arr_category;
@synthesize m_tableView;
@synthesize m_str_categoryID;
@synthesize m_str_parentID;
@synthesize m_action_brand;
@synthesize m_action_category;
@synthesize m_str_title;
@synthesize isPad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (isPad) {
        self = [super initWithNibName:@"SPCategoryPadViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}
 

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (m_str_parentID) {
        if (m_str_title) {
            self.title=m_str_title;
        }else{
            self.title=@"品类";
            self.UMStr = @"品类";
        }
        
        m_action_category=[[SPCategoryListAction alloc] init];
        m_action_category.m_delegate_categoryList=self;
        [m_action_category requestCategoryListData];
        [self showHUD];
    }else if(m_str_categoryID){
        if (m_str_title) {
            self.title=m_str_title;
        }else{
            self.title=@"品牌";
            self.UMStr=@"品牌";
        }
        
        m_action_brand=[[SPBrandListAction alloc] init];
        m_action_brand.m_delegate_brandList=self;
        [m_action_brand requestBrandListData];
        [self showHUD];
    }
    self.m_tableView.showsVerticalScrollIndicator = YES;
}

- (void)didReceiveMemoryWarning
{
    DLog(@" 内存警告-----------执行到这里--  2222");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
//    [self setM_tableView:nil];
    
    [super viewDidUnload];
}
- (void)dealloc{
    OUOSafeRelease(m_str_parentID);
    OUOSafeRelease(m_str_categoryID);
    OUOSafeRelease(m_arr_category);
    OUOSafeRelease(m_action_brand);
    OUOSafeRelease(m_action_category);
    OUOSafeRelease(m_str_title);
    OUOSafeRelease(m_tableView);

    [super dealloc];
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.m_arr_category count]>0)
    return [self.m_arr_category count];
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        return 88.0f;
    }else{
        return 44.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    if (m_str_parentID) {//品类
        static NSString *s_identify_class=@"classifiedCell";
        SPClassifyTableCell *cell_class=[tableView dequeueReusableCellWithIdentifier:s_identify_class];
        if (cell_class==nil) {
            NSArray *l_arr_views = nil;
            if (isPad) {
                l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPClassifyPadTableCell" owner:nil options:nil];
            }else{
                l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPClassifyTableCell" owner:nil options:nil];
            }
            for (UIView *l_view in l_arr_views) {
                if ([l_view isKindOfClass:[SPClassifyTableCell class]]) {
                    cell_class=(SPClassifyTableCell*)l_view;
                    [cell_class setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                }
            }
        }
        SPCategoryListData *l_data_category=[self.m_arr_category objectAtIndex:row];

        
        if (isPad) {
            [cell_class.m_label_title setFont:[UIFont systemFontOfSize:24]];
            cell_class.m_label_title.frame = CGRectMake(50, 30, 400, 28);
            [cell_class.m_label_title setText:l_data_category.mCategoryName];
        }else{
            [cell_class.textLabel setFont:[UIFont systemFontOfSize:15]];
            [cell_class.textLabel setText:l_data_category.mCategoryName];
        }
        return cell_class;
    }else{//品牌
        static NSString *s_identify_brand=@"brandCell";
        SPClassifyTableCell *cell_brand=[tableView dequeueReusableCellWithIdentifier:s_identify_brand];
        if (cell_brand==nil) {
            NSArray *l_arr_views = nil;
            if (isPad) {
                l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPClassifyPadTableCell" owner:nil options:nil];
            }else{
                l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPClassifyTableCell" owner:nil options:nil];
            }
            for (UIView *l_view in l_arr_views) {
                if ([l_view isKindOfClass:[SPClassifyTableCell class]]) {
                    cell_brand=(SPClassifyTableCell*)l_view;
                    [cell_brand setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                }
            }
        }
        SPBrandData *l_data_brand=[self.m_arr_category objectAtIndex:row];
        if (isPad) {
            [cell_brand.m_label_title setFont:[UIFont systemFontOfSize:24]];
            cell_brand.m_label_title.frame = CGRectMake(50, 30, 400, 28);
            [cell_brand.m_label_title setText:l_data_brand.mBrandName];
        }else{
            [cell_brand.textLabel setFont:[UIFont systemFontOfSize:15]];
            [cell_brand.textLabel setText:l_data_brand.mBrandName];
        }
        return cell_brand;
    }
}

#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    if (self.m_str_parentID!=nil) {//品类
        SPCategoryListData *l_data_category=[self.m_arr_category objectAtIndex:row];
        
        if ([l_data_category.mIsLaef isEqualToString:@"False"]) {
            [Go2PageUtility go2CategoryViewController:self withBrandID:nil classifiedID:l_data_category.mCategoryID title:l_data_category.mCategoryName];
        } else {
            [Go2PageUtility go2ProductListViewController:self withKeyword:nil withBrandID:nil classifiedID:l_data_category.mCategoryID title:l_data_category.mCategoryName isBarCode:NO];
        }
        
    }else{//品牌
        SPBrandData *l_data_brand=[self.m_arr_category objectAtIndex:row];
        
        [Go2PageUtility go2ProductListViewController:self withKeyword:nil withBrandID:l_data_brand.mBrandID classifiedID:m_str_categoryID title:l_data_brand.mBrandName isBarCode:NO];
    }
}

#pragma -
#pragma mark  SPBrandListActionDelegate

-(NSDictionary*)onResponseBrandListAction{
    NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                          self.m_str_categoryID,@"CategoryId",
                          nil];
    return l_dict;
}

-(void)onResponseBrandListDataSuccess:(NSArray *)l_arr_brandList{
    [self hideHUD];
    self.m_arr_category=l_arr_brandList;
    [m_tableView reloadData];
    
}

-(void)onResponseBrandListDataFail{
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

#pragma -
#pragma mark SPCategoryListActionDelegate

-(NSDictionary*)onResponseCategoryListAction{
    NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                          strOrEmpty(self.m_str_parentID),@"ParentId",
                          nil];
    return l_dict;
}
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList{
    [self hideHUD];
    self.m_arr_category=l_arr_categoryList;
    [m_tableView reloadData];
    
}
-(void)onResponseCategoryListDataFail{
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

@end
