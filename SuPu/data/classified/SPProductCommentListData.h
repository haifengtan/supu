//
//  SPProductCommentListData.h
//  SuPu
//
//  Created by 杨福军 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPPageInfoData.h"
#import "Member.h"

@interface SPProductCommentListData : SPBaseData
@property (retain, nonatomic) NSArray *comments;
@property (retain, nonatomic) SPPageInfoData *pageInfo;
@end

@interface SPProductCommentData : SPBaseData
@property (copy, nonatomic) NSString *goodsScore;
@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *time;
@property (retain, nonatomic) Member *member;     ///发表评论者
@end