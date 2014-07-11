//
//  SPProductDetailCell.h
//  SuPu
//
//  Created by 杨福军 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"

@interface SPProductDetailCell : UITableViewCell

@property (retain, nonatomic) IBOutlet OUOScrollView *imageScrollView;
@property (retain, nonatomic) IBOutlet UIView *imagescrollfatherview;
//@property (retain, nonatomic) IBOutlet CustomPageControl *custompagecontrol;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *sloganLabel;
@property (retain, nonatomic) IBOutlet UILabel *snLabel;
@property (retain, nonatomic) IBOutlet UILabel *marketPriceLabel;
@property (retain, nonatomic) IBOutlet UILabel *supuPriceLabel;
@property (retain, nonatomic) IBOutlet UILabel *saveLabel;

@property (retain, nonatomic) IBOutlet UIButton *cartButton;
@property (retain, nonatomic) IBOutlet UIButton *collectButton;


@end
