//
//  SPInvoiceList.m
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "SPInvoiceList.h"

@implementation SPInvoiceList
-(void)dealloc{
    self.items = nil;
    [super dealloc];
}

@end
@implementation SPInvoiceData


-(void)dealloc{
    self.invoiceID = nil;
    self.invoiceName = nil;
    self.highDescription = nil;
    self.description = nil;
    self.ordering = nil;
    [super dealloc];
}

@end
