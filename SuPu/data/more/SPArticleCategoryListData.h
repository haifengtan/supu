//
//  SPArticleCategoryListData.h
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPArticleCategoryListData : SPBaseData

@property(nonatomic,retain)NSString *mID;//分类编号
@property(nonatomic,retain)NSString *mCategoryName;//分类名称
@property(nonatomic,retain)NSString *mSort;//分类排序（降序）
@property(nonatomic,retain)NSString *mPicUrl;//分类图片地址，没有图片则为@""
@end
