//
//  PersonalMessageView.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

@interface PersonalMessageView : UIView

@property (retain, nonatomic) Member *member;

- (id)initWithFrame:(CGRect)frame memberInfo:(Member *)memberinfo;

@end
