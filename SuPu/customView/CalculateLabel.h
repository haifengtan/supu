//
//  CalculateLabel.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateLabel : UILabel
@property(nonatomic,retain) NSString *slabelContent;
- (int)textLength:(NSString *)text;
@end
