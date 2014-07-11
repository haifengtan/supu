//
//  SPProductListViewController.m
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductListViewController.h"
#import "SPProductListTableCell.h"
#import "SVPullToRefresh.h"
#import "SPProductListIpadCell.h"
#import "SDImageCache.h"

#define degreesToRadians(degrees) (M_PI * degrees / 180.0)

@interface SPProductListViewController ()

@property BOOL isPad;
@property BOOL isFristLoadPage;

-(void)startViewAnimation:(UIImageView*)imgView degreesToRadians:(int)degree;
@property (nonatomic,retain)NSString *tempbrand;
@property (nonatomic,retain)NSString *tempcateory;

@property (retain, nonatomic) UILabel *cautionlable;
@property (nonatomic,retain) NSMutableDictionary *m_dict_filterData_temp;
@property (retain, nonatomic) IBOutlet UIButton *m_btn_saleSort;
@property (retain, nonatomic) IBOutlet UIButton *m_btn_priceSort;
@property (retain, nonatomic) IBOutlet UIButton *m_btn_commentSort;
@end

@implementation SPProductListViewController
@synthesize m_tableView;
@synthesize m_imgView_saleArrow;
@synthesize m_imgView_commentArrow;
@synthesize m_imgView_priceArrow;
@synthesize m_data_productList;
@synthesize m_action_productList;
@synthesize m_str_brandId;
@synthesize m_str_categoryId;
@synthesize m_str_keyword;
@synthesize m_str_title;
@synthesize m_str_SortField;
@synthesize m_arr_productList;
@synthesize m_dict_userFilterData;
@synthesize m_dict_filterData;
@synthesize m_str_endPrice;
@synthesize m_str_startPrice;
@synthesize m_action_filter;
@synthesize m_str_barcode;
@synthesize isPad;
@synthesize isFristLoadPage;
@synthesize tempbrand,tempcateory;
@synthesize m_str_brandId_pre;
@synthesize m_str_categoryId_pre;
@synthesize m_dict_filterData_temp;

- (void)dealloc {
    
    OUOSafeRelease(m_str_title);
    OUOSafeRelease(m_str_SortField);
    OUOSafeRelease(m_arr_productList);
    OUOSafeRelease(m_str_categoryId_pre);
    OUOSafeRelease(m_str_brandId_pre);
 
    OUOSafeRelease(m_str_categoryId);
    OUOSafeRelease(m_str_brandId);
    OUOSafeRelease(m_data_productList);
    OUOSafeRelease(m_str_keyword);
    [m_tableView release];
    OUOSafeRelease(m_imgView_saleArrow);
    OUOSafeRelease(m_imgView_priceArrow);
    OUOSafeRelease(m_imgView_commentArrow);
    OUOSafeRelease(m_dict_filterData);
    OUOSafeRelease(m_dict_userFilterData);
    OUOSafeRelease(m_str_startPrice);
    OUOSafeRelease(m_str_endPrice);
     OUOSafeRelease(m_str_barcode);
    OUOSafeRelease(tempcateory);
    OUOSafeRelease(tempbrand);
    OUOSafeRelease(m_dict_filterData_temp);
    OUOSafeRelease(m_action_filter);
    OUOSafeRelease(m_action_productList);
    [_m_btn_saleSort release];
    [_m_btn_priceSort release];
    [_m_btn_commentSort release];
    [super dealloc];
}
- (void)viewDidUnload {
    DLog(@"内存警告-----------执行到这里---");
    [self setM_tableView:nil];
    [self setM_imgView_saleArrow:nil];
    [self setM_action_productList:nil];
    OUOSafeRelease(m_imgView_saleArrow);
    OUOSafeRelease(m_imgView_priceArrow);
    OUOSafeRelease(m_imgView_commentArrow);
    OUOSafeRelease(m_action_filter);
    [self setM_btn_saleSort:nil];
    [self setM_btn_priceSort:nil];
    [self setM_btn_commentSort:nil];
    [super viewDidUnload];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationItem.rightBarButtonItem.enabled = YES;
//    self.m_action_productList = nil;
    [self hideHUD];
    
}


@synthesize cautionlable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPProductListPadViewController" bundle:nibBundleOrNil];
        m_int_pageSize=32;
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        m_int_pageSize=20;
    }
    if (self) {
        // Custom initialization
        m_int_lastSort=111;
        _isSalesUp=NO;
        _isPriceUp=YES;
        _isCommentUp=NO;
        m_int_currPage=0;
        m_int_totalPage=1;
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    UIImage *l_image=[UIImage imageNamed:@"背景.jpg"];
//    if (iPad) {
//        l_image=[UIImage imageNamed:@"背景_iPad.jpg"];
//    }else{
//        l_image=[UIImage imageNamed:@"背景.jpg"];
//    }
//    self.m_tableView.backgroundColor = [UIColor colorWithPatternImage:l_image];
//    m_tableView.backgroundColor = [UIColor redColor];
    
    //设置多个button不能同时点击
    [self.m_btn_commentSort setExclusiveTouch:YES];
    [self.m_btn_priceSort setExclusiveTouch:YES];
    [self.m_btn_saleSort setExclusiveTouch:YES];
    
    self.isFristLoadPage = YES;
    
    self.tempbrand = m_str_brandId;
    self.tempcateory = m_str_categoryId;
    
    _firstFilter = YES;
    if (m_str_keyword||m_str_barcode) {//关键字搜索或者条形码搜索
        if ([strOrEmpty(m_str_barcode) isEqualToString:@""]||[strOrEmpty(m_str_keyword) isEqualToString:@""]) {
            self.title=@"搜索结果";
            self.UMStr=@"搜索结果";
        }else{
            self.title=m_str_keyword;
        }
        
        if (m_str_keyword) {
            [self setRightBarButton:@"筛选" backgroundimagename:@"barButton.png" target:self action:@selector(onActionFilterButtonPressed:)];
        }
        SPFilterAction *tempAction_new = [[SPFilterAction alloc] init];
        self.m_action_filter= tempAction_new;
        [tempAction_new release];
        m_action_filter.m_delegate_filter=self;
        
    }else{
        [self setRightBarButton:@"筛选" backgroundimagename:@"barButton.png" target:self action:@selector(onActionFilterButtonPressed:)];
        m_action_filter=[[SPFilterAction alloc] init];
        m_action_filter.m_delegate_filter=self;
        if (m_str_title) {
            self.title=m_str_title;
        }else{
            self.title=@"商品列表";
            self.UMStr=@"商品列表";
        }
    }
    
    //初始化箭头
    self.m_str_SortField=@"GoodsSalesDesc";
    [self.m_imgView_saleArrow setHidden:NO];
    [self.m_imgView_priceArrow setHidden:YES];
    [self.m_imgView_commentArrow setHidden:YES];
    
    self.m_arr_productList=[NSMutableArray arrayWithArray:0];
    
    m_action_productList=[[SPProductListAction alloc] init];
    m_action_productList.m_delegate_productList=self;
    
    
    if (self.isPad) {
        self.m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.m_tableView.indicatorStyle=UIScrollViewIndicatorStyleBlack;
        self.m_tableView.showsHorizontalScrollIndicator = YES;
        self.m_tableView.showsVerticalScrollIndicator = YES;
        
    }
 
    
    [m_action_productList requestProductListData];
        
    [self showHUD];
 
    
}
 


-(void)startViewAnimation:(UIImageView*)imgView degreesToRadians:(int)degree{
    [UIView beginAnimations:@"rotate" context:nil];
    [UIView setAnimationDuration:0.2];
    imgView.transform = CGAffineTransformMakeRotation(degreesToRadians(degree));
    [UIView commitAnimations];
}

- (IBAction)onButtonActionSort:(id)sender {
    
    UIButton *l_btn_curr=(UIButton *)sender;
    int l_tag=l_btn_curr.tag;
    page = 0;
    [l_btn_curr setSelected:YES];
    //按钮状态
    if (m_int_lastSort!=l_tag) {
        UIButton *l_btn_last=(UIButton *)[self.view viewWithTag:m_int_lastSort];
        [l_btn_last setSelected:NO];
    }
    
    switch (l_tag) {
        case 111:
            NSLog(@"执行过几次--------------------");
            [self.m_imgView_saleArrow setHidden:NO];
            [self.m_imgView_priceArrow setHidden:YES];
            [self.m_imgView_commentArrow setHidden:YES];
            
            if (l_tag==m_int_lastSort) {
                _isSalesUp=!_isSalesUp;
                if (_isSalesUp) {//升序
                    [self startViewAnimation:self.m_imgView_saleArrow degreesToRadians:180];
                    self.m_str_SortField=@"GoodsSales";
                }else{//降序
                    [self startViewAnimation:self.m_imgView_saleArrow degreesToRadians:0];
                    self.m_str_SortField=@"GoodsSalesDesc";
                }
            }else{
                if (_isSalesUp) {//升序
                    self.m_str_SortField=@"GoodsSales";
                }else{//降序
                    self.m_str_SortField=@"GoodsSalesDesc";
                }
            }
            break;
        case 222:
            [self.m_imgView_saleArrow setHidden:YES];
            [self.m_imgView_priceArrow setHidden:NO];
            [self.m_imgView_commentArrow setHidden:YES];
            
            if (l_tag==m_int_lastSort) {
                _isPriceUp=!_isPriceUp;
                if (_isPriceUp) {//升序
                    [self startViewAnimation:self.m_imgView_priceArrow degreesToRadians:0];
                    self.m_str_SortField=@"Price";
                }else{//降序
                    [self startViewAnimation:self.m_imgView_priceArrow degreesToRadians:180];
                    self.m_str_SortField=@"PriceDesc";
                }
            }else{
                if (_isPriceUp) {
                    self.m_str_SortField=@"Price";
                }else{
                    self.m_str_SortField=@"PriceDesc";
                }
            }
            break;
        case 333:
            [self.m_imgView_saleArrow setHidden:YES];
            [self.m_imgView_priceArrow setHidden:YES];
            [self.m_imgView_commentArrow setHidden:NO];
            
            if (l_tag==m_int_lastSort) {
                _isCommentUp=!_isCommentUp;
                if (_isCommentUp) {//升序
                    [self startViewAnimation:self.m_imgView_commentArrow degreesToRadians:180];
                    self.m_str_SortField=@"CommentCount";
                }else{//降序
                    [self startViewAnimation:self.m_imgView_commentArrow degreesToRadians:0];
                    self.m_str_SortField=@"CommentCountDesc";
                }
            }else{
                if (_isCommentUp) {
                    self.m_str_SortField=@"CommentCount";
                }else{
                    self.m_str_SortField=@"CommentCountDesc";
                }
            }
            break;
            
        default:
            break;
    }
    if (l_btn_curr.selected) {
        [self resetDataSource];
        [self showHUD];
        [m_action_productList requestProductListData];
        
        m_int_lastSort=l_tag;
    }
}

-(void)resetDataSource
{
    self.m_arr_productList=nil;
    self.m_arr_productList=[NSMutableArray arrayWithArray:0];
    
    [self.m_tableView reloadData];
    m_int_lastPage=0;
    m_int_currPage=0;
    m_int_totalPage=1;
    if (self.isPad) {
        m_int_pageSize=32;
    }else{
        m_int_pageSize=20;
    }

//    self.m_tableView.showsInfiniteScrolling = YES;
}

#pragma -
#pragma mark SPProductListActionDelegate
//处理BrandId为空
-(NSDictionary*)onResponseProductListAction{
    
    NSString *l_str_page=[NSString stringWithFormat:@"%d",page+1];
    NSString *l_str_pageSize=[NSString stringWithFormat:@"%d",m_int_pageSize];
    //品牌=0  分类 !=0
    if ([m_str_brandId isEqualToString:@"0"]&&![m_str_categoryId isEqualToString:@"0"]) {
        NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                              strOrEmpty(l_str_page),@"Page",
                              strOrEmpty(l_str_pageSize),@"PageSize",
                              strOrEmpty(m_str_barcode),@"BarCode",
                              strOrEmpty(m_str_keyword),@"SearchKey",
                              strOrEmpty(m_str_categoryId),@"CategoryId",
                              strOrEmpty(m_str_startPrice),@"StartPrice",
                              strOrEmpty(m_str_endPrice),@"EndPrice",
                              strOrEmpty(self.m_str_SortField),@"SortField",
                              nil];
        return l_dict;
    }else
        //品牌 !=0  分类 =0
        if([m_str_categoryId isEqualToString:@"0"]&&![m_str_brandId isEqualToString:@"0"]){
        NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                              strOrEmpty(l_str_page),@"Page",
                              strOrEmpty(l_str_pageSize),@"PageSize",
                              strOrEmpty(m_str_barcode),@"BarCode",
                              strOrEmpty(m_str_keyword),@"SearchKey",
                              strOrEmpty(m_str_brandId),@"BrandId",
                              strOrEmpty(m_str_startPrice),@"StartPrice",
                              strOrEmpty(m_str_endPrice),@"EndPrice",
                              strOrEmpty(self.m_str_SortField),@"SortField",
                              nil];
          return l_dict;
    }else
        //品牌=0  分类=0
        if([m_str_categoryId isEqualToString:@"0"]&&[m_str_brandId isEqualToString:@"0"]){
        NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                              strOrEmpty(l_str_page),@"Page",
                              strOrEmpty(l_str_pageSize),@"PageSize",
                              strOrEmpty(m_str_barcode),@"BarCode",
                              strOrEmpty(m_str_keyword),@"SearchKey",
                              strOrEmpty(m_str_startPrice),@"StartPrice",
                              strOrEmpty(m_str_endPrice),@"EndPrice",
                              strOrEmpty(self.m_str_SortField),@"SortField",
                              nil];
        return l_dict;
    }else {//品牌!=0  分类 !=0
        NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                              strOrEmpty(l_str_page),@"Page",
                              strOrEmpty(l_str_pageSize),@"PageSize",
                              strOrEmpty(m_str_barcode),@"BarCode",
                              strOrEmpty(m_str_keyword),@"SearchKey",
                              strOrEmpty(m_str_categoryId),@"CategoryId",
                              strOrEmpty(m_str_brandId),@"BrandId",
                              strOrEmpty(m_str_startPrice),@"StartPrice",
                              strOrEmpty(m_str_endPrice),@"EndPrice",
                              strOrEmpty(self.m_str_SortField),@"SortField",
                              nil];
        return l_dict;

    }
    return nil;
}
#pragma mark-- 获取产品列表的
-(void)onResponseProductListDataSuccess:(SPProductListData *)l_data_productList{
    [self.m_tableView.pullToRefreshView stopAnimating];
    
    if (self.m_data_productList!=nil) {
        self.m_data_productList=nil;
    }
    
    [SPStatusUtility clearAllMermoryCache];
    
    self.m_data_productList=l_data_productList;
    
    [self.m_arr_productList addObjectsFromArray:m_data_productList.mGoodsListArray];
    
    
    m_int_currPage=[self.m_data_productList.mpageInfo.mPageIndex intValue];
    m_int_pageSize=[self.m_data_productList.mpageInfo.mPageSize intValue];
 
    m_int_totalPage = ([self.m_data_productList.mpageInfo.mRecordCount intValue]+m_int_pageSize-1)/m_int_pageSize;
    
    if (self.m_arr_productList.count == 0) {
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;
        }
        if (iPad) {
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 0, 768, 854+10) title:@"没有商品"];
        }else{
            self.cautionlable = [UIViewHealper createNoDataLabel:CGRectMake(0, 0, 320, [SPStatusUtility getScreenHeight]-100) title:@"没有商品"];
        }

      [self.view addSubview:self.cautionlable];
    }else{
        if (self.cautionlable!=nil) {
            [self.cautionlable removeFromSuperview];
            self.cautionlable = nil;        }
    }
    
    [self.m_tableView reloadData];
    
    [self.m_tableView.infiniteScrollingView stopAnimating];
    
    if ((first < 2)&&[m_arr_productList count]<2) {
//        self.navigationItem.rightBarButtonItem=nil;
    }else{
        if ([m_arr_productList count] ==0 &&first == 0) {
            self.navigationItem.rightBarButtonItem=nil;
        }
    }
    
    page ++;
    isFristLoadPage = NO;
    first ++;
    
    [self hideHUD];
    
}

-(void)onResponseProductListDataFail{
    [self hideHUD];
    [self.m_tableView.pullToRefreshView stopAnimating];
    [self.m_tableView.infiniteScrollingView stopAnimating];
    
    [SPStatusUtility showAlert:SP_DEFAULTTITLE
                       message:@"网络连接失败，请稍后再试"
                      delegate:nil
             cancelButtonTitle:@"确定"
             otherButtonTitles:nil];
}

#pragma -
#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.m_btn_saleSort setUserInteractionEnabled:NO];
    [self.m_btn_priceSort setUserInteractionEnabled:NO];
    [self.m_btn_commentSort setUserInteractionEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.m_btn_saleSort setUserInteractionEnabled:YES];
    [self.m_btn_priceSort setUserInteractionEnabled:YES];
    [self.m_btn_commentSort setUserInteractionEnabled:YES];
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.m_arr_productList count] == 0) {
        return 0;
    }
    if (self.isPad) {
        return (self.m_arr_productList.count%4==0)?(self.m_arr_productList.count/4):(self.m_arr_productList.count/4+1);
    }else{
        return [self.m_arr_productList count];
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        return 276.0f;
    }else{
        return 74.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *s_str_identify=@"SPProductListTableCell";
    static NSString *ipadIdentify = @"SPProductListIpadCell";
    if (self.isPad) {
        SPProductListIpadCell *cell=[tableView dequeueReusableCellWithIdentifier:ipadIdentify];
        if (cell==nil) {
             
            cell = [SPProductListIpadCell loadFromNIB];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
  
        
        int count = self.m_arr_productList.count;
        int row = indexPath.row;
        //每行四个个
        
        int l_row_count=4;
        
        int num1= row*l_row_count;
        int num2= row*l_row_count+1;
        int num3= row*l_row_count+2;
        int num4= row*l_row_count+3;
        
        if (num1 < count ) {
            cell.productData = [self.m_arr_productList objectAtIndex:num1];
        }
        if (num2<count) {
            cell.productData2 = [self.m_arr_productList objectAtIndex:num2];
        }
       
        if (num3<count) {
            cell.productData3 = [self.m_arr_productList objectAtIndex:num3];
        }
        
        if (num4<count) {
            cell.productData4 = [self.m_arr_productList objectAtIndex:num4];
        }
         
        return cell;
    }else{
        SPProductListTableCell *cell=[tableView dequeueReusableCellWithIdentifier:s_str_identify];
        if (cell==nil) {
            
            cell =  [SPProductListTableCell loadFromNIB];
        }
        
        cell.product_data = [self.m_arr_productList objectAtIndex:indexPath.row];
        
        
        return cell;
    }
}

 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isPad) {
        SPProductListGoodData *l_data_good=[self.m_arr_productList objectAtIndex:[indexPath row]];
        [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:l_data_good.mGoodsSN from:self];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (iPad) {
        if (indexPath.row < ((m_int_totalPage*m_int_pageSize-1)+3)/4 && (indexPath.row == ([m_arr_productList count]+3)/4-1)) {
            if (m_int_currPage*m_int_pageSize == m_int_totalPage*m_int_pageSize) {
                self.m_tableView.showsInfiniteScrolling = NO;
            }else{
                [self showHUD];
                [m_action_productList performSelector:@selector(requestProductListData) withObject:nil afterDelay:.0];
                
            }
            
            
        }else{
            [self.m_tableView.infiniteScrollingView stopAnimating];
            self.m_tableView.showsInfiniteScrolling = NO;
        }
    }else{
        if (indexPath.row < (m_int_totalPage*m_int_pageSize-1) && (indexPath.row == [m_arr_productList count]-1)) {
            if (m_int_currPage*m_int_pageSize == m_int_totalPage*m_int_pageSize) {
                self.m_tableView.showsInfiniteScrolling = NO;
            }else{
                 [self showHUD];
                [m_action_productList performSelector:@selector(requestProductListData) withObject:nil afterDelay:.0];
                
            }
        }
        else{
            [self.m_tableView.infiniteScrollingView stopAnimating];
            self.m_tableView.showsInfiniteScrolling = NO;
        }
        
    }
}

#pragma -
#pragma mark 筛选
-(void)onActionFilterButtonPressed:(id)sender{
    [self showHUD];
    _firstFilter = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [m_action_filter requestFilterData];
}

#pragma -  处理完成筛选条件的方法
#pragma mark SPProductFilterDelegate
-(void)receiveFilterData:(NSMutableDictionary*)userFilterData{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    page = 0;
    self.m_dict_userFilterData=userFilterData;
    
    NSArray *keys=[self.m_dict_userFilterData allKeys];
   
    for (int i=0; i<[keys count]; i++) {
        NSString *currKey=[keys objectAtIndex:i];
      
        SPFilterItemData *tempData=[self.m_dict_userFilterData objectForKey:currKey];
        if ([currKey isEqualToString:@"分类"]) {
        
            self.m_str_categoryId=tempData.mid;
            
            if ([strOrEmpty(self.m_str_categoryId) isEqualToString:@""]) {
            
                self.m_str_categoryId = self.tempcateory;
            }
            
            
        }else if([currKey isEqualToString:@"品牌"]){
            
            self.m_str_brandId=tempData.mid;
        
            if ([strOrEmpty(self.m_str_brandId) isEqualToString:@""]) {
                
                self.m_str_brandId = self.tempbrand;
            }
            
        }else if([currKey isEqualToString:@"价格"]){
            NSString *l_str_content=tempData.mcontent;
        
            if ([strOrEmpty(l_str_content) isEqualToString:@""]) {
                
                self.m_str_startPrice=@"";
                self.m_str_endPrice=@"";
                
            }else{
                
                if ([l_str_content rangeOfString:@"低于"].length>0) {
                    self.m_str_startPrice=@"";
                    self.m_str_endPrice=[l_str_content stringByReplacingOccurrencesOfString:@"低于" withString:@""];
                    
                }else if([l_str_content rangeOfString:@"高于"].length>0){
                    self.m_str_startPrice=[l_str_content stringByReplacingOccurrencesOfString:@"高于" withString:@""];
                    self.m_str_endPrice=@"";
                    
                }else{
                    NSArray *l_arr=[l_str_content componentsSeparatedByString:@"-"];
                    
                    if ([l_arr count]>1) {//价格区间
                        self.m_str_startPrice=[l_arr objectAtIndex:0];
                        self.m_str_endPrice=[l_arr objectAtIndex:1];
                    }
                }
            }
        }
    }
    [self resetDataSource];
     [self showHUD];
    [self.m_action_productList requestProductListData];
}

#pragma -
#pragma mark SPFilterActionDelegate
-(NSDictionary*)onResponseFilterDataAction{
    NSDictionary *l_dict=[NSDictionary dictionaryWithObjectsAndKeys:
                          strOrEmpty(m_str_keyword),@"SearchKey",
                          strOrEmpty(tempcateory),@"CategoryId",
                          strOrEmpty(tempbrand),@"BrandId",
                          strOrEmpty(m_str_startPrice),@"StartPrice",
                          strOrEmpty(m_str_endPrice),@"EndPrice",
                          nil];
    return l_dict;
}

-(void)onResponseFilterDataSuccess:(NSDictionary *)l_dict_filterData{
    self.m_dict_filterData=[NSMutableDictionary dictionaryWithCapacity:0];
    
    
    NSArray *l_arr_category=[l_dict_filterData objectForKey:@"CategoryList"];
    if([l_arr_category count]>0)
    {
        NSString *name=@"category";
        NSString *displayname=@"分类";
        NSMutableArray *_filterDataArray=[NSMutableArray arrayWithCapacity:0];
        
        NSArray *userFilterKeys=nil;
        if (self.m_dict_userFilterData!=nil) {
            userFilterKeys=[self.m_dict_userFilterData allKeys];
        }
        
        for (NSDictionary *l_dict_category in l_arr_category)
        {
            SPFilterItemData *data=[[SPFilterItemData alloc] init];
            data.mname=name;
            data.mdisplayName=displayname;
            data.mcontent=[l_dict_category objectForKey:@"CategoryName"];
            data.mid=[l_dict_category objectForKey:@"CategoryId"];
            //<><><><><><><保存上一次筛选条件相关
            
            if (userFilterKeys!=nil&&[userFilterKeys containsObject:displayname])
            {
                //                NSLog(@"有相同--------筛选条件%@",displayname);
                SPFilterItemData *userFilterData=[self.m_dict_userFilterData valueForKey:displayname];
                if ([data.mid isEqualToString:userFilterData.mid])
                {
                    //                    NSLog(@"有相同--筛选内容%@",userFilterData.mid);
                    data.mselected=YES;
                }
            }
            //<><><><><><><><><>
            [_filterDataArray addObject:data];
            [data release];
        }
        
        [self.m_dict_filterData setObject:_filterDataArray forKey:displayname];
    }
    
    if (second==0) {
        self.m_dict_filterData_temp = self.m_dict_filterData;
    }
    
    NSArray *l_arr_price=[l_dict_filterData objectForKey:@"PriceList"];
    if([l_arr_price count]>0)
    {
        NSString *name=@"price";
        NSString *displayname=@"价格";
        NSMutableArray *_filterDataArray=[NSMutableArray arrayWithCapacity:0];
        
        NSArray *userFilterKeys=nil;
        if (self.m_dict_userFilterData!=nil) {
            userFilterKeys=[self.m_dict_userFilterData allKeys];
        }
        
        for (NSDictionary *l_dict_category in l_arr_price)
        {
            SPFilterItemData *data=[[SPFilterItemData alloc] init];
            data.mname=name;
            data.mdisplayName=displayname;
            data.mcontent=[l_dict_category objectForKey:@"Name"];
            data.mid=[l_dict_category objectForKey:@"Name"];
            //<><><><><><><保存上一次筛选条件相关
            
            if (userFilterKeys!=nil&&[userFilterKeys containsObject:displayname])
            {
                
                SPFilterItemData *userFilterData=[self.m_dict_userFilterData valueForKey:displayname];
                if ([data.mid isEqualToString:userFilterData.mid])
                {
                    data.mselected=YES;
                }
            }
            //<><><><><><><><><>
            [_filterDataArray addObject:data];
            [data release];
        }
        
        [self.m_dict_filterData setObject:_filterDataArray forKey:displayname];
    }
    
    NSArray *l_arr_brand=[l_dict_filterData objectForKey:@"BrandList"];
    if([l_arr_brand count]>0)
    {
        NSString *name=@"brand";
        NSString *displayname=@"品牌";
        NSMutableArray *_filterDataArray=[NSMutableArray arrayWithCapacity:0];
        
        NSArray *userFilterKeys=nil;
        if (self.m_dict_userFilterData!=nil) {
            userFilterKeys=[self.m_dict_userFilterData allKeys];
        }
        
        for (NSDictionary *l_dict_category in l_arr_brand)
        {
            SPFilterItemData *data=[[SPFilterItemData alloc] init];
            data.mname=name;
            data.mdisplayName=displayname;
            data.mcontent=[l_dict_category objectForKey:@"BrandName"];
            data.mid=[l_dict_category objectForKey:@"BrandID"];
            NSArray *categoryidsarr = [l_dict_category objectForKey:@"CategoryIds"];
            NSMutableString *catagory = [NSMutableString string];
            for (NSString *s in categoryidsarr) {
                [catagory appendFormat:@"%@,",s];
            }
            data.mcatagorys = catagory;
            
            
            if (userFilterKeys!=nil&&[userFilterKeys containsObject:displayname])
            {
                //                NSLog(@"有相同--------筛选条件%@",displayname);
                SPFilterItemData *userFilterData=[self.m_dict_userFilterData valueForKey:displayname];
                if ([data.mid isEqualToString:userFilterData.mid])
                {
                    //                    NSLog(@"有相同--筛选内容%@",userFilterData.mid);
                    data.mselected=YES;
                }
            }
            
            [_filterDataArray addObject:data];
            [data release];
        }
        
        [self.m_dict_filterData setObject:_filterDataArray forKey:displayname];
    }
    
    second ++;
//    NSLog(@"筛选条件数组个数%@",self.m_dict_filterData);
    [self hideHUD];
    if ([self.m_dict_filterData count]>0)
	{
//        [Go2PageUtility go2ProductFilterViewController:self withFilterDataDict:self.m_dict_filterData];
        [Go2PageUtility go2ProductFilterViewController:self withFilterDataDict:self.m_dict_filterData_temp];
    }
	else
	{   self.navigationItem.rightBarButtonItem.enabled = YES;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"对不起,当前没有筛选条件" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void)onResponseFilterDataFail{
    [self hideHUD];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"对不起,当前没有筛选条件" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    [alert release];
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DLog(@"didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

@end
