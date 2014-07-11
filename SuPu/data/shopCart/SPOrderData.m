//
//  SPOrderData.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPOrderData.h"

@implementation SPOrderData
@synthesize   mOrderSN;
@synthesize   mConsignee;
@synthesize   mProvinceID;
@synthesize   mCount;
@synthesize   mCityID;
@synthesize   mZipCode;
@synthesize   mAddress;
@synthesize   mTel;
@synthesize   mMobile;
@synthesize   mDiscount;
@synthesize   mOrderAmount;
@synthesize   mOrderStatus;
@synthesize   mEmail;
@synthesize   mPayName;
@synthesize   mShippingName;
@synthesize   mAccount;
@synthesize   mMemberId;
@synthesize   mAddTime;

-(void)dealloc{
    self.mOrderSN=nil;
    self.mConsignee=nil;
    self.mProvinceID=nil;
    self.mCount=nil;
    self.mCityID=nil;
    self.mZipCode=nil;
    self.mAddress=nil;
    self.mTel=nil;
    self.mMobile=nil;
    self.mDiscount=nil;
    self.mOrderAmount=nil;
    self.mOrderStatus=nil;
    self.mEmail=nil;
    self.mPayName=nil;
    self.mShippingName=nil;
    self.mAccount=nil;
    self.mMemberId=nil;
    self.mAddTime=nil;
    [super dealloc];
}
@end
