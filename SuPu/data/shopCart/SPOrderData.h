//
//  SPOrderData.h
//  SuPu
//
//  Created by 邢 勇 on 12-10-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPOrderData : SPBaseData
@property(nonatomic,retain)NSString *mOrderSN;
@property(nonatomic,retain)NSString *mConsignee;
@property(nonatomic,retain)NSString *mProvinceID;
@property(nonatomic,retain)NSString *mCount;
@property(nonatomic,retain)NSString *mCityID;
@property(nonatomic,retain)NSString *mZipCode;
@property(nonatomic,retain)NSString *mAddress; 
@property(nonatomic,retain)NSString *mTel;
@property(nonatomic,retain)NSString *mMobile;
@property(nonatomic,retain)NSString *mDiscount;
@property(nonatomic,retain)NSString *mOrderAmount;
@property(nonatomic,retain)NSString *mOrderStatus;
@property(nonatomic,retain)NSString *mEmail;
@property(nonatomic,retain)NSString *mPayName;
@property(nonatomic,retain)NSString *mShippingName; 
@property(nonatomic,retain)NSString *mAccount;
@property(nonatomic,retain)NSString *mMemberId;
@property(nonatomic,retain)NSString *mAddTime; 

//    "OrderSN": 2171234,
//    "Consignee": "张三",
//    "ProvinceID": "370000",
//    "CityID": "370600",
//    "AreaID": "370687",
//    "ZipCode": "1000006",
//    "Address": "杭州路67号",
//    "Tel": "053283838383",
//    "Mobile": "13333333333",
//    "Discount": 0.00,
//    "OrderAmount": 1010.00,
//    "OrderStatus": "待确认",
//    "Email": "test1@test.com",
//    "PayName": "在线支付",
//    "PayStatus": "未支付",
//    "ShippingName": "速普快递",
//    "ShippingFee": 6.00,
//    "Account": "账号",
//    "MemberId": "aaaaaaaaaaaaaaaaaaaaaa==",
//    "AddTime": "\/Date(1336567400417)\/"




@end
