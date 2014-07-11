//
//  SPHomeTopData.h
//  SuPu
//
//  Created by xx on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPHomeTopData : SPBaseData

@property(nonatomic,retain)NSString *mPicUrl;//图片下载路径
@property(nonatomic,retain)NSString *mPicSort;//图片排序序号（升序）
@property(nonatomic,retain)NSString *mLinkType;//图片链接类型,
                                                //Product：商品页
                                                //List：商品列表页
                                                //Search：搜索页
                                                //Activity：活动页
@property(nonatomic,retain)NSString *mLinkData;//链接内容，按照链接类型的不同内容格式不同
                                                //Product：商品编号
                                                //List：{分类ID}-{品牌ID}，如“153-28”
                                                //Search：搜索关键词
                                                //Activity：活动ID
@end
