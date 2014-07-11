//
//  SPAddressListData.m
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressListData.h"

@implementation SPAddressListData
@synthesize mAddress,mAddressInfo,mCityId,mAreaId,mConsignee,mConsigneeID,mEmail,mMobile,mProvinceID,mZipCode,mTel,mIsDefault;
-(void)dealloc{
    self.mIsDefault=nil;
    self.mEmail=nil;
    self.mAddress=nil;
    self.mTel=nil;
    self.mAreaId=nil;
    self.mConsignee=nil;
    self.mConsigneeID=nil;
    self.mZipCode=nil;
    self.mProvinceID=nil;
    self.mCityId=nil;
    self.mMobile=nil;
    self.mAddressInfo=nil;
    [super dealloc];
}
@end
