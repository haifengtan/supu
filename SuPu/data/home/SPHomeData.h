//
//  SPHomeData.h
//  SuPu
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPHomeData : SPBaseData

@property(nonatomic,retain)NSArray *mTopGoodsListArray;//画廊图片数组
@property(nonatomic,retain)NSArray *mOtherGoodsArray;//其他优惠信息
@end

@interface SPHomeItemData : SPBaseData 

@property(nonatomic,retain)NSString *mName;//优惠种类
@property(nonatomic,retain)NSArray *mGoodsArray;//图片数组
@end

@interface SPHomeGoodData : SPBaseData 

@property(nonatomic,retain)NSString *mGoodsSN;//编号
@property(nonatomic,retain)NSString *mImgFile;//icon图片
@property(nonatomic,retain)NSString *mPrice;//商品价格

@end