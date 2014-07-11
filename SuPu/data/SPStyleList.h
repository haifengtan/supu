//
//  SPStyleList.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-5.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPStyleList : SPBaseData{
    
}
@property(nonatomic,retain)NSArray *mPaymentArray;
@property(nonatomic,retain)NSArray *mShipArray;
@end


@interface PaymentData : SPBaseData

@property(nonatomic,retain)NSString *mPaymentID;
@property(nonatomic,retain)NSString *mPaymentCode;
@property(nonatomic,retain)NSString *mPaymentName;
@property(nonatomic,retain)NSString *mPaymentDesc;
@property(nonatomic,retain)NSString *mOrdering;
@property(nonatomic,retain)NSString *mIsOnline;

@end


@interface ShippingData : SPBaseData

@property(nonatomic,retain)NSString *mShippingID;
@property(nonatomic,retain)NSString *mShippingCode;
@property(nonatomic,retain)NSString *mShippingName;
@property(nonatomic,retain)NSString *mShippingDesc;
@property(nonatomic,retain)NSString *mOrdering;
@property(nonatomic,retain)NSString *mBasicFee;
@property(nonatomic,retain)NSString *mStepFee;
@property(nonatomic,retain)NSString *mFreeLimit;
@property(nonatomic,retain)NSString *mTransitTime;


@end