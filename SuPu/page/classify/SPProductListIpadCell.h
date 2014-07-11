//
//  SPProductListIpadCell.h
//  SuPu
//
//  Created by xingyong on 13-3-11.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPProductListData.h"
@class ProductImageView;

@interface SPProductListIpadCell : UITableViewCell

@property(nonatomic,retain)SPProductListGoodData *productData;
@property(nonatomic,retain)SPProductListGoodData *productData2;
@property(nonatomic,retain)SPProductListGoodData *productData3;
@property(nonatomic,retain)SPProductListGoodData *productData4;

 

@property(nonatomic,retain) IBOutlet ProductImageView *imageView1;
@property(nonatomic,retain) IBOutlet ProductImageView *imageView2;
@property(nonatomic,retain) IBOutlet ProductImageView *imageView3;
@property(nonatomic,retain) IBOutlet ProductImageView *imageView4;

@property(nonatomic,retain) IBOutlet UIView *view1;
@property(nonatomic,retain) IBOutlet UIView *view2;
@property(nonatomic,retain) IBOutlet UIView *view3;
@property(nonatomic,retain) IBOutlet UIView *view4;


@property(nonatomic,retain) IBOutlet UILabel *descLabel1;
@property(nonatomic,retain) IBOutlet UILabel *descLabel2;
@property(nonatomic,retain) IBOutlet UILabel *descLabel3;
@property(nonatomic,retain) IBOutlet UILabel *descLabel4;


@property(nonatomic,retain) IBOutlet UILabel *activityLabel1;
@property(nonatomic,retain) IBOutlet UILabel *activityLabel2;
@property(nonatomic,retain) IBOutlet UILabel *activityLabel3;
@property(nonatomic,retain) IBOutlet UILabel *activityLabel4;


@property(nonatomic,retain) IBOutlet UILabel *priceLabel1;
@property(nonatomic,retain) IBOutlet UILabel *priceLabel2;
@property(nonatomic,retain) IBOutlet UILabel *priceLabel3;
@property(nonatomic,retain) IBOutlet UILabel *priceLabel4;


@property(nonatomic,retain) IBOutlet UILabel *stockoutLabel1;
@property(nonatomic,retain) IBOutlet UILabel *stockoutLabel2;
@property(nonatomic,retain) IBOutlet UILabel *stockoutLabel3;
@property(nonatomic,retain) IBOutlet UILabel *stockoutLabel4;

@property(nonatomic,retain) IBOutlet UILabel *appraiseLabel1;
@property(nonatomic,retain) IBOutlet UILabel *appraiseLabel2;
@property(nonatomic,retain) IBOutlet UILabel *appraiseLabel3;
@property(nonatomic,retain) IBOutlet UILabel *appraiseLabel4;

@property(nonatomic,retain) IBOutlet UILabel *stockoutPriceLabel1;
@property(nonatomic,retain) IBOutlet UILabel *stockoutPriceLabel2;
@property(nonatomic,retain) IBOutlet UILabel *stockoutPriceLabel3;
@property(nonatomic,retain) IBOutlet UILabel *stockoutPriceLabel4;

@end
@interface ProductImageView : UIImageView{
    NSString *productNO;
}
@property(nonatomic,retain) NSString *productNO;

@end