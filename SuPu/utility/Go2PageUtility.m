//
//  Go2PageUtility.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "Go2PageUtility.h"
#import "PersonalOrderDetail.h"
#import "SPWayViewController.h"
#import "SPMessageViewController.h"
#import "SPBalanceAccountViewController.h"
#import "SPProductDetailViewController.h"
#import "SPBabyBibleCategoryViewController.h"
#import "SPActionUtility.h"
#import "SPAddressManagerViewController.h"
#import "SPAddAddressViewController.h"
#import "SPBabyBibleArticleListViewController.h"
#import "SPBabyBibleArticleDetailViewController.h"
#import "SPCategoryViewController.h"
#import "SPAppDelegate.h"
#import "SPProductCommentViewController.h"
#import "LoginViewController.h"
#import "SPProductListViewController.h"
#import "SPDiscountActivityList.h"
#import "SPClassifyGoodsDescrption.h"
#import "SPClassifyGoodsConsult.h"
#import "SPFilterViewController.h"
#import "SPHomeActivityGoodsList.h"
#import "SPBrowerViewController.h"
#import "SPWeiboComposeViewController.h"
#import "DiscountCardList.h"
#import "SPProductLargeImageViewController.h"
#import "SPPayTypeChooseViewController.h"

@implementation Go2PageUtility

+ (void)presentModalViewControllerEquippedNavigationController:(SPBaseViewController *)modalViewController {
    OUONavigationController *navController = [[OUONavigationController alloc] initWithRootViewController:modalViewController];
    [KAppDelegate.m_tabBarCtrl presentModalViewController:navController animated:YES];
    [navController release];
}

+ (void)presentModalViewControllerNoAnimatedEquippedNavigationController:(SPBaseViewController *)modalViewController {
    OUONavigationController *navController = [[OUONavigationController alloc] initWithRootViewController:modalViewController];
    [KAppDelegate.m_tabBarCtrl presentModalViewController:navController animated:NO];
    [navController release];
}

+ (void)dismissModalViewController {
    [KAppDelegate.m_tabBarCtrl dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////
#pragma mark -

+ (void)go2LoginViewControllerWithSuccessBlock:(void(^)(void))loginSuccessBlock {
    if ([SPStatusUtility isUserLogin]) {
        loginSuccessBlock();
        return;
    }
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [lvc setLoginSuccessBlock:loginSuccessBlock];
    [[self class] presentModalViewControllerEquippedNavigationController:lvc];
    [lvc release];
}

+ (void)go2LoginViewNoAnimatedControllerWithSuccessBlock:(void(^)(void))loginSuccessBlock {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [lvc setLoginSuccessBlock:loginSuccessBlock];
    [[self class] presentModalViewControllerNoAnimatedEquippedNavigationController:lvc];
    [lvc release];
}

+ (void)go2WeiboComposeViewControllerFrom:(SPBaseViewController *)viewCtrl shareText:(NSString *)shareText {
    SPWeiboComposeViewController *wcvc = [[SPWeiboComposeViewController alloc] init];
    wcvc.shareText = shareText;
    [viewCtrl.navigationController pushViewController:wcvc animated:YES];
    [wcvc release];
}

+(void)go2wayViewController:(SPBaseViewController *)viewCtrl
                  withTitle:(NSString *)title
                      state:(BOOL)isway
                     areaId:(NSString *)areaId
                  paymentId:(NSString *)paymentId
             lastselectname:(NSString *)lastselectname
{
    SPWayViewController *way=[[SPWayViewController alloc] init];
    way.navTitle=title;
    way.wayState=isway;
    way.areaId=areaId;
    way.delegate=(id)viewCtrl;
    way.paymentId = paymentId;
    way.lastselectname = lastselectname;
    [viewCtrl.navigationController pushViewController:way animated:YES];
    [way release];
}
+(void)go2messageViewController:(SPBaseViewController *)viewCtrl
                         userId:(NSString *)userId remark:(NSString *)remark{
    SPMessageViewController *message=[[SPMessageViewController alloc] init];
    message.remark =remark;
    [viewCtrl.navigationController pushViewController:message animated:YES];
    [message release];
}

+(void)go2blanceAccountViewController:(SPBaseViewController *)viewCtrl
                         shopCartData:(SPShoppingCartData *)shopCartData{
    SPBalanceAccountViewController *blanceAccount=[[SPBalanceAccountViewController alloc] init];
    blanceAccount.shopCartData=shopCartData;
    [viewCtrl.navigationController pushViewController:blanceAccount animated:YES];
    [blanceAccount release];
}

+ (void)go2ProductDetailViewControllerWithGoodsSN:(NSString *)sn
                                             from:(SPBaseViewController *)viewCtrl {

    if (sn) {
        SPProductDetailViewController *pdvc = [[SPProductDetailViewController alloc] initWithGoodsSN:sn];
        [viewCtrl.navigationController pushViewController:pdvc animated:YES];
        [pdvc release];
    }
   
}

+ (void)go2ClassifyDiscountActivityList:(NSArray *)discountactivityarr
                                   from:(SPBaseViewController *)viewCtrl {
    SPDiscountActivityList *sdal = [[SPDiscountActivityList alloc] init];
    sdal.discountactivityarr = discountactivityarr;
    [viewCtrl.navigationController pushViewController:sdal animated:YES];
    [sdal release];
}

+ (void)go2ClassifyGoodsDescrption:(NSString *)sn from:(SPBaseViewController *)viewCtrl {
    SPClassifyGoodsDescrption *scgd = [[SPClassifyGoodsDescrption alloc] init];
    scgd.goodssn = sn;
    [viewCtrl.navigationController pushViewController:scgd animated:YES];
    [scgd release];
}

+ (void)go2ClassifyGoodsConsult:(NSString *)sn from:(SPBaseViewController *)viewCtrl{
    SPClassifyGoodsConsult *scgc = [[SPClassifyGoodsConsult alloc] init];
    scgc.goodssn = sn;
    [viewCtrl.navigationController pushViewController:scgc animated:YES];
    [scgc release];
}

+ (void)go2ProductCommentViewControllerWithGoodsSN:(NSString *)sn
                                              from:(SPBaseViewController *)viewCtrl {
    SPProductCommentViewController *pcvc = [[SPProductCommentViewController alloc] init];
    pcvc.goodsSN = sn;
    [viewCtrl.navigationController pushViewController:pcvc animated:YES];
    [pcvc release];
}

+ (void)go2BabyBibleCategoryViewControllerFrom:(SPBaseViewController *)viewCtrl {
    SPBabyBibleCategoryViewController *bbcvc = [[SPBabyBibleCategoryViewController alloc] initWithStyle:UITableViewStylePlain];
    [viewCtrl.navigationController pushViewController:bbcvc animated:YES];
    [bbcvc release];
}

+ (void)go2BabyBibleArticleListViewControllerWithCateID:(NSString *)cateID
                                                   from:(SPBaseViewController *)viewCtrl {
    SPBabyBibleArticleListViewController *alvc = [[SPBabyBibleArticleListViewController alloc] initWithCategoryID:cateID];
    [viewCtrl.navigationController pushViewController:alvc animated:YES];
    [alvc release];
}

+ (void)go2BabyBibleArticleDetailViewControllerWithArticleID:(NSString *)identifier
                                                        from:(SPBaseViewController *)viewCtrl {
    SPBabyBibleArticleDetailViewController *advc = [[SPBabyBibleArticleDetailViewController alloc] initWithArticleID:identifier];
    [viewCtrl.navigationController pushViewController:advc animated:YES];
    [advc release];
}

+ (void)go2AddressManagerViewControllerFrom:(SPBaseViewController *)viewCtrl
                                     isEdit:(BOOL)isEdit{
    SPAddressManagerViewController *addressManager=[[SPAddressManagerViewController alloc] init];
    addressManager.isEdit=isEdit;
    addressManager.addressListDelegate=(id)viewCtrl;
    [viewCtrl.navigationController pushViewController:addressManager animated:YES];
    [addressManager release];
}

+ (void)go2DiscountCardListViewControllerFrom:(SPBaseViewController *)viewCtrl pageName:(NSString *)pageName fromWhere:(NSString *)whereString
{
    DiscountCardList *discountcard = [[DiscountCardList alloc] init];
    discountcard.parentcontrolname = pageName;
    discountcard.delegate = (id)viewCtrl;
    discountcard.fromWhereToThis = whereString;
    [viewCtrl.navigationController pushViewController:discountcard animated:YES];
    [discountcard release];
}

+ (void)go2BuildAddressListViewControllerFrom:(SPBaseViewController *)viewCtrl
                                     isModify:(BOOL)isModify
                              addressListData:(SPAddressListData *)listData{
    SPAddAddressViewController *buildAddress=[[SPAddAddressViewController alloc] init];
    buildAddress.isModify=isModify;
    buildAddress.listData=listData;
    [viewCtrl.navigationController pushViewController:buildAddress animated:YES];
    [buildAddress release];
}

//分类子集
+ (void)go2CategoryViewController:(SPBaseViewController*)viewCtrl withBrandID:(NSString*)l_str_brandID classifiedID:(NSString*)l_str_classified title:(NSString*)l_str_title{
    SPCategoryViewController *l_ctrl_category=[[SPCategoryViewController alloc] initWithNibName:@"SPCategoryViewController" bundle:nil];
    l_ctrl_category.m_str_categoryID=l_str_brandID;//品牌
    
    l_ctrl_category.m_str_parentID=l_str_classified;//品类
    l_ctrl_category.m_str_title=l_str_title;
    [viewCtrl.navigationController pushViewController:l_ctrl_category animated:YES];
    [l_ctrl_category release];
}

//商品列表
+(void)go2ProductListViewController:(SPBaseViewController*)viewCtrl withKeyword:(NSString*)l_str_keyword withBrandID:(NSString*)l_str_brandID classifiedID:(NSString*)l_str_classified title:(NSString*)l_str_title isBarCode:(BOOL)isBarCode{
    
    SPProductListViewController *l_ctrl_productList=[[SPProductListViewController alloc] initWithNibName:@"SPProductListViewController" bundle:nil];
    if (isBarCode) {//如果是条形码扫描
        l_ctrl_productList.m_str_barcode=l_str_keyword;
    }else{
        l_ctrl_productList.m_str_keyword=l_str_keyword;
    }
    l_ctrl_productList.m_str_brandId=l_str_brandID;
    l_ctrl_productList.m_str_categoryId=l_str_classified;
    l_ctrl_productList.m_str_title=l_str_title;
    
    [viewCtrl.navigationController pushViewController:l_ctrl_productList animated:YES];
    [l_ctrl_productList release];
}

//商品筛选
+(void)go2ProductFilterViewController:(SPBaseViewController *)viewCtrl withFilterDataDict:(NSMutableDictionary*)dict{
    SPFilterViewController *productFilterController=[[SPFilterViewController alloc] initWithNibName:@"SPFilterViewController" bundle:nil withFilterDict:dict];
//    productFilterController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    productFilterController.m_delegate_filter=(SPProductListViewController*)viewCtrl;
    
//    [viewCtrl presentModalViewController:productFilterController animated:YES];
//	[productFilterController release];
    [viewCtrl.navigationController pushViewController:productFilterController animated:YES];
    [productFilterController release];
}

+ (void)go2HomeActivityGoodsList:(NSString *)activitid from:(SPBaseViewController *)viewCtrl{
    SPHomeActivityGoodsList *homeactivity = [[SPHomeActivityGoodsList alloc] init];
    homeactivity.activityid = activitid;
    [viewCtrl.navigationController pushViewController:homeactivity animated:YES];
    [homeactivity release];
}


+(void)go2BrowerViewController:(SPBaseViewController*)viewCtrl{
    SPBrowerViewController *l_viewCtrl_brower=[[SPBrowerViewController alloc] initWithNibName:@"SPBrowerViewController" bundle:nil];
    [viewCtrl.navigationController pushViewController:l_viewCtrl_brower animated:YES];
    [l_viewCtrl_brower release];
}

+ (void)go2ProductLargeImageViewController:(SPBaseViewController *)viewCtrl imageurl:(NSURL *)imageurl{
    SPProductLargeImageViewController *largeview = [[SPProductLargeImageViewController alloc] init];
    largeview.imageurl = imageurl;
    [viewCtrl.navigationController pushViewController:largeview animated:YES];
    [largeview release];
}

+ (void)go2ProductLargeImageViewController2:(SPBaseViewController *)viewCtrl2 imageurl2:(NSArray *)imageurl2 index:(int)ind{
    SPProductLargeImageViewController *largeview = [[SPProductLargeImageViewController alloc] init];
    largeview.imageurlArray = imageurl2;
    largeview.tapIndex = ind;
    [viewCtrl2.navigationController pushViewController:largeview animated:YES];
    [largeview release];
}

+ (void)go2PayTypeChooseViewControllerFrom:(SPBaseViewController *)viewCtrl orderNo:(NSString *)orderNo orderAmount :(NSString *)orderAmount  {
    SPPayTypeChooseViewController *paytype = [[SPPayTypeChooseViewController alloc] init];
    paytype.orderNo = orderNo;
    paytype.orderAmount = orderAmount;
    [viewCtrl.navigationController pushViewController:paytype animated:YES];
    [paytype release];
}
+(void)go2OrderDetailsViewController:(SPBaseViewController *)viewCtrl
                             orderNo:(NSString *)orderNo
                         isBackStyle:(BOOL)isStyle{
    
    PersonalOrderDetail *orderDetails = [[PersonalOrderDetail alloc] init];
    orderDetails.orderSN = orderNo;
    orderDetails.isStyle = isStyle;
    [viewCtrl.navigationController pushViewController:orderDetails animated:YES];
    [orderDetails release];
}
@end
