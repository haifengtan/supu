//
//  SPFilterItemData.m
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPFilterItemData.h"

@implementation SPFilterItemData
@synthesize mname;
@synthesize mid;
@synthesize mcontent;
@synthesize mselected;
@synthesize mdisplayName;
@synthesize mcatagorys;

-(void)dealloc{
    self.mname=nil;
    self.mid=nil;
    self.mcontent=nil;
    self.mdisplayName=nil;
    self.mcatagorys=nil;
    [super dealloc];
}
@end
