//
//  SPBabyBibleArticleDetailCell.m
//  SuPu
//
//  Created by 杨福军 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBabyBibleArticleDetailCell.h"

@implementation SPBabyBibleArticleDetailCell
@synthesize priceLabel=_priceLabel;
@synthesize titleLabel=_titleLabel;
@synthesize introLabel=_introLabel;
@synthesize productImageView=_productImageView;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    [_productImageView release];
    [_titleLabel release];
    [_introLabel release];
    [_priceLabel release];
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

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

    // Configure the view for the selected state
}

@end
