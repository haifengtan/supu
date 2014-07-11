//
//  SPArticleData.h
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@class SPArticleItemData;

@interface SPArticleData : SPBaseData

@property(nonatomic,retain)SPArticleItemData *mArticle;//文章信息
@property(nonatomic,retain)NSArray *mArticleGoodsArray;//推荐商品数组
@end

@interface SPArticleItemData : SPBaseData

@property(nonatomic,retain)NSString *mCategoryID;//文章分类ID
@property(nonatomic,retain)NSString *mID;//文章ID
@property(nonatomic,retain)NSString *mTitle;//文章标题
@property(nonatomic,retain)NSString *mContent;//文章内容（html富文本）
@property(nonatomic,retain)NSString *mModifyTime;//文章编辑时间
@end

@interface SPArticleGoodData : SPBaseData 

@property(nonatomic,retain)NSString *mGoodsSN;//商品编号
@property(nonatomic,retain)NSString *mGoodsName;//商品名称
@property (retain, nonatomic) NSString *mGooodsIntro;   ///商品简介
@property(nonatomic,retain)NSString *mImgFile;//商品图片
@property(nonatomic,retain)NSString *mPrice;//商品价格
@property(nonatomic,retain)NSString *mMarketPrice;//市场价
@end
