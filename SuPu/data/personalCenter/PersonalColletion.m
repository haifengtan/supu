//
//  PersonalColletion.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-21.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalColletion.h"

@implementation PersonalColletion

@synthesize collectionimageurl;
@synthesize collectionname;
@synthesize collectionpromotion;
@synthesize collectioncommentnum;
@synthesize collectionshopprice;
@synthesize collectionmarketprice;
-(void)dealloc{
    [collectionimageurl release];
    [collectionname release];
    [collectionpromotion release];
    [collectioncommentnum release];
    [collectionshopprice release];
    [collectionmarketprice release];
    [super dealloc];
}
@end
