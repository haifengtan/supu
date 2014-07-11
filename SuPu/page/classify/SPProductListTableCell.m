//
//  SPProductListTableCell.m
//  SuPu
//
//  Created by xiexu on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductListTableCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SPProductListTableCell ()

@end

@implementation SPProductListTableCell
@synthesize product_data = _product_data;
@synthesize m_imgView_product;
@synthesize m_label_productName;
@synthesize m_label_slogan;
@synthesize m_label_comment;
@synthesize m_label_shopPrice;
@synthesize m_view_noStock;
@synthesize m_label_noStockPrice;


-(void)setProduct_data:(SPProductListGoodData *)product_data{
    if (_product_data !=product_data) {
        [_product_data release];
        _product_data = [product_data retain];
 
        NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
        
        if ([showpicture isEqualToString:@"ON"]) {
             [self.m_imgView_product setImageWithURL:URLImagePath(_product_data.mImgFile) placeholderImage:[UIImage imageNamed:@"66-66.png"]];
        }else{
            [self.m_imgView_product setImage:[UIImage imageNamed:@"66-66.png"]];
        }
        [self.m_label_productName setText:strOrEmpty(_product_data.mGoodsName)];
        [self.m_label_slogan setText:strOrEmpty(_product_data.mGoodsSlogan)];
        [self.m_label_comment setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",_product_data.mCommentCount])];
        
        if ([_product_data.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.m_view_noStock setHidden:NO];
            [self.m_label_shopPrice setHidden:YES];
            [self.m_label_noStockPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_product_data.mShopPrice)]];
            
        }else{
            [self.m_view_noStock setHidden:YES];
            [self.m_label_shopPrice setHidden:NO];
            [self.m_label_shopPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_product_data.mShopPrice)]];
        }
  
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.m_imgView_product.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_imgView_product.layer setBorderWidth:1];
    
}
- (void)dealloc {
   
    OUOSafeRelease(m_imgView_product);
 
    OUOSafeRelease(m_label_productName);
 
    OUOSafeRelease(m_label_slogan);
  
    OUOSafeRelease(m_label_comment);
   
    OUOSafeRelease(m_label_shopPrice);
 
    OUOSafeRelease(m_view_noStock);
 
    OUOSafeRelease(m_label_noStockPrice);
 
    [super dealloc];
}
@end
