//
//  SPBrandData.h
//  SuPu
//
//  品牌列表数据
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPBrandData : SPBaseData

@property(nonatomic,retain)NSString *mBrandID;//品牌编号
@property(nonatomic,retain)NSString *mBrandName;//品牌名称
@property(nonatomic,retain)NSString *mSortOrder;//品牌排序
@end
