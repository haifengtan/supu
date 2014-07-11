//
//  SPShoppingCartData.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPShoppingCartData : SPBaseData

@property(nonatomic,retain)NSString *mSumAmount;//总金额
@property(nonatomic,retain)NSString *mDiscountAmount;//优惠金额
@property(nonatomic,retain)NSArray *mCartListArray;//商品清单
@property(nonatomic,retain)NSArray *mGiftListArray;//赠品
@end

@interface SPShoppingCartItemData : SPBaseData

@property(nonatomic,retain)NSString *mGoodsSN;//商品编号
@property(nonatomic,retain)NSString *mGoodsName;//商品名称
@property(nonatomic,retain)NSString *mImgFile;//商品图片
@property(nonatomic,retain)NSString *mCount;//商品数量
@property(nonatomic,retain)NSString *mShopPrice;//商品价格
@property(nonatomic,retain)NSString *mDiscountAmount;//商品优惠价格
@property(nonatomic,retain)NSString *mIsNoStock; //商品是否缺货
@property(nonatomic,retain)NSString *mIsGift;//是否是赠品
@end
