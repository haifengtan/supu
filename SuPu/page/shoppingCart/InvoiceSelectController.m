//
//  InvoiceSelectController.m
//  SuPu
//
//  Created by Steven Fu on 4/21/14.
//  Copyright (c) 2014 com.chichuang. All rights reserved.
//

#import "InvoiceSelectController.h"

@interface InvoiceSelectController (){
    UIView *_footer;
    UITextField *_edt_head;
    UILabel *_lbl_high;
    UILabel *_lbl_description;
}
@property BOOL isPad;
@property (nonatomic,retain) NSString *invoiceName;
@end

@implementation InvoiceSelectController
-(void)dealloc{
    self.invoiceHead = nil;
    self.invoiceID = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.isPad = iPad;
    [super viewDidLoad];
    self.title = @"发票信息";
    self.UMStr = self.title;
     [self setRightBarButton:@"完成" backgroundimagename:@"barButton.png" target:self action:@selector(completeSelect)];
    _action = [[SPInvoiceListAction alloc] init];
    _action.delegate = self;
    [_action requestInvoiceList];
    [self showHUD];
    
}
-(void)completeSelect{
    if (self.delegate){
        [self.delegate selected_invoice:@{@"InvoiceID":self.invoiceID,@"InvoiceName":self.invoiceName,@"InvoiceHead":_edt_head.text}];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onResponseInvoiceListFail{
    [self hideHUD];
    NSLog(@"Request fail");
}
-(void)onResponseInvoiceListSuccess:(SPInvoiceList *)list{
    [self hideHUD];
    self.entryArray = [NSMutableArray arrayWithArray:list.items];
    if ([list.items count]>0 && !self.invoiceID){
        for (id item in list.items) {
            if ([item[@"Ordering"] intValue]==0){
                self.invoiceID = item[@"InvoiceID"];
                break;
            
            }
        }
    }
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.entryArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    id item = [self.entryArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item[@"InvoiceName"];
    if ([item[@"InvoiceID"] isEqualToString:self.invoiceID]){
        UIImage *image=OUO_IMAGE(@"shopCart_checkmark.png");
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:OUO_RECT(0, 0, (image.size.width-1)/2, image.size.height/2)];
        imageView.image=image;
        cell.accessoryView=imageView;
        [imageView release];
        self.invoiceName = item[@"InvoiceName"];
        _lbl_description.text = item[@"Description"];
        _lbl_high.text = item[@"HighDescription"];

    }else{
        cell.accessoryView = nil;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self.entryArray objectAtIndex:indexPath.row];
    self.invoiceID = item[@"InvoiceID"];
    self.invoiceName = item[@"InvoiceName"];
    _lbl_description.text = item[@"Description"];
    _lbl_high.text = item[@"HighDescription"];
    [tableView reloadData];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0){
        if (_footer==nil){
            _footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 21)];
            label.font = [UIFont systemFontOfSize:14.0f];
            label.text = @"发票抬头：";
            [_footer addSubview:label];
            _edt_head = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 230, 21)];
            _edt_head.placeholder = @"个人";
            _edt_head.font =[UIFont systemFontOfSize:14];
            if (self.invoiceHead){
                _edt_head.text = self.invoiceHead;
            }
            [_footer addSubview:_edt_head];
            _lbl_high =[[UILabel alloc] initWithFrame:CGRectMake(10, 50, 310, 21)];
            _lbl_high.font = [UIFont systemFontOfSize:14.0f];
            _lbl_high.textColor =[UIColor redColor];
            [_footer addSubview:_lbl_high];
            _lbl_description =[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 310, 120)];
            _lbl_description.font = [UIFont systemFontOfSize:14.0f];
            _lbl_description.numberOfLines =6;
            [_footer addSubview:_lbl_description];
        
        }
        return _footer;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0)
        return 400.0f;
    return 22.0f;
}
@end
