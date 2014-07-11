//
//  SPBrowerData.h
//  SuPu
//
//  Created by xx on 12-11-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"
#import "SPProductListData.h"

@interface SPBrowerData : SPBaseData

@property(nonatomic,retain)NSString *mgoodssn;//商品编号
@property(nonatomic,retain)NSString *mGoodsName;//商品名称
@property(nonatomic,retain)NSString *mMarketPrice;//市场价
@property(nonatomic,retain)NSString *mShopPrice;//速普价
@property(nonatomic,retain)NSString *mGoodsSlogan;//广告语
@property(nonatomic,retain)NSString *mCommentCount;//评论数
@property(nonatomic,retain)NSString *mIsNoStock;//是否没有库存
@property(nonatomic,retain)NSString *mImgFile;//图片

+(SPBrowerData*)existsInDBWithCode:(NSString*)code;

+(void)saveProductWithCode:(NSString*)code 
                withName:(NSString*)name 
              withSlogan:(NSString*)slogan 
        withCommentCount:(NSString*)commentCount
                 withPrice:(NSString*)price 
                withOprice:(NSString*)oprice 
           withIsNoStock:(NSString*)isNoStock
              withImageUrl:(NSString *)imageUrl;
@end
