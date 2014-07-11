//
//  SPClassifyViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyViewController.h"
#import "SPClassifyTableCell.h"

#define TABLEVIEW_CLASSIFIED_TAG 110
#define TABLEVIEW_BRAND_TAG 111
@interface SPClassifyViewController()

@property(nonatomic,assign) BOOL isPad;
@property(nonatomic,assign) BOOL isLoad;

@end

@implementation SPClassifyViewController
@synthesize m_scrollView;
@synthesize m_arr_brands;
@synthesize m_arr_classified;
@synthesize m_action_class;
@synthesize m_button_category;
@synthesize m_button_brand;
@synthesize isPad;
@synthesize isLoad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isPad = iPad;
    if (isPad) {
        self = [super initWithNibName:@"SPClassifyPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"分类";
    self.UMStr = @"分类";
    
    [self initClassifiedScrollView];
    
    m_action_class=[[SPCategoryListAction alloc] init];
    m_action_class.m_delegate_categoryList=self;
    [m_action_class requestCategoryListData];
    [self showHUD];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.entryArray count]==0 && self.isLoad) {
        [m_action_class requestCategoryListData];
        [self showHUD];
    }
}



- (void)viewDidUnload
{
    [self setM_scrollView:nil];
    [self setM_button_category:nil];
    [self setM_button_brand:nil];
    
    self.m_action_class=nil;
    
    DLog(@"内存警告-----------执行到这里---1111");
    
    [super viewDidUnload];
}

- (void)dealloc {
    [m_scrollView release];
    [m_button_category release];
    [m_button_brand release];
    [m_action_class release];
    [super dealloc];
}

-(void)initClassifiedScrollView{
    
    if (self.isPad) {
        UITableView *l_tableView_1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [SPStatusUtility getShowViewWidth], [SPStatusUtility getShowViewHeight]-56) style:UITableViewStylePlain];
        l_tableView_1.delegate=self;
        l_tableView_1.dataSource=self;
        l_tableView_1.tag=TABLEVIEW_CLASSIFIED_TAG;
        
        [self.m_scrollView addSubview:l_tableView_1];
        [l_tableView_1  release];
    }else{
        NSLog(@"分类------------ xib height ------ %f",self.view.frameHeight);
        
        UITableView *l_tableView_1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [SPStatusUtility getShowViewWidth],  [SPStatusUtility getScreenHeight] - kTabbarHeight - kNavHeight - 20 - 38) style:UITableViewStylePlain];
        l_tableView_1.delegate=self;
        l_tableView_1.dataSource=self;
        l_tableView_1.tag=TABLEVIEW_CLASSIFIED_TAG;
        [self.m_scrollView addSubview:l_tableView_1];
        [l_tableView_1  release];
    }
    
    
}
#pragma mark -
#pragma mark 左右滑动相关函数


- (IBAction)classButtonAction{
    
    [self.m_button_brand setSelected:NO];
    [self.m_button_category setSelected:YES];
    
    m_bool_isBrand=NO;
    
}

- (IBAction) brandButtonAction
{
    [self.m_button_brand setSelected:YES];
    [self.m_button_category setSelected:NO];
    
    m_bool_isBrand=YES;
    
    
    
}
#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==TABLEVIEW_CLASSIFIED_TAG && [self.m_arr_classified count]>0) {
        return [self.m_arr_classified count];
    }
    
    return 0;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        return 86.0f;
    }else{
        return 43.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    if (tableView.tag==TABLEVIEW_CLASSIFIED_TAG) {//品类
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
        SPCategoryListData *l_data_category=[self.m_arr_classified objectAtIndex:row];
        [cell_class.m_label_title setText:strOrEmpty(l_data_category.mCategoryName)];
        
        if (isPad) {
            [cell_class.m_imgView setImageWithURL:URLImagePath(l_data_category.mImg) placeholderImage:[UIImage imageNamed:@"60-60.png"]];
        }else{
            [cell_class.m_imgView setImageWithURL:URLImagePath(l_data_category.mImg) placeholderImage:[UIImage imageNamed:@"30-30.png"]];
        }
        return cell_class;
    }
    return nil;
}

#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    if (tableView.tag==TABLEVIEW_CLASSIFIED_TAG) {//品类
        SPCategoryListData *l_data_category=[self.m_arr_classified objectAtIndex:row];
        if (m_bool_isBrand) {
            
            [Go2PageUtility go2CategoryViewController:self withBrandID:l_data_category.mCategoryID classifiedID:nil title:l_data_category.mCategoryName];
        }else{
            [Go2PageUtility go2CategoryViewController:self withBrandID:nil classifiedID:l_data_category.mCategoryID title:l_data_category.mCategoryName];
        }
        
    }
    
}

#pragma -
#pragma mark  SPBrandListActionDelegate

-(NSDictionary*)onResponseBrandListAction{
    NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                          @"0",@"CategoryId",
                          nil];
    return l_dict;
}

-(void)onResponseBrandListDataSuccess:(NSArray *)l_arr_brandList{
    
    [self hideHUD];
    self.isLoad = NO;
    self.m_arr_brands=l_arr_brandList;
    UITableView *l_tableView=(UITableView *)[self.m_scrollView viewWithTag:TABLEVIEW_BRAND_TAG];
    [l_tableView reloadData];
    
}

-(void)onResponseBrandListDataFail{
    [self hideHUD];
    self.isLoad = YES;
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

#pragma -
#pragma mark SPCategoryListActionDelegate

-(NSDictionary*)onResponseCategoryListAction{
    NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                          @"0",@"ParentId",
                          nil];
    return l_dict;
}
-(void)onResponseCategoryListDataSuccess:(NSArray *)l_arr_categoryList{
    [self hideHUD];
    self.m_arr_classified=l_arr_categoryList;
    UITableView *l_tableView=(UITableView *)[self.m_scrollView viewWithTag:TABLEVIEW_CLASSIFIED_TAG];
    [l_tableView reloadData];
    
}
-(void)onResponseCategoryListDataFail{
    
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

@end
