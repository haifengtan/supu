//
//  CollectionListCell.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "CollectionListCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionListCell ()

@property (retain, nonatomic) UIImageView *collectionimageview;
@property (retain, nonatomic) UILabel *collectionnamelable;
@property (retain, nonatomic) UILabel *collectionpromotionlabel;
@property (retain, nonatomic) UILabel *collectioncommentnumlabel;
@property (retain, nonatomic) UILabel *collectioshopricelabel;
@property (retain, nonatomic) YKCustomMiddleLineLable *collectionmarketpricelabel;
@property (retain, nonatomic) UILabel *shoppricetitlelabel;
@property (retain, nonatomic) UILabel *marketpricetitlelabel;
@property BOOL isPad;

@end

@implementation CollectionListCell
@synthesize goodsobj = _goodsobj;
@synthesize favoritesobj = _favoritesobj;
@synthesize collectionimageview;
@synthesize collectionnamelable;
@synthesize collectionpromotionlabel;
@synthesize collectioshopricelabel;
@synthesize collectionmarketpricelabel;
@synthesize collectioncommentnumlabel;
@synthesize marketpricetitlelabel;
@synthesize shoppricetitlelabel;
@synthesize isPad;

- (void)dealloc
{
    [_goodsobj release];
    [_favoritesobj release];
    [marketpricetitlelabel release];
    [shoppricetitlelabel release];
    [collectionimageview release];
    [collectionnamelable release];
    [collectionpromotionlabel release];
    [collectioncommentnumlabel release];
    [collectioshopricelabel release];
    [collectionmarketpricelabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self.isPad = iPad;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *collectiodetailpic = nil;
        if (self.isPad) {
            collectionimageview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 124, 128)];
            collectionnamelable = [[UILabel alloc] initWithFrame:CGRectMake(155, 6, 580, 34)];
            collectionnamelable.font = [UIFont boldSystemFontOfSize:24];
            collectionpromotionlabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 50, 500, 32)];
            collectionpromotionlabel.font = [UIFont boldSystemFontOfSize:24];
            collectioncommentnumlabel = [[UILabel alloc] initWithFrame:CGRectMake(155, 102, 200, 32)];
            collectioncommentnumlabel.font = [UIFont boldSystemFontOfSize:22];
            marketpricetitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 78, 80, 28)];
            marketpricetitlelabel.font = [UIFont boldSystemFontOfSize:26];
            collectionmarketpricelabel = [[YKCustomMiddleLineLable alloc] initWithFrame:CGRectMake(600, 78, 146, 28)];
            collectionmarketpricelabel.font = [UIFont boldSystemFontOfSize:26];
            shoppricetitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 108, 80, 28)];
            shoppricetitlelabel.font = [UIFont boldSystemFontOfSize:26];
            collectioshopricelabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 108, 146, 28)];
            collectioshopricelabel.font = [UIFont boldSystemFontOfSize:26];
            collectiodetailpic = [[UIImageView alloc] initWithFrame:CGRectMake(730, 50, 14, 22)];
        }else{
            collectionimageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 62, 64)];
            collectionnamelable = [[UILabel alloc] initWithFrame:CGRectMake(76, 3, 200, 17)];
            collectionnamelable.font = [UIFont boldSystemFontOfSize:12];
            collectionpromotionlabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 21, 200, 16)];
            collectionpromotionlabel.font = [UIFont boldSystemFontOfSize:12];
            collectioncommentnumlabel = [[UILabel alloc] initWithFrame:CGRectMake(76, 53, 100, 14)];
            collectioncommentnumlabel.font = [UIFont boldSystemFontOfSize:11];
            marketpricetitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 36, 40, 14)];
            marketpricetitlelabel.font = [UIFont boldSystemFontOfSize:13];
            collectionmarketpricelabel = [[YKCustomMiddleLineLable alloc] initWithFrame:CGRectMake(220, 36, 73, 14)];
            collectionmarketpricelabel.font = [UIFont boldSystemFontOfSize:13];
            shoppricetitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 50, 40, 14)];
            shoppricetitlelabel.font = [UIFont boldSystemFontOfSize:13];
            collectioshopricelabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 73, 14)];
            collectioshopricelabel.font = [UIFont boldSystemFontOfSize:13];
            collectiodetailpic = [[UIImageView alloc] initWithFrame:CGRectMake(290, 27, 7, 11)];
        }
        
        [self addSubview:collectionimageview];
        
        collectionnamelable.backgroundColor = [UIColor clearColor];
        [self addSubview:collectionnamelable];
        
        collectionpromotionlabel.backgroundColor = [UIColor clearColor];
        collectionpromotionlabel.textColor = [UIColor redColor];
        [self addSubview:collectionpromotionlabel];
        
        collectioncommentnumlabel.backgroundColor = [UIColor clearColor];
        collectioncommentnumlabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.00];
        [self addSubview:collectioncommentnumlabel];
        
        marketpricetitlelabel.text = @"原价：";
        marketpricetitlelabel.backgroundColor = [UIColor clearColor];
        marketpricetitlelabel.textColor = [UIColor colorWithRed:0.42 green:0.41 blue:0.42 alpha:1.00];
        [self addSubview:marketpricetitlelabel];
        
        collectionmarketpricelabel.backgroundColor = [UIColor clearColor];
        collectionmarketpricelabel.textColor = [UIColor colorWithRed:0.42 green:0.41 blue:0.42 alpha:1.00];
        [self addSubview:collectionmarketpricelabel];
        
        shoppricetitlelabel.text = @"现价：";
        shoppricetitlelabel.backgroundColor = [UIColor clearColor];
        shoppricetitlelabel.textColor = [UIColor redColor];
        [self addSubview:shoppricetitlelabel];
        
        collectioshopricelabel.backgroundColor = [UIColor clearColor];
        collectioshopricelabel.textColor = [UIColor redColor];
        [self addSubview:collectioshopricelabel];
        
        collectiodetailpic.image = [UIImage imageNamed:@"小箭头.png"];
        [self addSubview:collectiodetailpic];
        [collectiodetailpic release];
        
        UIImageView *cellbackgroundview = [[UIImageView alloc] initWithFrame:self.bounds];
        cellbackgroundview.image = [UIImage imageNamed:@"背景.png"];
        self.backgroundView = cellbackgroundview;
        [cellbackgroundview release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoodsobj:(GoodsObject *)goodsobj
{
    [goodsobj retain];
    [_goodsobj release];
    _goodsobj = [goodsobj retain];

    NSString *showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
    if ([showpicture isEqualToString:@"ON"]) {
        if (iPad) {
            [self.collectionimageview setImageWithURL:URLImagePath(_goodsobj.ImgFile) placeholderImage:[UIImage imageNamed:@"126-126.png"]];
        }else{
            [self.collectionimageview setImageWithURL:URLImagePath(_goodsobj.ImgFile) placeholderImage:[UIImage imageNamed:@"66-66.png"]];
        }
//        [self.collectionimageview setImageWithURL:URLImagePath(_goodsobj.ImgFile) placeholderImage:kDefaultImage];
    }else{
        if (iPad) {
             [self.collectionimageview setImage:[UIImage imageNamed:@"126-126.png"]];
        }else{
             [self.collectionimageview setImage:[UIImage imageNamed:@"66-66.png"]];
        }

//        [self.collectionimageview setImage:kDefaultImage];
    }
    self.collectionnamelable.text = _goodsobj.GoodsName;
    self.collectionpromotionlabel.text = _goodsobj.GoodsSlogan;
    self.collectioncommentnumlabel.text = [NSString stringWithFormat:@"%@人评价",_goodsobj.CommentCount];
    if (_goodsobj.MarketPrice.floatValue != _goodsobj.ShopPrice.floatValue) {
        self.collectionmarketpricelabel.hidden = NO;
        self.collectioshopricelabel.hidden = NO;
        self.marketpricetitlelabel.hidden = NO;
        self.shoppricetitlelabel.hidden = NO;
        self.collectionmarketpricelabel.text = [NSString stringWithFormat:@"￥%@",_goodsobj.MarketPrice];
        self.collectionmarketpricelabel.enabled_middleLine = YES;
        [self.collectionmarketpricelabel setNeedsDisplay];
        self.collectioshopricelabel.text = [NSString stringWithFormat:@"￥%@",_goodsobj.ShopPrice];
    }else{
        self.collectionmarketpricelabel.enabled_middleLine = NO;
        self.collectionmarketpricelabel.hidden = YES;
        self.collectioshopricelabel.hidden = NO;
        self.marketpricetitlelabel.hidden = YES;
        self.shoppricetitlelabel.hidden = YES;
        self.collectioshopricelabel.text = [NSString stringWithFormat:@"￥%@",_goodsobj.ShopPrice];
    }
}

- (void)setFavoritesobj:(FavoritesObject *)favoritesobj
{
    [favoritesobj retain];
    [_favoritesobj release];
    _favoritesobj = [favoritesobj retain];
    
}

@end
