//
//  SingleRowScrollCell.m
//  SuPu
//
//  Created by 杨福军 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SingleRowScrollCell.h"

@implementation SingleRowScrollCell
@synthesize scrollView = scrollView_;
@synthesize titleLabel = titleLabel_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(scrollView_);
    OUOSafeRelease(titleLabel_);
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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        DLog(@"SingleRowScrollCell on initWithCoder");
    }
    return self;
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
