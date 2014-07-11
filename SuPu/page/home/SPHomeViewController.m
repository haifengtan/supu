//
//  SPHomeViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeViewController.h"
#import "LoginViewController.h"
#import "SingleRowScrollCell.h"
#import "UIButton+WebCache.h"
#define ControlTag 999
#define AlertTag 666

@interface SPHomeViewController ()
@property (retain, nonatomic) SPHomeAction     *homeAction;
@property (retain, nonatomic) SPHomeTopAction *homeTopAction;
@property (retain, nonatomic) NSArray *adEntries;   ///顶部广告
@property (retain, nonatomic) NSArray *topGoods;   ///上榜商品
@property (retain, nonatomic) CustomPageControl *pageControl;
@property (retain, nonatomic) ZBarReaderViewController *reader;
@property BOOL isBarCode;
@property (retain, nonatomic) NSTimer *timer;

@property (nonatomic,assign) BOOL isLoad;

@property BOOL isPad;
@end

@implementation SPHomeViewController
@synthesize isLoad;
@synthesize homeTopAction = homeTopAction_;
@synthesize newsScrollView = newsScrollView_;
@synthesize headerToolBar = headerToolBar_;
@synthesize homeAction = homeAction_;
@synthesize topGoods = topGoods_;
@synthesize headerBar = headerBar_;
@synthesize adEntries = adEntries_;
@synthesize searchBar = searchBar_;
@synthesize tableView = tableView_;
@synthesize pageControl = pageControl_;
@synthesize scorllfatherview = scorllfatherview_;
@synthesize reader = reader_;
@synthesize isBarCode;
@synthesize isPad;
@synthesize timer = timer_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(homeTopAction_);
    OUOSafeRelease(newsScrollView_);
    OUOSafeRelease(headerToolBar_);
    OUOSafeRelease(homeAction_);
    OUOSafeRelease(headerBar_);
    OUOSafeRelease(topGoods_);
    OUOSafeRelease(adEntries_);
    OUOSafeRelease(searchBar_);
    OUOSafeRelease(tableView_);
    OUOSafeRelease(pageControl_);
    OUOSafeRelease(scorllfatherview_);
    OUOSafeRelease(reader_);
    OUOSafeRelease(timer_)
    [_m_btn_tiaoma release];
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isPad = iPad;
    if (isPad) {
        self = [super initWithNibName:@"SPHomePadViewController" bundle:nil];
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

///////////////////////////////////////////////////////
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.UMStr =@"首页";
    UIImageView *titleimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 27)];
    UIImage *titleimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"速普商城文字" ofType:@"png"]];
    titleimageview.image = titleimage;
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 110, 27)];
    [view addSubview:titleimageview];
     [titleimageview release];
    self.navigationItem.titleView = view;
    //内存警告7--------------
    [view release];
   
    
    if (isPad) {
        pageControl_ = [[CustomPageControl alloc] initWithFrame:CGRectMake((768-400)/2, 205, 400, 36) ];
    }else{
        pageControl_ = [[CustomPageControl alloc] initWithFrame:CGRectMake((320-200)/2, 95, 200, 36) ];
    }
    pageControl_.backgroundColor = [UIColor clearColor];  //设置背景颜色 不设置默认是黑色
    pageControl_.currentPage = 0;
    pageControl_.otherColour = [UIColor colorWithRed:0.44 green:0.43 blue:0.44 alpha:1.00];//其他点的颜色
    pageControl_.currentColor = [UIColor redColor];  //当前点的颜色
    
    pageControl_.controlSize = 7;  //点的大小
    pageControl_.controlSpacing = 7;  //点的间距
    [scorllfatherview_ addSubview:pageControl_];
    newsScrollView_.pageControl = (UIPageControl *)pageControl_;
    
    [self setRightBarButton:@"登陆/注册" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(loginAndRegister:)];
    
    self.homeAction = nil;
    homeAction_ = [[SPHomeAction alloc] init];
    homeAction_.m_delegate_home = self;
    
    self.homeTopAction = nil;
    homeTopAction_ = [[SPHomeTopAction alloc] init];
    homeTopAction_.m_delegate_homeTop = self;
    
    searchBar_.delegate=self;
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==AlertTag) {
        [self.m_btn_tiaoma setHighlighted:NO];
    }
}

- (IBAction)zBarItemMessage:(id)sender
{    
    [self.m_btn_tiaoma setHighlighted:YES];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"该设备无摄像头,不能进行扫描"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        alert.tag=AlertTag;
        [alert show];
        [alert release];
        
        return;
    }
    
    reader_ = [ZBarReaderViewController new];
    reader_.readerDelegate = self;
    [reader_.scanner setSymbology: ZBAR_QRCODE config: ZBAR_CFG_ENABLE to: 0];
    reader_.readerView.zoom = 1.0;
    //删除zbar的i按钮
 
    for (UIView *temp in [reader_.view subviews]) {
        for (UIView *v in [temp subviews]) {
            if ([v isKindOfClass:[UIToolbar class]]) {
                for (UIView *ev in [v subviews]) {
 
                    if ([ev isKindOfClass:[UIButton class]]) {
                        [ev removeFromSuperview];
                    }
 
                }
            }
        }
    }
    [self presentModalViewController:reader_ animated: YES];
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    [self.m_btn_tiaoma setHighlighted:NO];
    UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
    {
        break;
    }
    if(!symbol || !image)
    {
        return;
    }
    //最关键的移行代码
    self.searchBar.text = symbol.data;
    self.isBarCode = YES;
    [self searchBarSearchButtonClicked:self.searchBar];
    //    [self.searchBar becomeFirstResponder];
    [reader dismissModalViewControllerAnimated: YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.m_btn_tiaoma setHighlighted:NO];
    if (adEntries_ == nil || topGoods_ == nil) {
        [homeAction_ requestHomeData];
        [homeTopAction_ requestHomeTopData];
        
        [self showHUD];
         

    }
    if ([SPStatusUtility isUserLogin]) {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    }else{
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    }
}

- (void)viewDidUnload
{
    [self setNewsScrollView:nil];
    [self setHeaderToolBar:nil];
//    [self setTopGoods:nil];
    [self setTableView:nil];
//    [self setAdEntries:nil];
    [self setSearchBar:nil];
    [self setHeaderBar:nil];
    [self setM_btn_tiaoma:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark -让键盘消失的事件；
-(void)hiddenKeyBoard:(id)sender{
    [searchBar_ setText:@""];
    [searchBar_ resignFirstResponder];
    UIControl *l_control=(UIControl *)sender;
    [l_control removeFromSuperview];
}

#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    for (UIView *l_view in [self.view subviews]) {
        if (l_view.tag==ControlTag) {
            [l_view removeFromSuperview];
        }
    }
    
    UIControl *l_control = nil;
    if (isPad) {
        l_control=[[UIControl alloc] initWithFrame:CGRectMake(0, searchBar.frame.origin.y+44, 768, 960)];
    }else{
        l_control=[[UIControl alloc] initWithFrame:CGRectMake(0, searchBar.frame.origin.y+44, 320, 200)];
    }
    [l_control setBackgroundColor:[UIColor clearColor]];
    [l_control setTag:ControlTag];
    [l_control addTarget:self action:@selector(hiddenKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:l_control aboveSubview:tableView_];
    [l_control release];
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *trimStr=searchBar.text;
    BOOL isVaild= [trimStr length]>0;
    if (isVaild && [self isAvaild:searchBar.text]) {
        [searchBar resignFirstResponder];
        [[self.view viewWithTag:ControlTag] removeFromSuperview];
        [Go2PageUtility go2ProductListViewController:self withKeyword:searchBar_.text withBrandID:nil classifiedID:nil title:searchBar_.text isBarCode:self.isBarCode];
        searchBar.text=nil;
        self.isBarCode = NO;
    }else{
        
        UIAlertView *al=[[UIAlertView alloc] initWithTitle:nil message:@"输入格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [al show];
        [al release];
    }
    
}
-(BOOL)isAvaild:(NSString *)str{
    
    NSRange range = [str rangeOfString:@"%"];
    
    if (range.location!=NSNotFound) return NO;
    
    return YES;
}
///////////////////////////////////////////////////////
#pragma mark 点击登陆按钮

- (void)loginAndRegister:(id)sender
{
    KAppDelegate.loginModelViewMotherViewName = @"SPHome";
    [Go2PageUtility go2LoginViewControllerWithSuccessBlock:^{
    }];
}

///////////////////////////////////////////////////////
#pragma mark - SPHomeActionDelegate

-(void)onResponseHomeDataSuccess:(NSArray *)l_arr_homeItem {
    [self hideHUD];
    self.topGoods = l_arr_homeItem;
    [tableView_ reloadData];
}

-(void)onResponseHomeDataFail {
    [self hideHUD];
    
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
}

///////////////////////////////////////////////////////
#pragma mark - SPHomeTopActionDelegate

-(void)onResponseHomeTopDataSuccess:(NSArray *)l_arr_homeItem {
    [self hideHUD];
    
    self.adEntries = l_arr_homeItem;
    pageControl_.numberOfPages = adEntries_.count;
    
    __block typeof(self) bself = self;
    [newsScrollView_ setItemCount:adEntries_.count withDataSource:^UIButton *(NSUInteger pageIndex) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        SPHomeTopData *htd = [bself.adEntries objectAtIndex:pageIndex];
        if (iPad) {
             [button setImageWithURL:[NSURL URLWithString:htd.mPicUrl] placeholderImage:[UIImage imageNamed:@"768-240.png"]];
        }else{
            [button setImageWithURL:[NSURL URLWithString:htd.mPicUrl] placeholderImage:[UIImage imageNamed:@"320-123.png"]];
        }
        button.frame = OUO_RECT(0., 0., bself.newsScrollView.frameWidth, bself.newsScrollView.frameHeight);
        return button;
    }];
    [newsScrollView_ setItemTappedHandler:^(NSUInteger itemIndex) {
        SPHomeTopData *htd = [bself.adEntries objectAtIndex:itemIndex];
        if (htd.mLinkType!=nil) {
            if ([htd.mLinkType isEqualToString:@"Activity"]) {//活动详情 3
                               [Go2PageUtility go2HomeActivityGoodsList:htd.mLinkData from:self];
            }else if([htd.mLinkType isEqualToString:@"Product"]){//商品详情  1  l_data_good.mGoodsSN
                [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:htd.mLinkData from:self];
 
            }else if([htd.mLinkType isEqualToString:@"List"]){//列表
               
                NSArray *arr = [htd.mLinkData componentsSeparatedByString:@"-"];
                [Go2PageUtility go2ProductListViewController:self withKeyword:nil withBrandID:[arr objectAtIndex:1] classifiedID:[arr objectAtIndex:0] title:@"商品列表" isBarCode:NO];
            }else if([htd.mLinkType isEqualToString:@"Search"]){//搜索
                
                [Go2PageUtility go2ProductListViewController:self withKeyword:htd.mLinkData withBrandID:nil classifiedID:nil title:htd.mLinkData isBarCode:NO];
            }else{}
        }
    }];
    [newsScrollView_ setPageWillChangeHandler:^(NSUInteger itemIndex){
        if (bself.timer!=nil) {
            [bself.timer invalidate];
        }
    }];
    [newsScrollView_ setPageChangeHandler:^(NSUInteger itemIndex){
        bself.newsScrollView.currentPage = itemIndex;
        [self startScroll];
    }];
    [self startScroll];
}

- (void)startScroll
{
    __block typeof(self) bself = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 block:^(NSTimeInterval time) {
        if (bself.newsScrollView.currentPage == bself.pageControl.numberOfPages-1) {
            [bself.newsScrollView scrollToPage:0 animated:YES];
        }else{
            [bself.newsScrollView scrollToPage:bself.newsScrollView.currentPage+1 animated:YES];
        }
    } repeats:YES];
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

-(void)onResponseHomeTopDataFail {
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

///////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource and UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 1;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topGoods!=nil) {
        return self.topGoods.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isPad) {
        return 200.0f;
    }else{
        return 128.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SingleRowScrollCell";
    SingleRowScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (isPad) {
            NSArray *nibTableCells = [[NSBundle mainBundle] loadNibNamed:@"SingleRowScrollPadCell" owner:self options:nil];
            cell = [nibTableCells objectAtIndex:0];
            [cell.titleLabel.titleLabel setFont:[UIFont systemFontOfSize:19]];
        }else{
            cell = [SingleRowScrollCell loadFromNIB];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row = indexPath.row;
    SPHomeItemData *hid = [topGoods_ objectAtIndex:row];
    [cell.titleLabel setTitle:hid.mName forState:UIControlStateNormal];
    [cell.scrollView setItemCount:hid.mGoodsArray.count withDataSource:^UIButton *(NSUInteger itemIndex) {
        SPHomeGoodData *hgd = [hid.mGoodsArray objectAtIndex:itemIndex];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.masksToBounds = YES;
        button.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
        button.layer.borderWidth = 1;
        
        if (isPad) {
            button.frame = OUO_RECT(0., 0., 132., 120.);
            [button setImageWithURL:URLImagePath(hgd.mImgFile) placeholderImage:[UIImage imageNamed:@"132-120.png"]];
        }else{
            button.frame = OUO_RECT(0., 0., 95., 91.);
            [button setImageWithURL:URLImagePath(hgd.mImgFile) placeholderImage:[UIImage imageNamed:@"95-91.png"]];
        }
        
        
        UIView *bgView = nil;
        if (isPad) {
            bgView = [[UIView alloc] initWithFrame:OUO_RECT(0., 0., button.frameWidth, 35.)];
        }else{
            bgView = [[UIView alloc] initWithFrame:OUO_RECT(0., 0., button.frameWidth, 23.)];
        }
        bgView.backgroundColor = [UIColor clearColor];
        bgView.frameBottom = button.frameHeight;
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:bgView.bounds];
        priceLabel.textAlignment = UITextAlignmentCenter;
        priceLabel.textColor = [UIColor redColor];
        if (isPad) {
            priceLabel.font = OUO_FONT_BOLD(19.);
        }else{
            priceLabel.font = OUO_FONT_BOLD(17.);
        }
        priceLabel.text = OUO_STRING_FORMAT(@"%@元", hgd.mPrice);
        priceLabel.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.2];
        [bgView addSubview:priceLabel];
        OUOSafeRelease(priceLabel);
        [button addSubview:bgView];
        OUOSafeRelease(bgView);
        return button;
    }];
    [cell.scrollView setItemTappedHandler:^(NSUInteger itemIndex){
        SPHomeGoodData *hgd = [hid.mGoodsArray objectAtIndex:itemIndex];
        [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:hgd.mGoodsSN from:self];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

///////////////////////////////////////////////////////
#pragma mark - Actions

- (IBAction)bibleButtonPressed:(id)sender {
    [Go2PageUtility go2BabyBibleCategoryViewControllerFrom:self];
}

@end
