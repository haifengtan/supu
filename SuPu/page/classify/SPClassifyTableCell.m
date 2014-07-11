//
//  SPClassifyTableCell.m
//  SuPu
//
//  Created by xiexu on 12-10-31.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyTableCell.h"

@interface SPClassifyTableCell ()

@end

@implementation SPClassifyTableCell
@synthesize m_label_title;
@synthesize m_imgView;

- (void)dealloc {
    [m_imgView release];
    [m_label_title release];
    [super dealloc];
}
@end
