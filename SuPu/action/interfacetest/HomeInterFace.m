//
//  HomeInterFace.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "HomeInterFace.h"

@implementation HomeInterFace
@synthesize urltest;
@synthesize valuedict;

- (void)registerUser
{
    urltest.url = @"http://www.supuy.com/api/phone/Register";
    urltest.methodname = @"Register";
    urltest.havememberid = FALSE;
    [valuedict setValue:@"test001" forKey:@"Account"];
    [valuedict setValue:@"test001" forKey:@"Password"];
    [valuedict setValue:@"test001@163.com" forKey:@"Email"];
    [valuedict setValue:@"test002" forKey:@"Recommend"];
    [valuedict setValue:@"2010/01/01" forKey:@"BabyBirthday"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)loginUser
{
    urltest.url = @"http://www.supuy.com/api/phone/Login";
    urltest.methodname = @"Login";
    [valuedict setValue:@"孙冲" forKey:@"Account"];
    [valuedict setValue:@"82214662" forKey:@"Password"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)PostConsult
{
    urltest.url = @"http://www.supuy.com/api/phone/PostConsult";
    urltest.methodname = @"PostConsult";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [valuedict setValue:@"您好，请问几天到货？" forKey:@"Content"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetBanner
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetBanner";
    urltest.methodname = @"GetBanner";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetPicList
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetPicList";
    urltest.methodname = @"GetPicList";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetIndexTopGoods
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetIndexTopGoods";
    urltest.methodname = @"GetIndexTopGoods";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetActivity
{
    urltest.url = @"http://www.supuy.com/api/phone/GetActivity";
    urltest.methodname = @"GetActivity";
    [valuedict setValue:@"254" forKey:@"ActivityId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsActivities
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsActivities";
    urltest.methodname = @"GetGoodsActivities";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetCategoryList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetCategoryList";
    urltest.methodname = @"GetCategoryList";
    [valuedict setValue:@"0" forKey:@"ParentId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetBrandList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetBrandList";
    urltest.methodname = @"GetBrandList";
    [valuedict setValue:@"15" forKey:@"CategoryId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsList";
    urltest.methodname = @"GetGoodsList";
    [valuedict setValue:@"1" forKey:@"Page"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [valuedict setValue:@"6921517280119" forKey:@"BarCode"];
    [valuedict setValue:@"奶嘴" forKey:@"SearchKey"];
    [valuedict setValue:@"22" forKey:@"CategoryId"];
    [valuedict setValue:@"158" forKey:@"BrandId"];
    [valuedict setValue:@"0" forKey:@"StartPrice"];
    [valuedict setValue:@"500" forKey:@"EndPrice"];
    [valuedict setValue:@"CommentCountDesc" forKey:@"SortField"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsDescription
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsDescription";
    urltest.methodname = @"GetGoodsDescription";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsDetails
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsDetails";
    urltest.methodname = @"GetGoodsDetails";
    [valuedict setValue:@"0104061014" forKey:@"GoodsSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsConsult
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsConsult";
    urltest.methodname = @"GetGoodsConsult";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [valuedict setValue:@"1" forKey:@"Page"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsComment
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsComment";
    urltest.methodname = @"GetGoodsComment";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [valuedict setValue:@"1" forKey:@"Page"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)AddFavorites
{
    urltest.url = @"http://www.supuy.com/api/phone/AddFavorites";
    urltest.methodname = @"AddFavorites";
    [valuedict setValue:@"0101010001" forKey:@"GoodsSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetShoppingCart
{
    urltest.url = @"http://www.supuy.com/api/phone/GetShoppingCart";
    urltest.methodname = @"GetShoppingCart";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)ModifyShoppingCart
{
    urltest.url = @"http://www.supuy.com/api/phone/ModifyShoppingCart";
    urltest.methodname = @"ModifyShoppingCart";
    [valuedict setValue:@"0101010001:1:+=,0101010003:2:=" forKey:@"goods"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetPaymentShipping
{
    urltest.url = @"http://www.supuy.com/api/phone/GetPaymentShipping";
    urltest.methodname = @"GetPaymentShipping";
    [valuedict setValue:@"370687" forKey:@"AreaId"];
    [valuedict setValue:@"6" forKey:@"PaymentId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetDistrict
{
    urltest.url = @"http://www.supuy.com/api/phone/GetDistrict";
    urltest.methodname = @"GetDistrict";
    [valuedict setValue:@"370600" forKey:@"Id"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)SubmitOrder
{
    urltest.url = @"http://www.supuy.com/api/phone/SubmitOrder";
    urltest.methodname = @"SubmitOrder";
    [valuedict setValue:@"张三" forKey:@"Consignee"];
    [valuedict setValue:@"370000" forKey:@"ProvinceId"];
    [valuedict setValue:@"370600" forKey:@"CityId"];
    [valuedict setValue:@"370687" forKey:@"AreaId"];
    [valuedict setValue:@"1000006" forKey:@"ZipCode"];
    [valuedict setValue:@"杭州路67号" forKey:@"Address"];
    [valuedict setValue:@"13333333333" forKey:@"Mobile"];
    [valuedict setValue:@"053283838383" forKey:@"Tel"];
    [valuedict setValue:@"test1@test.com" forKey:@"Email"];
    [valuedict setValue:@"6" forKey:@"ShippingId"];
    [valuedict setValue:@"10" forKey:@"PaymentId"];
    [valuedict setValue:@"50.40" forKey:@"AllCash"];
    [valuedict setValue:@"E15FDSA566" forKey:@"TicketNo"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetOrderSuccess
{
    urltest.url = @"http://www.supuy.com/api/phone/GetOrderSuccess";
    urltest.methodname = @"GetOrderSuccess";
    [valuedict setValue:@"2572489" forKey:@"ordersn"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)RegisterRecommendTicket
{
    urltest.url = @"http://www.supuy.com/api/phone/RegisterRecommendTicket";
    urltest.methodname = @"RegisterRecommendTicket";
    [valuedict setValue:@"13333333333" forKey:@"Mobile"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetMemberTopGoods
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetMemberTopGoods";
    urltest.methodname = @"GetMemberTopGoods";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetOrderProcessInformation
{
    urltest.url = @"http://www.supuy.com/api/phone/GetOrderProcessInformation";
    urltest.methodname = @"GetOrderProcessInformation";
    [valuedict setValue:@"2012345" forKey:@"OrderSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetGoodsPrice
{
    urltest.url = @"http://www.supuy.com/api/phone/GetGoodsPrice";
    urltest.methodname = @"GetGoodsPrice";
    [valuedict setValue:@"0101010001,0101010003,0101010004" forKey:@"GoodsSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetOrderList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetOrderList";
    urltest.methodname = @"GetOrderList";
    [valuedict setValue:@"1" forKey:@"Page"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [valuedict setValue:@"0" forKey:@"State"];
    [valuedict setValue:@"2012-01-01 14:12:56" forKey:@"StartTime"];
    [valuedict setValue:@"2012-01-03 14:12:56" forKey:@"EndTime"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetOrder
{
    urltest.url = @"http://www.supuy.com/api/phone/GetOrder";
    urltest.methodname = @"GetOrder";
    [valuedict setValue:@"2135973" forKey:@"OrderSN"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetFavorites
{
    urltest.url = @"http://www.supuy.com/api/phone/GetFavorites";
    urltest.methodname = @"GetFavorites";
    [valuedict setValue:@"1" forKey:@"Page"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetUserMessage
{
    urltest.url = @"http://www.supuy.com/api/phone/GetUserMessage";
    urltest.methodname = @"GetUserMessage";
    [valuedict setValue:@"0" forKey:@"Page"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [valuedict setValue:@"1" forKey:@"State"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)UserMessageToRead
{
    urltest.url = @"http://www.supuy.com/api/phone/UserMessageToRead";
    urltest.methodname = @"UserMessageToRead";
    [valuedict setValue:@"1,21,525,4688" forKey:@"Ids"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetTicketInfo
{
    urltest.url = @"http://www.supuy.com/api/phone/GetTicketInfo";
    urltest.methodname = @"GetTicketInfo";
    [valuedict setValue:@"6CF3RXUSVS" forKey:@"TicketNo"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetTicketList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetTicketList";
    urltest.methodname = @"GetTicketList";
    [valuedict setValue:@"1" forKey:@"IsUsed"];
    [valuedict setValue:@"1" forKey:@"Page"];
    [valuedict setValue:@"10" forKey:@"PageSize"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetTicket
{
    urltest.url = @"http://www.supuy.com/api/phone/GetTicket";
    urltest.methodname = @"GetTicket";
    [valuedict setValue:@"5DA5SVHHCY" forKey:@"TicketNo"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetConsigneeList
{
    urltest.url = @"http://www.supuy.com/api/phone/GetConsigneeList";
    urltest.methodname = @"GetConsigneeList";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetDefaultConsignee
{
    urltest.url = @"http://www.supuy.com/api/phone/GetDefaultConsignee";
    urltest.methodname = @"GetDefaultConsignee";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)AddOrMoidfyConsignee
{
    urltest.url = @"http://www.supuy.com/api/phone/AddOrMoidfyConsignee";
    urltest.methodname = @"AddOrMoidfyConsignee";
    [valuedict setValue:@"3214" forKey:@"ConsigneeId"];
    [valuedict setValue:@"张三" forKey:@"Consignee"];
    [valuedict setValue:@"杭州路67号" forKey:@"Address"];
    [valuedict setValue:@"370687" forKey:@"AreaID"];
    [valuedict setValue:@"370600" forKey:@"CityID"];
    [valuedict setValue:@"370000" forKey:@"ProvinceID"];
    [valuedict setValue:@"053283838383" forKey:@"Tel"];
    [valuedict setValue:@"13333333333" forKey:@"Mobile"];
    [valuedict setValue:@"100006" forKey:@"ZipCode"];
    [valuedict setValue:@"test@test.com" forKey:@"Email"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)DeleteConsignee
{
    urltest.url = @"http://www.supuy.com/api/phone/DeleteConsignee";
    urltest.methodname = @"DeleteConsignee";
    [valuedict setValue:@"432" forKey:@"ConsigneeId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)Update
{
    urltest.url = @"http://www.supuy.com/PhoneApi/Update";
    urltest.methodname = @"Update";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)PostFeedBack
{
    urltest.url = @"http://www.supuy.com/PhoneApi/PostFeedBack";
    urltest.methodname = @"PostFeedBack";
    [valuedict setValue:@"测试" forKey:@"content"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetAboutUs
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetAboutUs";
    urltest.methodname = @"GetAboutUs";
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetArticleCategoryList
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetArticleCategoryList";
    urltest.methodname = @"GetArticleCategoryList";
    [valuedict setValue:@"0" forKey:@"ParentId"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetArticleList
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetArticleList";
    urltest.methodname = @"GetArticleList";
    [valuedict setValue:@"0" forKey:@"categoryId"];
    [valuedict setValue:@"1" forKey:@"page"];
    [valuedict setValue:@"10" forKey:@"pageSize"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetArticleInfo
{
    urltest.url = @"http://www.supuy.com/PhoneApi/GetArticleInfo";
    urltest.methodname = @"GetArticleInfo";
    [valuedict setValue:@"32" forKey:@"Id"];
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)GetAllDistrict
{
    urltest.url = @"http://www.supuy.com/api/phone/GetAllDistrict";
    urltest.methodname = @"GetAllDistrict";
    urltest.havememberid = FALSE;
    [InterFaceTestUtils TestRequestUrl:urltest valuedict:valuedict];
}

- (void)testInterFaceDelegate
{
    [self GetOrderSuccess];
}
//账号：孙冲
//密码：82214662

- (id)init
{
    TestUrlPara *tup = [[TestUrlPara alloc] init];
    self.urltest = tup;
    [tup release];
    NSMutableDictionary *dict = [NSMutableDictionary  dictionary];
    self.valuedict = dict;
    [dict release];
    urltest.memberid = TEST001_MEMBERID;
    return self;
}

- (void)dealloc
{
    [urltest release];
    [valuedict release];
    [super dealloc];
}
@end
