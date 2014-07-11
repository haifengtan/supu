//
//  SPFilterItemData.h
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPFilterItemData : SPBaseData{
    NSString *mname;//条件
    NSString *mid;//条件id
    NSString *mcontent;//类型内容
    NSString *mdisplayName;//类型名称
    NSString *mcatagorys;//该属性只有在对象保存的是品牌对象的时候才会放值，该值为品牌对应的分类列表
    BOOL mselected; //是否上次被选中
}
@property(nonatomic,retain)NSString *mname;
@property(nonatomic,retain)NSString *mid;
@property(nonatomic,retain)NSString *mcontent;
@property(nonatomic,retain)NSString *mdisplayName;
@property(nonatomic,retain)NSString *mcatagorys;
@property(nonatomic,assign)BOOL mselected;

@end
