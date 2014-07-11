//
//  SPProductDetailViewController.m
//  SuPu
//
//  Created by 杨福军 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductDetailViewController.h"
#import "SPProductDetailCell.h"
#import "SPAppDelegate.h"
#import "CustomPageControl.h"

@interface SPProductDetailViewController ()
@property (retain, nonatomic) SPProductDetailAction       *pdAction;
@property (retain, nonatomic) SPAddToShoppingCartAction *scAction;
@property (retain, nonatomic) SPProductDetailData *dataSource;
@property (retain, nonatomic) SPAddCollectListAction *afAction;
@property (retain, nonatomic) NSString *goodsSN;
@property (retain, nonatomic) NSArray *discountactivityarr;
@property (retain, nonatomic) SPProductDetailCell *pdCell;
@property BOOL isPad;
@end

@implementation SPProductDetailViewController
@synthesize dataSource = dataSource_;
@synthesize tableView = tableView_;
@synthesize pdAction = pdAction_;
@synthesize scAction = scAction_;
@synthesize goodsSN = goodsSN_;
@synthesize afAction = afAction_;
//@synthesize discountactivityarr = discountactivityarr_;
@synthesize pdCell;
@synthesize isPad;

///////////////////////////////////////////////////////
#pragma mark - 内存管理

- (void)dealloc {
    OUOSafeRelease(dataSource_);
    OUOSafeRelease(tableView_);
    OUOSafeRelease(pdAction_);
    OUOSafeRelease(scAction_);
    OUOSafeRelease(goodsSN_);
    OUOSafeRelease(afAction_);
//    OUOSafeRelease(discountactivityarr_)
//    OUOSafeRelease(pdCell);//该变量不需要释放，后面在创建的时候，不是用的alloc形式创建的，将会在那里自动释放，所以这里不释放
    [super dealloc];
}


- (void)viewDidUnload {
 
    self.tableView = nil;
    self.pdAction = nil;
    self.scAction = nil;
    self.afAction=nil;
 
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithGoodsSN:(NSString *)goodsSN {
    self.isPad = iPad;
    if (isPad) {
        self = [self initWithNibName:@"SPProductDetailPadViewController" bundle:nil];
    }else{
        self = [self initWithNibName:@"SPProductDetailViewController" bundle:nil];
    }
    self.goodsSN = goodsSN;
    return self;
}
 

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    self.title = @"商品详情";
    self.UMStr = @"商品详情";
    
    __block typeof(self) bself = self;
    [bself setRightBarButtonWithTitle:@"分享" handler:^(id sender) {
        
        [Go2PageUtility go2WeiboComposeViewControllerFrom:bself shareText:bself.dataSource.mShareText];
 
    }];
    
 
    
    pdAction_ = [[SPProductDetailAction alloc] init];
    pdAction_.m_delegate_productDetail = self;
    [pdAction_ requestProductDetailData];
    [self showHUD];

    KAppDelegate.loginModelViewMotherViewName = @"SPProductDetail";
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [tableView_ deselectRowAtIndexPath:[tableView_ indexPathForSelectedRow] animated:YES];
}


////////////////////////////////////////////////////////////////

#pragma mark - UITableViewDataSource and UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 1;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 5;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isPad) {
        CGFloat height = 74.0;
        switch (indexPath.row) {
            case 0:
                height = 566.;
                break;
            case 1:
                if (self.discountactivityarr == nil || self.discountactivityarr.count == 0) {
                    height = 0;
                }else{
                    height = 74;
                }
                break;
            default:
                break;
        }
        return height;
    }else{
        CGFloat height = 35.0;
        switch (indexPath.row) {
            case 0:
                height = 302.;
                break;
            case 1:
                if (self.discountactivityarr == nil || self.discountactivityarr.count == 0) {
                    height = 0;
                }else{
                    height = 35;
                }
                break;
            default:
                break;
        }
        return height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    static NSString *ProductDetailCellID = @"SPProductDetailCell";
    static NSString *NormalCellID = @"SPProductDetailCellNormal";
    NSString *cellID = (row == 0? ProductDetailCellID : NormalCellID);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        if (row == 0) {
            if (isPad) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SPProductDetailPadCell" owner:nil options:nil] objectAtIndex:0];
            }else{
                cell = [SPProductDetailCell loadFromNIB];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UILabel *celllabel = [[UILabel alloc] init];
            if (isPad) {
                celllabel.frame = CGRectMake(45, 20, 550, 34);
                [celllabel setFont:[UIFont boldSystemFontOfSize:20]];
            }else{
                celllabel.frame = CGRectMake(25, 9, 240, 16);
                [celllabel setFont:[UIFont boldSystemFontOfSize:13]];
            }
            celllabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:celllabel];
            [celllabel release];
        }
        UIImageView *cellbackgroundview = [[UIImageView alloc] initWithFrame:cell.bounds];
        cellbackgroundview.image = [UIImage imageNamed:@"背景.png"];
        cell.backgroundView = cellbackgroundview;
        [cellbackgroundview release];
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    switch (row) {
        case 0:
        {
            pdCell = (SPProductDetailCell *)cell;
            pdCell.titleLabel.text = dataSource_.mGoodsName;
            pdCell.sloganLabel.text = dataSource_.mGoodsSlogan;
            pdCell.snLabel.text = dataSource_.mGoodsSN;
          
            pdCell.marketPriceLabel.text = OUO_STRING_FORMAT(@"%@",strOrEmpty(dataSource_.mMarketPrice));
            pdCell.supuPriceLabel.text = OUO_STRING_FORMAT(@"速普价：%@", strOrEmpty(dataSource_.mShopPrice));
            pdCell.saveLabel.text = OUO_STRING_FORMAT(@"%.2f", [dataSource_.mMarketPrice floatValue] - [dataSource_.mShopPrice floatValue]);
            __block typeof(self) bself = self;
            
            pdCell.imagescrollfatherview.backgroundColor = [UIColor colorWithRed:0.86 green:0.87 blue:0.86 alpha:1.00];
            CustomPageControl *pageControl = [[CustomPageControl alloc] init];
            if (isPad) {
                pageControl.frame = CGRectMake((768-400)/2, 268, 400, 30);
            }else{
                pageControl.frame = CGRectMake((320-200)/2, 120, 200, 36);
            }
            pageControl.backgroundColor = [UIColor clearColor];  //设置背景颜色 不设置默认是黑色
            pageControl.numberOfPages = dataSource_.mGoodsImages.count;
            pageControl.currentPage = 0;
            pageControl.otherColour = [UIColor colorWithRed:0.44 green:0.43 blue:0.44 alpha:1.00];//其他点的颜色
            pageControl.currentColor = [UIColor redColor];  //当前点的颜色
            
            pageControl.controlSize = 7;  //点的大小
            pageControl.controlSpacing = 7;  //点的间距
            
            [pdCell.imagescrollfatherview addSubview:pageControl];
            
            pdCell.imageScrollView.pageControl = (UIPageControl *)pageControl;
            [pageControl release];
            
            [pdCell.imageScrollView setItemCount:dataSource_.mGoodsImages.count withDataSource:^UIButton *(NSUInteger itemIndex) {
                SPProductGoodsImage *img = [bself.dataSource.mGoodsImages objectAtIndex:itemIndex];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.userInteractionEnabled = YES;
                button.backgroundColor = [UIColor whiteColor];
                if (isPad) {
                    button.frame = OUO_RECT(0., 0., 262, 262);
                }else{
                    button.frame = OUO_RECT(0., 0., 126, 126);
                }
                if (iPad) {
                    [button setImageWithURL:URLImagePath(img.mSmallImgFile)  placeholderImage:[UIImage imageNamed:@"262-262.png"]];
                }else{
                    [button setImageWithURL:URLImagePath(img.mSmallImgFile)  placeholderImage:[UIImage imageNamed:@"126-126.png"]];
                }
                
                return button;
            }];
            
            [pdCell.imageScrollView setItemTappedHandler:^(NSUInteger itemIndex){
 
                
                [Go2PageUtility go2ProductLargeImageViewController2:bself imageurl2:bself.dataSource.mGoodsImages index:itemIndex];
            }];
            
            [pdCell.cartButton removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
            [pdCell.cartButton addEventHandler:^(id sender) {
               
                [Go2PageUtility go2LoginViewControllerWithSuccessBlock:^{
                    bself.scAction = nil;
                    bself->scAction_ = [[SPAddToShoppingCartAction alloc] init];
                    bself.scAction.m_delegate_shopCart = bself;
                    [bself.scAction requestAddToShoppingCartData];
                    [bself showHUD];
                }];
            } forControlEvents:UIControlEventTouchUpInside];
            
            [pdCell.collectButton removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
            [pdCell.collectButton addEventHandler:^(id sender) {
                [Go2PageUtility go2LoginViewControllerWithSuccessBlock:^{
                    bself.afAction = nil;
                    bself->afAction_ = [[SPAddCollectListAction alloc] init];
                    bself.afAction.m_delegate_addCollect = bself;
                    [bself.afAction requestAddCollectList];
                    [bself showHUD];
                }];
            } forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case 1:
            if (self.discountactivityarr==nil ||self.discountactivityarr.count==0) {
                cell.hidden = YES;
            }else{
                ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).textColor = [UIColor redColor];
                ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = @"此商品可参加的优惠活动";
                cell.hidden = NO;
            }
            break;
        case 2:
            ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = @"商品描述";
            break;
        case 3:
            ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = OUO_STRING_FORMAT(@"购买评论(%d)", [dataSource_.mCommentCount intValue]);
            break;
        case 4:
            ((UILabel *)[[cell.contentView subviews] objectAtIndex:0]).text = OUO_STRING_FORMAT(@"商品咨询(%d)", [dataSource_.mConsultCount intValue]);
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    switch (row) {
        case 1:{
            [Go2PageUtility go2ClassifyDiscountActivityList:self.discountactivityarr from:self];
            break;
        }
        case 2:{
            [Go2PageUtility go2ClassifyGoodsDescrption:goodsSN_ from:self];
            break;
        }
        case 3:
            [Go2PageUtility go2ProductCommentViewControllerWithGoodsSN:goodsSN_ from:self];
            break;
        case 4:
            [Go2PageUtility go2ClassifyGoodsConsult:goodsSN_ from:self];
            break;
        default:
            break;
    }
}



///////////////////////////////////////////////////////
#pragma mark - SPProductDetailActionDelegate

-(NSDictionary*)onResponseProductDetailAction {
    return OUO_DICT(goodsSN_, @"GoodsSN");
}

-(void)onResponseProductDetailDataSuccess:(SPProductDetailData *)l_data_productDetail {
    [self hideHUD];
    
    self.dataSource = l_data_productDetail;
    if (self.dataSource.mIsNoStock!=nil && [self.dataSource.mIsNoStock isEqualToString:@"True"]) {
        self.pdCell.cartButton.hidden = YES;
    }else{
        self.pdCell.cartButton.hidden = NO;
    }
    [tableView_ reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        tableView_.alpha = 1.;
    }];
    
    [SPStatusUtility saveBrowerData:l_data_productDetail];
}

-(void)onResponseProductDetailDataFail {
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

///////////////////////////////////////////////////////
#pragma mark - SPAddToShoppingCartActionDelegate

-(NSDictionary *)onRequestAddToShoppingCart {
    return OUO_DICT(OUO_STRING_FORMAT(
                                      @"%@:1:+=", dataSource_.mGoodsSN), @"goods"
                    );
}

-(void)onResponseAddToShoppingCartSuccess {
    [self hideHUDWithCompletionMessage:@"已添加到购物车"];
}

-(void)onResponseAddToShoppingCartFail {
    [self hideHUDWithCompletionMessage:@"无法添加到购物车"];
}

#pragma mark - SPAddCollectListActionDelegate

-(NSDictionary*)onResponseAddCollectListAction{
    return OUO_DICT(strOrEmpty(goodsSN_),@"GoodsSN");
}

-(void)onResponseAddCollectListSuccess{
    [self hideHUDWithCompletionMessage:@"收藏成功"];
}

-(void)onResponseAddCollectListFail{
    [self hideHUD];
  
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 3) {
        [Go2PageUtility go2WeiboComposeViewControllerFrom:self shareText:self.dataSource.mShareText];
    }
}

@end
