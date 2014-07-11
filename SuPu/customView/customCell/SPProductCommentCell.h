//
//  SPProductCommentCell.h
//  SuPu
//
//  Created by 杨福军 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "EDStarRating.h"

@interface SPProductCommentCell : UITableViewCell
//@property (retain, nonatomic) IBOutlet EDStarRating *memberLevelControl;
@property (retain, nonatomic) IBOutlet UIImageView *levelimage;
@property (retain, nonatomic) IBOutlet EDStarRating *ratingBar;
@property (retain, nonatomic) IBOutlet UILabel *memberLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet OUOLabel *commentLabel;
@property (retain, nonatomic) IBOutlet UIView *bottomContainingView;

+ (CGFloat)heightForComment:(NSString *)comment;

@end
