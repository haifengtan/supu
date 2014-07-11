//
//  CollectionListCell.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKCustomMiddleLineLable.h"
#import "GoodsObject.h"
#import "FavoritesObject.h"

@interface CollectionListCell : UITableViewCell

@property (retain, nonatomic) GoodsObject *goodsobj;
@property (retain, nonatomic) FavoritesObject *favoritesobj;

@end
