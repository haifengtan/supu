//
//  SPPageInfoData.h
//  SuPu
//
//  Created by xx on 12-10-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPPageInfoData : SPBaseData

@property(nonatomic,retain)NSString *mPageIndex;//当前页码
@property(nonatomic,retain)NSString *mPageSize;//每页大小
@property(nonatomic,retain)NSString *mRecordCount;//总数量

@property(nonatomic,retain)NSMutableArray *mPageArray;//总数量
@end
