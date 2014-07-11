//
//  GetMemberTopGoods.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-15.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "GetMemberTopGoods.h"

@implementation GetMemberTopGoods
@synthesize GoodsSN;
@synthesize ImgFile;
@synthesize Price;
-(void)dealloc{
    [GoodsSN release];
    [ImgFile release];
    [Price release];
    [super dealloc];
}
@end
