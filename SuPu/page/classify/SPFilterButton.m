//
//  SPFilterButton.m
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPFilterButton.h"

@implementation SPFilterButton
@synthesize m_filterItemData;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.layer.borderColor=[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1].CGColor;
        self.backgroundColor=[UIColor colorWithRed:224.0/255 green:224.0/255 blue:224.0/255 alpha:1];
        self.layer.borderWidth=1;
    }
    
    return self;
}
-(void)dealloc{
    [m_filterItemData release];m_filterItemData=nil;
    [super dealloc];
}

@end
