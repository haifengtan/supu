//
//  SPProductListData.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"
#import "SPPageInfoData.h"

@interface SPProductListData : SPBaseData

@property(nonatomic,retain)SPPageInfoData *mpageInfo;//分页
@property(nonatomic,retain)NSArray *mGoodsListArray;//商品列表
@end

@interface SPProductListGoodData : SPBaseData 

@property(nonatomic,retain)NSString *mGoodsSN;//商品编号
@property(nonatomic,retain)NSString *mGoodsName;//商品名称
@property(nonatomic,retain)NSString *mGoodsSlogan;//广告语
@property(nonatomic,retain)NSString *mCommentCount;//评论数
@property(nonatomic,retain)NSString *mCategoryID;//类型ID
@property(nonatomic,retain)NSString *mBrandID;//品牌编号
@property(nonatomic,retain)NSString *mGoodsScore;//商品评分
@property(nonatomic,retain)NSString *mGoodsSort;//商品排序
@property(nonatomic,retain)NSString *mIntegral;//商品积分
@property(nonatomic,retain)NSString *mImgFile;//商品图片
@property(nonatomic,retain)NSString *mShopPrice;//速普价
@property(nonatomic,retain)NSString *mMarketPrice;//市场价
@property(nonatomic,retain)NSString *mIsNoStock;//是否缺货
@property(nonatomic,retain)NSString *mAddTime;//创建时间

@end