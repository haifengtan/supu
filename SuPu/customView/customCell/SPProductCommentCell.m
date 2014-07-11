//
//  SPProductCommentCell.m
//  SuPu
//
//  Created by 杨福军 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductCommentCell.h"

@interface SPProductCommentCell ()
- (void)setup;
@end

@implementation SPProductCommentCell
@synthesize bottomContainingView = bottomContainingView_;
 
@synthesize levelimage = levelimage_;
@synthesize commentLabel = commentLabel_;
@synthesize memberLabel = memberLabel_;
@synthesize dateLabel = dateLabel_;
@synthesize ratingBar = ratingBar_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(bottomContainingView_);
 
    OUOSafeRelease(levelimage_);
    OUOSafeRelease(commentLabel_);
    OUOSafeRelease(memberLabel_);
    OUOSafeRelease(dateLabel_);
    OUOSafeRelease(ratingBar_);
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

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setup {
    commentLabel_.sizeAdjustMode = OUOLabelAutoAdjustModeHeightToFit;
    [bottomContainingView_ lockDistance:3. toView:commentLabel_ measureGuideline:OUOViewDistanceMeasureGuidelineTopToButtom];
    
//    memberLevelControl_.starHighlightedImage = [UIImage imageNamed:@"heartnew.png"];
//    memberLevelControl_.maxRating = 15.0;
//    memberLevelControl_.horizontalMargin = 15.0;
//    memberLevelControl_.userInteractionEnabled = NO;
//    memberLevelControl_.displayMode=EDStarRatingDisplayFull;
//    [memberLevelControl_  setNeedsDisplay];
    
    ratingBar_.starHighlightedImage = [UIImage imageNamed:@"starnew.png"];
    ratingBar_.maxRating = 15.0;
    ratingBar_.horizontalMargin = 15.0;
    ratingBar_.userInteractionEnabled = NO;
    ratingBar_.displayMode=EDStarRatingDisplayFull;
    [ratingBar_  setNeedsDisplay];
}

+ (CGFloat)heightForComment:(NSString *)comment {
    CGFloat height = 0.;
    OUOLabel *label = nil;
    if (iPad) {
        label = [[OUOLabel alloc] initWithFrame:OUO_RECT(0., 0., 660., 42.)];
        label.font = OUO_FONT(28.);
    }else{
        label = [[OUOLabel alloc] initWithFrame:OUO_RECT(0., 0., 302., 21.)];
        label.font = OUO_FONT(14.);
    }
    label.sizeAdjustMode = OUOLabelAutoAdjustModeHeightToFit;
    label.text = comment;
    if (iPad) {
        height = label.frameHeight + 132.;
    }else{
        height = label.frameHeight + 66.;
    }
    [label release];
    return height;
}

@end
