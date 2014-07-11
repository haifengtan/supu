//
//  SPBabyBibleArticleDetailViewController.m
//  SuPu
//
//  Created by 杨福军 on 12-10-31.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBabyBibleArticleDetailViewController.h"
#import "SPBabyBibleArticleDetailCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SPBabyBibleArticleDetailViewController ()
@property (copy, nonatomic) NSString *articleID;
@property (retain, nonatomic) SPArticleDetailAction *adAction;
@property (retain, nonatomic) SPArticleItemData *aiData;        ///文章内容
@property (retain, nonatomic) NSArray *dataSource;
@property BOOL isPad;
@end

@implementation SPBabyBibleArticleDetailViewController
@synthesize dataSource = dataSource_;
@synthesize tableView = tableView_;
@synthesize adAction = adAction_;
@synthesize articleID = articleID_;
@synthesize webView = webView_;
@synthesize webviewfather = webviewfather_;
@synthesize aiData = aiData_;
@synthesize isPad;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(dataSource_);
    OUOSafeRelease(tableView_);
    OUOSafeRelease(adAction_);
    OUOSafeRelease(articleID_);
    OUOSafeRelease(webView_);
    OUOSafeRelease(webviewfather_);
    OUOSafeRelease(aiData_);
    [super dealloc];
}

- (void)viewDidUnload {
//    self.dataSource = nil;
    self.tableView = nil;
    self.tableView = nil;
    self.adAction = nil;
//    self.articleID = nil;
    self.webView = nil;
    self.webviewfather = nil;
//    self.aiData = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithArticleID:(NSString *)identifier {
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.articleID = identifier;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPBabyBibleArticleDetailPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:@"SPBabyBibleArticleDetailViewController" bundle:nil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{   
    [super viewDidLoad];
    self.title = @"孕婴宝典";
    self.UMStr = @"孕婴宝典";
  
    self.webView.layer.cornerRadius = 10;//调节圆角的大小，数值越大，圆角的拐弯越大
    self.webView.layer.masksToBounds = YES;
    self.webView.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
    self.webView.layer.borderWidth = 1;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    if (self.isPad) {
        self.webView.frame =CGRectZero;
    }else{
        self.webView.frame =CGRectZero;
    }
//    self.tableView.tableHeaderView = self.webView;

    adAction_ = [[SPArticleDetailAction alloc] init];
    adAction_.m_delegate_articleDetail = self;
    [adAction_ requestArticleDetailData];
    [self showHUD];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [tableView_ deselectRowAtIndexPath:[tableView_ indexPathForSelectedRow] animated:YES];
}

///////////////////////////////////////////////////////
#pragma mark -

-(NSDictionary*)onResponseArticleDetailDataAction {
    return OUO_DICT(articleID_, @"Id");
}

-(void)onResponseArticleDetailDataSuccess:(SPArticleData *)l_data_article {
    [self hideHUD];
    
    self.dataSource = l_data_article.mArticleGoodsArray;
    self.aiData = l_data_article.mArticle;
    NSString *webviewcontent = [NSString stringWithFormat:@"<center><label>%@</label></center>%@",aiData_.mTitle,aiData_.mContent];
    [webView_ loadHTMLString:webviewcontent baseURL:nil];
 
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   
    float height = [[webView_ stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
  
    if (self.isPad) {
        webView.frame = CGRectMake(34, 30, 700, height);
    }else{
        webView.frame = CGRectMake(8, 15, 304, height);
    }
    [tableView_ reloadData];
}

-(void)onResponseArticleDetailDataFail {
    [self hideHUD];
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
    NSInteger count = self.dataSource.count + 1;
    
    if (count == 1) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isPad) {
        if (indexPath.row ==0) {
            return webView_.frame.size.height + 60;
        }else{
            CGFloat height = 146.0;
            return height;
        }
    }else{
        if (indexPath.row ==0) {
            return webView_.frame.size.height + 30;
        }else{
            CGFloat height = 73.0;
            return height;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SPBabyBibleArticleDetailCell";
    SPBabyBibleArticleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (self.isPad) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SPBabyBibleArticleDetailPadCell" owner:nil options:nil] objectAtIndex:0];
        }else{
            cell = [SPBabyBibleArticleDetailCell loadFromNIB];
        }
        if (indexPath.row == 0) {
            [cell.contentView addSubview:webView_];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    if (indexPath.row != 0) {
        SPArticleGoodData *agd = [dataSource_ objectAtIndex:indexPath.row-1];
        cell.titleLabel.text = agd.mGoodsName;
        cell.introLabel.text = agd.mGooodsIntro;
        cell.priceLabel.text = OUO_STRING_FORMAT(@"￥%@", agd.mPrice);
      
        NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil || (showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
//            [cell.productImageView setImageWithURL:URLImagePath(agd.mImgFile)];
//            [cell.productImageView setImageWithURL:URLImagePath(agd.mImgFile) placeholderImage:kDefaultImage];
            if (iPad) {
                [cell.productImageView setImageWithURL:URLImagePath(agd.mImgFile) placeholderImage:[UIImage imageNamed:@"126-126.png"]];
            }else{
                [cell.productImageView setImageWithURL:URLImagePath(agd.mImgFile) placeholderImage:[UIImage imageNamed:@"60-60.png"]];
            }
        }else{
            if (iPad) {
                [cell.productImageView setImage:[UIImage imageNamed:@"126-126.png"]];
            }else{
                [cell.productImageView setImage:[UIImage imageNamed:@"60-60.png"]];
            }
//            [cell.productImageView setImage:kDefaultImage];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!= 0) {
        SPArticleGoodData *agd = [dataSource_ objectAtIndex:indexPath.row-1];
        [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:agd.mGoodsSN from:self];
    }
}

@end
