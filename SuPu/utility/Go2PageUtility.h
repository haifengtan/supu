//
//  Go2PageUtility.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseViewController.h"
#import "SPShoppingCartData.h"
#import "SPAddressListData.h"
@interface Go2PageUtility : NSObject

///////////////////////////////////////////////////////
#pragma mark - 全局模式视图

+ (void)presentModalViewControllerEquippedNavigationController:(SPBaseViewController *)modalViewController;
+ (void)presentModalViewControllerNoAnimatedEquippedNavigationController:(SPBaseViewController *)modalViewController;
+ (void)dismissModalViewController;

///////////////////////////////////////////////////////
#pragma mark -

/**
* 在做某个动作前需要先登录时调用这个
*
* @param  loginSuccessBlock  登录完成之后要做的东东
*/
+ (void)go2LoginViewControllerWithSuccessBlock:(void(^)(void))loginSuccessBlock;

+ (void)go2LoginViewNoAnimatedControllerWithSuccessBlock:(void(^)(void))loginSuccessBlock;

+ (void)go2WeiboComposeViewControllerFrom:(SPBaseViewController *)viewCtrl shareText:(NSString *)shareText;

+(void)go2wayViewController:(SPBaseViewController *)viewCtrl
                  withTitle:(NSString *)title
                      state:(BOOL)isway
                    areaId:(NSString *)areaId
                  paymentId:(NSString *)paymentId
             lastselectname:(NSString *)lastselectname;
+(void)go2messageViewController:(SPBaseViewController *)viewCtrl
userId:(NSString *)userId remark:(NSString *)remark;

+(void)go2blanceAccountViewController:(SPBaseViewController *)viewCtrl
                         shopCartData:(SPShoppingCartData *)shopCartData;

/**
 * 跳到商品详情
 *
 * @param  sn  商品编号
 * @param  viewCtrl  前控制器
 */
+ (void)go2ProductDetailViewControllerWithGoodsSN:(NSString *)sn
                                             from:(SPBaseViewController *)viewCtrl;

+ (void)go2ProductCommentViewControllerWithGoodsSN:(NSString *)sn
                                             from:(SPBaseViewController *)viewCtrl;

/**
 * 孕婴宝典分类
 */
+ (void)go2BabyBibleCategoryViewControllerFrom:(SPBaseViewController *)viewCtrl;

/**
 * 孕婴宝典文章列表
 */
+ (void)go2BabyBibleArticleListViewControllerWithCateID:(NSString *)cateID
                                                   from:(SPBaseViewController *)viewCtrl;


/**
 * 孕婴宝典文章列表
 */
+ (void)go2BabyBibleArticleDetailViewControllerWithArticleID:(NSString *)identifier
                                                   from:(SPBaseViewController *)viewCtrl;

/**
 *  地址管理控制器
 */
+ (void)go2AddressManagerViewControllerFrom:(SPBaseViewController *)viewCtrl
                                     isEdit:(BOOL)isEdit;


/**
 *  创建地址列表
 */
+ (void)go2BuildAddressListViewControllerFrom:(SPBaseViewController *)viewCtrl
                                     isModify:(BOOL)isModify
                              addressListData:(SPAddressListData *)listData;



//分类子集
+ (void)go2CategoryViewController:(SPBaseViewController*)viewCtrl withBrandID:(NSString*)l_str_brandID classifiedID:(NSString*)l_str_classified title:(NSString*)l_str_title;

//商品列表
+(void)go2ProductListViewController:(SPBaseViewController*)viewCtrl withKeyword:(NSString*)l_str_keyword withBrandID:(NSString*)l_str_brandID classifiedID:(NSString*)l_str_classified title:(NSString*)l_str_title isBarCode:(BOOL)isBarCode;
//筛选
+(void)go2ProductFilterViewController:(SPBaseViewController *)viewCtrl withFilterDataDict:(NSMutableDictionary*)dict;
//优惠活动列表
+ (void)go2ClassifyDiscountActivityList:(NSArray *)discountactivityarr
                                   from:(SPBaseViewController *)viewCtrl;

//商品详情列表
+ (void)go2ClassifyGoodsDescrption:(NSString *)sn from:(SPBaseViewController *)viewCtrl;

//商品咨询列表
+ (void)go2ClassifyGoodsConsult:(NSString *)sn from:(SPBaseViewController *)viewCtrl;


//活动详情列表
+ (void)go2HomeActivityGoodsList:(NSString *)activitid from:(SPBaseViewController *)viewCtrl;

+ (void)go2DiscountCardListViewControllerFrom:(SPBaseViewController *)viewCtrl pageName:(NSString *)pageName fromWhere:(NSString *)whereString;




//浏览记录
+(void)go2BrowerViewController:(SPBaseViewController*)viewCtrl;

//查看大图
+ (void)go2ProductLargeImageViewController:(SPBaseViewController *)viewCtrl imageurl:(NSURL *)imageurl;//遗弃的方法
+ (void)go2ProductLargeImageViewController2:(SPBaseViewController *)viewCtrl2 imageurl2:(NSArray *)imageurl2 index:(int)ind;
//支付选择方式页面

+ (void)go2PayTypeChooseViewControllerFrom:(SPBaseViewController *)viewCtrl orderNo:(NSString *)orderNo orderAmount:(NSString *)orderAmount;

/**
 *	@brief 订单详情
 *	
 *	压栈到订单详情界面
 *
 *	@param 	viewCtrl 	主控制器
 *	@param 	orderNo 	订单号
 */
+(void)go2OrderDetailsViewController:(SPBaseViewController *)viewCtrl
                             orderNo:(NSString *)orderNo
                         isBackStyle:(BOOL)isStyle;

@end
