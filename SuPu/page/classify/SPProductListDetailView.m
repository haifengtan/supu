//
//  SPProductListDetailView.m
//  SuPu
//
//  Created by cc on 13-3-1.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPProductListDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "SPProductListViewController.h"

@interface SPProductListDetailView ()

@property (retain, nonatomic) IBOutlet UIImageView *productimageview;//产品图片
@property (retain, nonatomic) IBOutlet UILabel *producttitlelabel;//产品名称
@property (retain, nonatomic) IBOutlet UILabel *productcommentlabel;//评论数
@property (retain, nonatomic) IBOutlet UILabel *productredpricelabel;//售价
@property (retain, nonatomic) IBOutlet UILabel *productgraypricelabel;//缺货价
@property (retain, nonatomic) IBOutlet UILabel *productstockoutlabel;//缺货提示
@property (retain, nonatomic) IBOutlet UILabel *productadvertlabel;//广告语

@end

@implementation SPProductListDetailView
@synthesize productimageview;
@synthesize producttitlelabel;
@synthesize productcommentlabel;
@synthesize productredpricelabel;
@synthesize productgraypricelabel;
@synthesize productstockoutlabel;
@synthesize productadvertlabel;
@synthesize spgooddata = _spgooddata;

- (void)dealloc
{
    [productimageview release];
    [producttitlelabel release];
    [productcommentlabel release];
    [productredpricelabel release];
    [productgraypricelabel release];
    [productstockoutlabel release];
    [productadvertlabel release];
    [_spgooddata release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSpgooddata:(SPProductListGoodData *)spgooddata
{
    if (spgooddata!=nil) {
        [spgooddata retain];
        [_spgooddata release];
        _spgooddata = spgooddata;
    
        NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            [self.productimageview setImageWithURL:URLImagePath(spgooddata.mImgFile) placeholderImage:kDefaultImage];
        }else{
            [self.productimageview setImage:kDefaultImage];
        }   
        [self.productimageview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.productimageview.layer setBorderWidth:1];
        
        self.productimageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSaleRecommendview:)];
        [self.productimageview addGestureRecognizer:singleTap];
        [singleTap release];
        
        [self.producttitlelabel setText:strOrEmpty(spgooddata.mGoodsName)];
        [self.productadvertlabel setText:strOrEmpty(spgooddata.mGoodsSlogan)];
        [self.productcommentlabel setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",spgooddata.mCommentCount])];
        if ([spgooddata.mIsNoStock isEqualToString:@"True"]) {//无库存
            [self.productstockoutlabel setHidden:NO];
            [self.productgraypricelabel setHidden:NO];
            [self.productredpricelabel setHidden:YES];
            [self.productgraypricelabel setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(spgooddata.mShopPrice)]];
            
        }else{
            [self.productstockoutlabel setHidden:YES];
            [self.productgraypricelabel setHidden:YES];
            [self.productredpricelabel setHidden:NO];
            [self.productredpricelabel setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(spgooddata.mShopPrice)]];
        }
    }
}

- (void)touchSaleRecommendview:(id)sender
{
    for (UIView* next = [[sender view] superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[SPProductListViewController class]]) {
            SPProductListViewController *controll = (SPProductListViewController *)nextResponder;
            [controll ipadDidSelectImage:_spgooddata];
        }
    }
}



@end
