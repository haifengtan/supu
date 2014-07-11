//
//  InterFaceTestBasic.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "InterFaceTestBasic.h"
#import "HomeInterFace.h"

@implementation InterFaceTestBasic
@synthesize homedelegate;

- (id)init
{
    HomeInterFace *hif = [[HomeInterFace alloc] init];
    self.homedelegate = hif;
    [hif release];
    return self;
}

- (void)testInterFace
{
    [homedelegate testInterFaceDelegate];
}

@end
