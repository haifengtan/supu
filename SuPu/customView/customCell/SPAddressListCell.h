//
//  SPAddressListCell.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OUOLabel.h"
@interface SPAddressListCell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *nameLabel;
@property(nonatomic,retain)IBOutlet UILabel *telLabel;

@property(nonatomic,retain)IBOutlet UILabel *zipCodeLabel;
@property(nonatomic,retain)IBOutlet UILabel *defaultmessagelabel;
@property (retain, nonatomic) IBOutlet OUOLabel *addreLabel;

+ (CGFloat)heightForContent:(NSString *)content;

@end
