//
//  SPShopCartCell.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPShopCartCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel *nameLabel;
@property(nonatomic,retain) IBOutlet UILabel *priceLabel;
@property(nonatomic,retain) IBOutlet UILabel *numberLabel;
@property(nonatomic,retain) IBOutlet UIImageView *thumbnails;
@property(nonatomic,retain) IBOutlet UITextField *numberTextField;
@property (retain, nonatomic) IBOutlet UILabel *m_label_gift;
@property (retain, nonatomic) IBOutlet UILabel *xlabel;
@property (retain, nonatomic) IBOutlet UILabel *nostocklabel;

@end
