//
//  SPAddressListCell.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressListCell.h"

@implementation SPAddressListCell
@synthesize nameLabel,addreLabel,zipCodeLabel,telLabel,defaultmessagelabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    self.addreLabel.sizeAdjustMode = OUOLabelAutoAdjustModeHeightToFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [addreLabel release];
    [super dealloc];
}

+ (CGFloat)heightForContent:(NSString *)content {
    CGFloat height = 65.;
    CGFloat fontsize = 14.0;
    CGFloat width = 214.0;
    if (iPad) {
        height = 173.0-30.0;
        fontsize = 24.0;
        width = 399.0;
    }
    height += [content sizeWithFont:[UIFont boldSystemFontOfSize:fontsize]
                  constrainedToSize:(CGSize){width, HUGE_VAL} lineBreakMode:NSLineBreakByTruncatingTail].height;
    DLog(@"height:%f", height);
    return height;
}

@end
