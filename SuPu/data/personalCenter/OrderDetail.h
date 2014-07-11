//
//  OrderDetail.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetail : NSObject

@property (retain, nonatomic) NSString *Id;
@property (retain, nonatomic) NSString *OrderSN;
@property (retain, nonatomic) NSString *GoodsSN;
@property (retain, nonatomic) NSString *GoodsName;
@property (retain, nonatomic) NSString *Price;
@property (retain, nonatomic) NSString *Discount;
@property (retain, nonatomic) NSString *Count;
@property (retain, nonatomic) NSString *IsGift;
@property (retain, nonatomic) NSString *Integral;
@property (retain, nonatomic) NSString *ImgFile;

@end
