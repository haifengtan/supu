//
//  InvoiceSelectController.h
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "SPBaseTableViewController.h"
#import "SPInvoiceListAction.h"

@protocol InvoiceSelectDelegate <NSObject>

-(void)selected_invoice:(id)data;

@end

@interface InvoiceSelectController : SPBaseTableViewController<SPInvoiceListActionDelegate>{
    SPInvoiceListAction *_action;
    
}
@property (nonatomic,retain) NSString *invoiceID;
@property (nonatomic,retain) NSString *invoiceHead;
@property (nonatomic,assign) id<InvoiceSelectDelegate> delegate;

@end
