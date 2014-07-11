//
//  SPAddressCell.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAddressCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) IBOutlet UITextField *contentField;
@property(nonatomic,retain) IBOutlet UIButton *cityButton;
@property(nonatomic,retain) IBOutlet UILabel *needsublabel;

@end


