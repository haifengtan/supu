//
//  SPCouponsObject.h
//  SuPu
//
//  Created by 持创 on 13-3-29.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gift : SPBaseData
@property (nonatomic,retain)NSString *m_PresentSN;
@property (nonatomic,retain)NSString *m_PresentName;
@property (nonatomic,retain)NSString *m_GiftCount;
@end


@interface SPCouponsObject : SPBaseData
@property (nonatomic,retain)NSString *m_ErrorCode;
@property (nonatomic,retain)NSString *m_Message;
@property (nonatomic,retain)NSString *m_TicketNo;
@property (nonatomic,retain)NSString *m_ValidateResult;
@property (nonatomic,retain)NSString *m_TicketName;
@property (nonatomic,retain)NSString *m_TicketDescribe;
@property (nonatomic,retain)NSString *m_DiscountAmount;
@property (nonatomic,retain)NSString *m_DiscountCumulative;
@property (nonatomic,retain)NSString *m_Discount;
@property (nonatomic,retain)NSMutableArray *m_TicketsGifts;
@end
