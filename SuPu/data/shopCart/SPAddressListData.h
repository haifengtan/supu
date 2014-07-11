//
//  SPAddressListData.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-1.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPAddressListData : SPBaseData
//Address = "\U901f\U666e\U5546\U57ce";
//AreaID = 370205;
//CityID = 370200;
//Consignee = "\U3010\U5b59\U51b2\U3011";
//ConsigneeID = 5780;
//Email = "";
//Mobile = 15898852174;
//ProvinceID = 370000;
//Tel = 4006180055;
//ZipCode = 266000;


@property(nonatomic,retain)NSString *mAddress;
@property(nonatomic,retain)NSString *mAddressInfo;
@property(nonatomic,retain)NSString *mAreaId;
@property(nonatomic,retain)NSString *mCityId;
@property(nonatomic,retain)NSString *mConsignee;
@property(nonatomic,retain)NSString *mEmail;
@property(nonatomic,retain)NSString *mConsigneeID;
@property(nonatomic,retain)NSString *mZipCode;
@property(nonatomic,retain)NSString *mProvinceID;
@property(nonatomic,retain)NSString *mMobile;
@property(nonatomic,retain)NSString *mTel;
@property(nonatomic,retain)NSString *mIsDefault;

@end
