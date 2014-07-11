//
//  SPProductListIpadCell.m
//  SuPu
//
//  Created by xingyong on 13-3-11.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPProductListIpadCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SPProductListViewController.h"

@implementation SPProductListIpadCell

@synthesize productData = _productData;
@synthesize productData2 = _productData2;
@synthesize productData3 = _productData3;
@synthesize productData4 = _productData4;
@synthesize view1,view2,view3,view4;
@synthesize imageView1,imageView2,imageView3,imageView4;
@synthesize activityLabel1,activityLabel2,activityLabel3,activityLabel4;
@synthesize priceLabel1,priceLabel2,priceLabel3,priceLabel4;
@synthesize descLabel1,descLabel2,descLabel3,descLabel4;
@synthesize stockoutLabel1,stockoutLabel2,stockoutLabel3,stockoutLabel4;
@synthesize appraiseLabel1,appraiseLabel2,appraiseLabel3,appraiseLabel4;
@synthesize stockoutPriceLabel1,stockoutPriceLabel2,stockoutPriceLabel3,stockoutPriceLabel4;



-(void)setProductData:(SPProductListGoodData *)productData{
    if (_productData !=productData) {
        [_productData release];
        _productData = [productData retain];
        
        
        view1.hidden =NO;
        view2.hidden =YES;
        view3.hidden = YES;
        view4.hidden = YES;
        
        NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            [self.imageView1 setImageWithURL:URLImagePath(_productData.mImgFile) placeholderImage:[UIImage imageNamed:@"160-160.png"]];
        }else{
            [self.imageView1 setImage:[UIImage imageNamed:@"160-160.png"]];
        }
      
        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSaleRecommendview:)];
//        [self.imageView1 addGestureRecognizer:singleTap];
//        [singleTap release];
        
        [self gestureRecognizerTap:self.imageView1];
        self.imageView1.productNO = _productData.mGoodsSN;
        
        [self.descLabel1 setText:strOrEmpty(_productData.mGoodsName)];
        [self.activityLabel1 setText:strOrEmpty(_productData.mGoodsSlogan)];
        [self.appraiseLabel1 setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",_productData.mCommentCount])];
        if ([_productData.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.stockoutPriceLabel1 setHidden:NO];
            [self.stockoutLabel1 setHidden:NO];
            [self.priceLabel1 setHidden:YES];
            [self.stockoutPriceLabel1 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData.mShopPrice)]];
            
        }else{
            [self.stockoutPriceLabel1 setHidden:YES];
            [self.stockoutLabel1 setHidden:YES];
            [self.priceLabel1 setHidden:NO];
            [self.priceLabel1 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData.mShopPrice)]];
        }
//        [_productData release];
    }
}
-(void)setProductData2:(SPProductListGoodData *)productData2{
    
    if (_productData2 !=productData2) {
        [_productData2 release];
        _productData2 = [productData2 retain];
        
        view1.hidden=NO;
        view2.hidden =NO;
        view3.hidden = YES;
        view4.hidden = YES;
        
        NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            [self.imageView2 setImageWithURL:URLImagePath(_productData2.mImgFile) placeholderImage:[UIImage imageNamed:@"160-160.png"]];
        }else{
            [self.imageView2 setImage:[UIImage imageNamed:@"160-160.png"]];
        }
         
        [self gestureRecognizerTap:self.imageView2];
        self.imageView2.productNO = _productData2.mGoodsSN;
        
        [self.descLabel2 setText:strOrEmpty(_productData2.mGoodsName)];
        [self.activityLabel2 setText:strOrEmpty(_productData2.mGoodsSlogan)];
        [self.appraiseLabel2 setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",_productData2.mCommentCount])];
        if ([_productData2.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.stockoutPriceLabel2 setHidden:NO];
            [self.stockoutLabel2 setHidden:NO];
            [self.priceLabel2 setHidden:YES];
            [self.stockoutPriceLabel2 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData2.mShopPrice)]];
            
        }else{
            [self.stockoutPriceLabel2 setHidden:YES];
            [self.stockoutLabel2 setHidden:YES];
            [self.priceLabel2 setHidden:NO];
            [self.priceLabel2 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData2.mShopPrice)]];
        }

//        [_productData2 release];
    }
}
-(void)setProductData3:(SPProductListGoodData *)productData3{
    if (_productData3 !=productData3) {
        [_productData3 release];
        _productData3 = [productData3 retain];
        
        view1.hidden =NO;
        view2.hidden =NO;
        view3.hidden = NO;
        view4.hidden = YES;
        
        NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            [self.imageView3 setImageWithURL:URLImagePath(_productData3.mImgFile) placeholderImage:[UIImage imageNamed:@"160-160.png"]];
        }else{
            [self.imageView3 setImage:[UIImage imageNamed:@"160-160.png"]];
        }
        
        
        
        [self gestureRecognizerTap:self.imageView3];
        self.imageView3.productNO = _productData3.mGoodsSN;
        
        [self.descLabel3 setText:strOrEmpty(_productData3.mGoodsName)];
        [self.activityLabel3 setText:strOrEmpty(_productData3.mGoodsSlogan)];
        [self.appraiseLabel3 setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",_productData3.mCommentCount])];
        if ([_productData3.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.stockoutPriceLabel3 setHidden:NO];
            [self.stockoutLabel3 setHidden:NO];
            [self.priceLabel3 setHidden:YES];
            [self.stockoutPriceLabel3 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData3.mShopPrice)]];
            
        }else{
            [self.stockoutPriceLabel3 setHidden:YES];
            [self.stockoutLabel3 setHidden:YES];
            [self.priceLabel3 setHidden:NO];
            [self.priceLabel3 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData3.mShopPrice)]];
        }
        
 
    }
}

-(void)setProductData4:(SPProductListGoodData *)productData4{
    if (_productData4 !=productData4) {
        [_productData4 release];
        _productData4 = [productData4 retain];
        
        view1.hidden =NO;
        view2.hidden =NO;
        view3.hidden = NO;
        view4.hidden = NO;
         
        NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            [self.imageView4 setImageWithURL:URLImagePath(_productData4.mImgFile)
             placeholderImage:[UIImage imageNamed:@"160-160.png"]];
        }else{
            [self.imageView4 setImage:[UIImage imageNamed:@"160-160.png"]];
        }
        
         
        [self gestureRecognizerTap:self.imageView4];
        self.imageView4.productNO = _productData4.mGoodsSN;
        
        [self.descLabel4 setText:strOrEmpty(_productData4.mGoodsName)];
        [self.activityLabel4 setText:strOrEmpty(_productData4.mGoodsSlogan)];
        [self.appraiseLabel4 setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",_productData4.mCommentCount])];
        if ([_productData4.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.stockoutPriceLabel4 setHidden:NO];
            [self.stockoutLabel4 setHidden:NO];
            [self.priceLabel4 setHidden:YES];
            [self.stockoutPriceLabel4 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData4.mShopPrice)]];
            
        }else{
            [self.stockoutPriceLabel4 setHidden:YES];
            [self.stockoutLabel4 setHidden:YES];
            [self.priceLabel4 setHidden:NO];
            [self.priceLabel4 setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(_productData4.mShopPrice)]];
        }
        
//        [_productData4 release];
    }
}
//- (void)touchSaleRecommendview:(id)sender
//{
//    for (UIView* next = [[sender view] superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[SPProductListViewController class]]) {
//            SPProductListViewController *productViewCtrl = (SPProductListViewController *)nextResponder;
//            [productViewCtrl ipadDidSelectImage:_productData];
//        }
//    }
//}



-(void)gestureRecognizerTap:(ProductImageView *)imgView{
    
    UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewGestureRecognizerTap:)] autorelease];
    [Tap setNumberOfTapsRequired:1];
    [Tap setNumberOfTouchesRequired:1];
    imgView.userInteractionEnabled=YES;
    [imgView addGestureRecognizer:Tap];
}

-(void)imageViewGestureRecognizerTap:(UITapGestureRecognizer *)sender{
    ProductImageView *productImageView =(ProductImageView *)sender.view;
    
    for (UIView* next = [[sender view] superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[SPProductListViewController class]]) {
            SPProductListViewController *productViewCtrl = (SPProductListViewController *)nextResponder;
 
            [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:productImageView.productNO from:productViewCtrl];
        }
    }
  
}
 
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self imageViewLayer:imageView1];
    [self imageViewLayer:imageView2];
    [self imageViewLayer:imageView3];
    [self imageViewLayer:imageView4];
    
}

-(void)imageViewLayer:(UIImageView *)imageView{
    [imageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView.layer setBorderWidth:1];
    imageView.userInteractionEnabled = YES;
}
-(void)dealloc{

    OUOSafeRelease(view1);
        OUOSafeRelease(view2);
        OUOSafeRelease(view3);
        OUOSafeRelease(view4);
    OUOSafeRelease(imageView1);
        OUOSafeRelease(imageView2);
        OUOSafeRelease(imageView3);
        OUOSafeRelease(imageView4);
    OUOSafeRelease(priceLabel1);
        OUOSafeRelease(priceLabel2);
        OUOSafeRelease(priceLabel3);
        OUOSafeRelease(priceLabel4);
    OUOSafeRelease(stockoutLabel1);
        OUOSafeRelease(stockoutLabel2);
        OUOSafeRelease(stockoutLabel3);
        OUOSafeRelease(stockoutLabel4);
    OUOSafeRelease(stockoutPriceLabel1);
        OUOSafeRelease(stockoutPriceLabel2);
        OUOSafeRelease(stockoutPriceLabel3);
        OUOSafeRelease(stockoutPriceLabel4);
    OUOSafeRelease(descLabel1);
        OUOSafeRelease(descLabel2);
        OUOSafeRelease(descLabel3);
        OUOSafeRelease(descLabel4);
    OUOSafeRelease(activityLabel1);
        OUOSafeRelease(activityLabel2);
        OUOSafeRelease(activityLabel3);
        OUOSafeRelease(activityLabel4);
    OUOSafeRelease(appraiseLabel1);
        OUOSafeRelease(appraiseLabel2);
        OUOSafeRelease(appraiseLabel3);
        OUOSafeRelease(appraiseLabel4);
    
    OUOSafeRelease(_productData);
        OUOSafeRelease(_productData2);
        OUOSafeRelease(_productData3);
        OUOSafeRelease(_productData4);
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    
}
@end

@implementation ProductImageView

@synthesize productNO;

-(void)dealloc{
    self.productNO = nil;
    [super dealloc];
}

@end
