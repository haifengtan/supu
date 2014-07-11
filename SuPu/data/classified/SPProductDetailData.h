//
//  SPProductDetailData.h
//  SuPu
//
//  商品详情
//
//  Created by xx on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPProductDetailData : SPBaseData

@property(nonatomic,retain)NSString *mGoodsSN;//商品编号
@property(nonatomic,retain)NSString *mGoodsName;//商品名称
@property(nonatomic,retain)NSString *mMarketPrice;//市场价
@property(nonatomic,retain)NSString *mShopPrice;//速普价
@property(nonatomic,retain)NSString *mGoodsSlogan;//广告语
@property(nonatomic,retain)NSString *mGoodsScore;//商品评分
@property(nonatomic,retain)NSString *mCategoryID;//类型编号
@property(nonatomic,retain)NSString *mBrandID;//品牌编号
@property(nonatomic,retain)NSString *mCommentCount;//评论数
@property(nonatomic,retain)NSString *mConsultCount;//咨询数
@property(nonatomic,retain)NSArray *mGoodsImages;//商品图片数组
@property(nonatomic,retain)NSString *mShareText;//分享内容
@property(nonatomic,retain)NSString *mIsNoStock;//库存
@end

/**
 *	@brief	商品图片
 *	
 *	商品图片
 */
@interface SPProductGoodsImage : SPBaseData


@property(nonatomic,retain)NSString *mGoodsSN;//商品编号
@property(nonatomic,retain)NSString *mName;//图片名称(含扩展名)

@property(nonatomic,retain)NSString *mImgFile;//大图片路径
@property(nonatomic,retain)NSString *mSmallImgFile;//小图路径

//@property(nonatomic,retain)NSString *mExtension;//扩展名
@end