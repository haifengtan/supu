//
//  SPShopCartCell.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPShopCartCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation SPShopCartCell
@synthesize priceLabel=_priceLabel;
@synthesize thumbnails=_thumbnails;
@synthesize numberTextField=_numberTextField;
@synthesize m_label_gift = _m_label_gift;
@synthesize nameLabel=_nameLabel;
@synthesize numberLabel=_numberLabel;
@synthesize xlabel = _xlabel;
@synthesize nostocklabel = _nostocklabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.numberTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.thumbnails.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.thumbnails.layer.borderWidth = 1.0;
    [self.thumbnails.layer setShadowOffset:CGSizeMake(0, 1)];
//    [self.thumbnails.layer setShadowRadius:2];
//    [self.thumbnails.layer setShadowOpacity:1];
    [self.thumbnails.layer setShadowColor:[UIColor lightGrayColor].CGColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_m_label_gift release];
    [_thumbnails release];
    
    [_priceLabel release];

    [_numberTextField release];
    
    [_nameLabel release];
    [_numberLabel release];
    [_xlabel release];
    [_nostocklabel release];
    [super dealloc];
}
@end
