//
//  SPArticleListData.h
//  SuPu
//
//  Created by xx on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"
#import "SPPageInfoData.h"

@interface SPArticleListData : SPBaseData

@property(nonatomic,retain)SPPageInfoData *mPageInfo;//分页数据
@property(nonatomic,retain)NSArray *mArticleListArray;//文章列表
@end
