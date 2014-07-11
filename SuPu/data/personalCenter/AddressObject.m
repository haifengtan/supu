//
//  AddressObject.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "AddressObject.h"

@implementation AddressObject
@synthesize Address;
@synthesize AreaID;
@synthesize CityID;
@synthesize Consignee;
@synthesize ConsigneeID;
@synthesize Email;
@synthesize Mobile;
@synthesize ProvinceID;
@synthesize Tel;
@synthesize ZipCode;

- (void)dealloc
{
    [Address release];
    [AreaID release];
    [CityID release];
    [Consignee release];
    [ConsigneeID release];
    [Email release];
    [Mobile release];
    [ProvinceID release];
    [Tel release];
    [ZipCode release];
    [super dealloc];
}

@end
