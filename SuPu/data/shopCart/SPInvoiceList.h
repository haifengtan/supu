//
//  SPInvoiceList.h
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "SPBaseData.h"

@interface SPInvoiceList : SPBaseData{
    
}
@property (nonatomic,retain) NSArray *items;

@end

@interface SPInvoiceData : SPBaseData{
    
}
@property (nonatomic,retain) NSString *invoiceID;
@property (nonatomic,retain) NSString *invoiceName;
@property (nonatomic,retain) NSString *highDescription;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *ordering;

@end
