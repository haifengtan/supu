//
//  SPBaseTableView.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseTableView.h"

@implementation SPBaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setup {
//    self.separatorColor = OUO_COLOR_PATTERNIMAGE(@"product_line");
    self.backgroundView = nil;
    self.backgroundColor = [UIColor whiteColor];
    //    self.backgroundColor = [QMStatusUtility getTableViewBgColor];
}

@end
