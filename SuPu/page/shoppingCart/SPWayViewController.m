//
//  SPWayViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPWayViewController.h"

@interface SPWayViewController()

@property BOOL isPad;

@end

@implementation SPWayViewController
@synthesize wayState=_wayState;
@synthesize lastIndexPath=_lastIndexPath;
@synthesize paymentId=_paymentId;
@synthesize areaId=_areaId;
@synthesize delegate;
@synthesize lastselectname = _lastselectname;
@synthesize isPad;

-(void)dealloc{

    [super dealloc];
}

- (void)viewDidLoad
{
    self.isPad = iPad;
    [super viewDidLoad];
    self.title=self.navTitle;
    self.UMStr=self.navTitle;
    paymentStyleAction=[[SPPaymentStyleAction alloc] init];
    paymentStyleAction.m_delegate_payment=self;
    [paymentStyleAction requestPayment];
    [self showHUD];
}

-(NSDictionary*)onRequestPaymentAction{
    NSMutableDictionary *requsetDic=[NSMutableDictionary dictionary];
    if (self.areaId != nil) {
       [requsetDic setObject:self.areaId forKey:@"AreaId"];
    }
    
    if (self.paymentId!=nil) {
        [requsetDic setObject:self.paymentId forKey:@"PaymentId"];
    }
    
    return requsetDic;
}

-(void)onResponsePaymentSuccess:(SPStyleList*)styleData{
    [self hideHUD];
    if (self.wayState) {
        self.entryArray=[NSMutableArray arrayWithArray:styleData.mShipArray];
    }else{
         self.entryArray=[NSMutableArray arrayWithArray:styleData.mPaymentArray];
    }
    [_tableView reloadData];
}
-(void)onResponsePaymentFail{
    [self hideHUD];
//    [UIViewHealper helperBasicASIFailUIAlertView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.entryArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor whiteColor];
        if (self.isPad) {
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:24]];
        }else{
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        }
    }
    NSDictionary *cellDic=[self.entryArray objectAtIndex:indexPath.row];
    if (self.wayState) {
         cell.textLabel.text=[cellDic objectForKey:@"ShippingName"];
    }else{
        cell.textLabel.text=[cellDic objectForKey:@"PaymentName"];
    }
    if (_lastselectname!= nil && [cell.textLabel.text isEqualToString:_lastselectname]) {
        UIImage *image=OUO_IMAGE(@"shopCart_checkmark.png");
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:OUO_RECT(0, 0, (image.size.width-1)/2, image.size.height/2)];
        imageView.image=image;
        cell.accessoryView=imageView;
        [imageView release];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isPad) {
        return 88;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int newRow = [indexPath row];
    int oldRow = (_lastIndexPath != nil) ? [_lastIndexPath row] : -1;
    
    if (newRow != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        UIImage *image=OUO_IMAGE(@"shopCart_checkmark.png");
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:OUO_RECT(0, 0, (image.size.width-1)/2, image.size.height/2)];
        imageView.image=image;
        newCell.accessoryView=imageView;
        [imageView release];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:
                                    _lastIndexPath];
        oldCell.accessoryView=nil;
        //赋值应当放在最后一行 经典赋值
		self.lastIndexPath = indexPath;
    }
    NSDictionary *cellDic=[self.entryArray objectAtIndex:indexPath.row];
    if (self.wayState) {
        NSString *value =[cellDic objectForKey:@"ShippingID"];
        NSString *ShippingName = [cellDic objectForKey:@"ShippingName"];
        if (delegate) {
            [self.delegate tableViewPassShippingID:value shippingName:ShippingName];
        }
    
    }else{
        NSString *value =[cellDic objectForKey:@"PaymentID"];
        NSString *PaymentName =[cellDic objectForKey:@"PaymentName"];
        if (delegate) {
            [self.delegate tableViewPassPaymentId:value paymentName:PaymentName];
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
