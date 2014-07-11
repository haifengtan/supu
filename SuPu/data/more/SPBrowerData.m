//
//  SPBrowerData.m
//  SuPu
//
//  Created by xx on 12-11-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBrowerData.h"

@implementation SPBrowerData
@synthesize mgoodssn;
@synthesize mGoodsName;
@synthesize mShopPrice;
@synthesize mGoodsSlogan;
@synthesize mMarketPrice;
@synthesize mCommentCount;
@synthesize mIsNoStock;
@synthesize mImgFile;

DECLARE_PROPERTIES(
				   DECLARE_PROPERTY(@"mgoodssn",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mGoodsName",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mGoodsSlogan",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mCommentCount",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mImgFile",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mShopPrice",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mMarketPrice",@"@\"NSString\""),
				   DECLARE_PROPERTY(@"mIsNoStock", @"@\"NSString\"")
				   )
- (void)dealloc {
    self.mCommentCount=nil;
    self.mGoodsName=nil;
    self.mGoodsSlogan=nil;
    self.mgoodssn=nil;
    self.mMarketPrice=nil;
    self.mIsNoStock=nil;
    self.mImgFile=nil;
    [super dealloc];
}


+(SPBrowerData*)existsInDBWithCode:(NSString*)code{
    SPBrowerData* _goodsData = (SPBrowerData*)[SPBrowerData findFirstByCriteria:
                                                 [NSString stringWithFormat:@"WHERE mgoodssn='%@'", code]];
	return _goodsData;
}

+(void)saveProductWithCode:(NSString*)code 
                  withName:(NSString*)name 
                withSlogan:(NSString*)slogan 
          withCommentCount:(NSString*)commentCount
                 withPrice:(NSString*)price 
                withOprice:(NSString*)oprice 
             withIsNoStock:(NSString*)isNoStock
              withImageUrl:(NSString *)imageUrl{
    SPBrowerData* _goodsData = [self existsInDBWithCode:code];
	if (_goodsData) {  // 数据库中已存在
        
        _goodsData.mShopPrice=price;
        _goodsData.mMarketPrice=oprice;
        _goodsData.mGoodsSlogan=slogan;
        _goodsData.mIsNoStock=isNoStock;
        
		[_goodsData save];
        
	}else {
		SPBrowerData* _g = [[SPBrowerData alloc] init];
		_g.mgoodssn = code;
        _g.mGoodsName = name;
        _g.mMarketPrice = oprice;
        _g.mImgFile = imageUrl;
        _g.mShopPrice = price;
        _g.mGoodsSlogan=slogan;
        _g.mIsNoStock=isNoStock;
		[_g save];
		[_g release];
	}
    [SPBrowerData clearCache];
}
@end
