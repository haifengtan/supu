//
//  SingleRowScrollCell.h
//  SuPu
//
//  Created by 杨福军 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleRowScrollCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *titleLabel;
@property (retain, nonatomic) IBOutlet OUOScrollView *scrollView;
@end
