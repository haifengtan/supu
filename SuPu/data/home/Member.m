//
//  Member.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-12.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "Member.h"

@implementation Member
@synthesize mmemberId;
@synthesize maccount;
@synthesize mlevel;
@synthesize mprice;
@synthesize mscores;
@synthesize mimageUrl;

DECLARE_PROPERTIES(
				   DECLARE_PROPERTY(@"mmemberId",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"maccount",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mlevel",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mprice",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mscores",@"@\"NSString\""),
                   DECLARE_PROPERTY(@"mimageUrl",@"@\"NSString\"")
 
				   )
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:MemberId forKey:@"MemberId"];
//    [aCoder encodeObject:Account forKey:@"Account"];
//    [aCoder encodeObject:Level forKey:@"Level"];
//    [aCoder encodeObject:Price forKey:@"Price"];
//    [aCoder encodeObject:Scores forKey:@"Scores"];
//        [aCoder encodeObject:ImageUrl forKey:@"ImageUrl"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self == [self init]) {
//        self.MemberId = [aDecoder decodeObjectForKey:@"MemberId"];
//        self.Account = [aDecoder decodeObjectForKey:@"Account"];
//        self.Level = [aDecoder decodeObjectForKey:@"Level"];
//        self.Price = [aDecoder decodeObjectForKey:@"Price"];
//        self.Scores = [aDecoder decodeObjectForKey:@"Scores"];
//        self.ImageUrl = [aDecoder decodeObjectForKey:@"ImageUrl"];
//    }
//    return self;
//}

- (void)dealloc
{
    self.mimageUrl = nil;
    self.mmemberId = nil;
    self.maccount = nil;
    self.mprice = nil;
    self.mlevel = nil;
    self.mscores = nil;
 
    [super dealloc];
}

@end
