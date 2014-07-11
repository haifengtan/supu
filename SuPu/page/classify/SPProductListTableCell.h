//
//  SPProductListTableCell.h
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPProductListData.h"
@interface SPProductListTableCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *m_imgView_product;
@property (retain, nonatomic) IBOutlet UILabel *m_label_productName;
@property (retain, nonatomic) IBOutlet UILabel *m_label_slogan;
@property (retain, nonatomic) IBOutlet UILabel *m_label_comment;
@property (retain, nonatomic) IBOutlet UILabel *m_label_shopPrice;
@property (retain, nonatomic) IBOutlet UIView *m_view_noStock;
@property (retain, nonatomic) IBOutlet UILabel *m_label_noStockPrice;

@property (retain, nonatomic)  SPProductListGoodData *product_data;

@end
