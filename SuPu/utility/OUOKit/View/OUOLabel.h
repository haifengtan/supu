//
//  OUOLabel.h
//  QiMeiLady
//
//  Created by user on 12-9-12.
//  Copyright (c) 2012年 com.chances. All rights reserved.
//

typedef enum {
    OUOLabelAutoAdjustModeNone,
    OUOLabelAutoAdjustModeWidthToFit,
    OUOLabelAutoAdjustModeHeightToFit
} OUOLabelAutoAdjustMode;

@interface OUOLabel : UILabel

@property (assign, nonatomic) OUOLabelAutoAdjustMode sizeAdjustMode;

@end
