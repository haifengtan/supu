//
//  SPTableViewDelegate.h
//  SuPu
//
//  Created by 邢 勇 on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPTableViewDelegate <NSObject>

-(void)tableViewPassPaymentId:(NSString *)paymentId paymentName:(NSString *)paymentName;
-(void)tableViewPassShippingID:(NSString *)shippingId shippingName:(NSString *)shippingName;
-(void)tableViewPassTicketDiscount:(NSString *)ticketno discount:(float)discount;

@end
