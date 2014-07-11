//
//  SPMessageViewController.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "OUOTextView.h"
#import "CalculateLabel.h"
@interface SPMessageViewController : SPBaseViewController<UITextViewDelegate>

@property(nonatomic,retain) NSString *remark;
@property(nonatomic,retain) IBOutlet UITextView *textView;
@property(nonatomic,retain) IBOutlet CalculateLabel *calLabel;

@end
