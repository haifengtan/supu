//
//  SPCategoryListData.h
//  SuPu
//
//  分类列表数据
//
//  Created by xx on 12-10-22.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPCategoryListData : SPBaseData

@property(nonatomic,retain)NSString *mCategoryID;//分类编号
@property(nonatomic,retain)NSString *mCategoryName;//分类名称
@property(nonatomic,retain)NSString *mParentID;//父类ID
@property(nonatomic,retain)NSString *mSortOrder;//分类排序
@property(nonatomic,retain)NSString *mImg;//分类img
@property(nonatomic,retain)NSString *mIsLaef;//是否是最终子类True False

@end
