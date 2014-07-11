//
//  SPStyleList.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPStyleList.h"

@implementation SPStyleList
@synthesize mPaymentArray,mShipArray;

-(void)dealloc{
    self.mPaymentArray=nil;
    self.mShipArray=nil;
    [super dealloc];
}
@end


@implementation PaymentData
@synthesize mIsOnline,mOrdering,mPaymentCode,mPaymentDesc,mPaymentID,mPaymentName;
-(void)dealloc{
    self.mIsOnline=nil;
    self.mOrdering=nil;
    self.mPaymentID=nil;
    self.mPaymentName=nil;
    self.mPaymentDesc=nil;
    self.mPaymentCode=nil;
    
    [super dealloc];
}
@end

@implementation ShippingData

@synthesize mShippingID;
@synthesize mShippingCode;
@synthesize mShippingName;
@synthesize mShippingDesc;
@synthesize mOrdering;
@synthesize mBasicFee;
@synthesize mStepFee;
@synthesize mFreeLimit;
@synthesize mTransitTime;

-(void)dealloc{
    self.mShippingCode=nil;
    self.mOrdering=nil;
    self.mShippingDesc=nil;
    self.mShippingID=nil;
    self.mBasicFee=nil;
    self.mTransitTime=nil;
    self.mFreeLimit=nil;

    [super dealloc];
}
@end