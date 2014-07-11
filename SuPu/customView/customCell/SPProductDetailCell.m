//
//  SPProductDetailCell.m
//  SuPu
//
//  Created by 杨福军 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductDetailCell.h"

@implementation SPProductDetailCell
@synthesize imagescrollfatherview = imagescrollfatherview_;
//@synthesize custompagecontrol = custompagecontrol_;
@synthesize marketPriceLabel = marketPriceLabel_;
@synthesize imageScrollView = imageScrollView_;
@synthesize supuPriceLabel = supuPriceLabel_;
@synthesize collectButton = collectButton_;
@synthesize sloganLabel = sloganLabel_;
@synthesize cartButton = cartButton_;
@synthesize titleLabel = titleLabel_;
@synthesize saveLabel = saveLabel_;
@synthesize snLabel = snLabel_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(imagescrollfatherview_);
//    OUOSafeRelease(custompagecontrol_);
    OUOSafeRelease(marketPriceLabel_);
    OUOSafeRelease(imageScrollView_);
    OUOSafeRelease(supuPriceLabel_);
    OUOSafeRelease(sloganLabel_);
    OUOSafeRelease(titleLabel_);
    OUOSafeRelease(saveLabel_);
    OUOSafeRelease(snLabel_);
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
