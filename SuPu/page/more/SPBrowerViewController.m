//
//  SPBrowerViewController.m
//  SuPu
//
//  Created by xx on 12-11-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBrowerViewController.h"
#import "SPProductListTableCell.h"
#import "SPBrowerData.h"

@interface SPBrowerViewController()

@property BOOL isPad;

@end

@implementation SPBrowerViewController
@synthesize m_tableView;
@synthesize m_arr_brower;
@synthesize m_label_noResult;
@synthesize isPad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPBrowerPadViewController" bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
    self.title=@"最近浏览";
    self.UMStr=@"最近浏览";
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.m_arr_brower=[SPStatusUtility loadAllBrowerData];
    
    
    
    self.m_arr_brower = [self.m_arr_brower sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return NSOrderedDescending;
    }];
    [self.m_tableView reloadData];
    
    if ([self.m_arr_brower count]>0) {
        [self.m_label_noResult setHidden:YES];
        [self.m_tableView setHidden:NO];
        [self setRightBarButton:@"清空" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(clearBrowerData)];
    }else{
        [self.m_label_noResult setHidden:NO];
        [self.m_tableView setHidden:YES];
        self.navigationItem.rightBarButtonItem=nil;
    }
}

- (void)viewDidUnload
{
    [self setM_tableView:nil];
    [self setM_label_noResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [m_tableView release];
    m_tableView.delegate = nil;
    [m_label_noResult release];
    [super dealloc];
}

#pragma -
#pragma mark 清空浏览记录
-(void)clearBrowerData{
    [SPStatusUtility showAlert:nil message:@"您确认要清空浏览记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
}

#pragma -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else{//确认
        [SPStatusUtility clearAllBrowerData];
        [self.m_label_noResult setHidden:NO];
        [self.m_tableView setHidden:YES];
        self.navigationItem.rightBarButtonItem=nil;
    }
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.m_arr_brower count]>=20) {
        return [self.m_arr_brower count] - 1;
    }

    return [self.m_arr_brower count];

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 146;
    }else{
        return 73;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *s_str_identify=@"SPBrowerTableCell";
    SPProductListTableCell *cell=[tableView dequeueReusableCellWithIdentifier:s_str_identify];
    if (cell==nil) {
        NSArray *l_arr_views = nil;
        if (self.isPad) {
            l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPProductListPadTableCell" owner:nil options:nil];
        }else{
            l_arr_views=[[NSBundle mainBundle] loadNibNamed:@"SPProductListTableCell" owner:nil options:nil];
        }
        for (UIView *l_view in l_arr_views) {
            cell=(SPProductListTableCell *)l_view;
        }
    }
    SPBrowerData *l_data_product=[self.m_arr_brower objectAtIndex:[indexPath row]];
    [cell.m_imgView_product.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.m_imgView_product.layer setBorderWidth:1];

    NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
//    NSLog(@"-------------- %@",l_data_product.mImgFile);
    if ([showpicture isEqualToString:@"ON"]) {
//        [cell.m_imgView_product setImageWithURL:URLImagePath(l_data_product.mImgFile) placeholderImage:kDefaultImage];
        if (iPad) {
           [cell.m_imgView_product setImageWithURL:URLImagePath(l_data_product.mImgFile) placeholderImage:[UIImage imageNamed:@"126-126.png"]];
        }else{
           [cell.m_imgView_product setImageWithURL:URLImagePath(l_data_product.mImgFile) placeholderImage:[UIImage imageNamed:@"66-66.png"]];
        }
    }else{
        if (iPad) {
            [cell.m_imgView_product setImage:[UIImage imageNamed:@"126-126.png"]];
        }else{
            [cell.m_imgView_product setImage:[UIImage imageNamed:@"66-66.png"]];
        }
//        [cell.m_imgView_product setImage:kDefaultImage];
    }
    [cell.m_label_productName setText:strOrEmpty(l_data_product.mGoodsName)];
    [cell.m_label_slogan setText:strOrEmpty(l_data_product.mGoodsSlogan)];
 
    if ([l_data_product.mIsNoStock isEqualToString:@"true"]) {//无库存
        [cell.m_view_noStock setHidden:NO];
        [cell.m_label_shopPrice setHidden:YES];
        [cell.m_label_noStockPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(l_data_product.mShopPrice)]];
        
    }else{
        [cell.m_view_noStock setHidden:YES];
        [cell.m_label_shopPrice setHidden:NO];
        [cell.m_label_shopPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(l_data_product.mShopPrice)]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPBrowerData *l_data_good=[self.m_arr_brower objectAtIndex:[indexPath row]];
    [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:l_data_good.mgoodssn from:self];
}
@end
