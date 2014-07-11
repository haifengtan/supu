//
//  SPAddressManagerViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddressManagerViewController.h"
#import "SPAddressListCell.h"
#import "sqlService.h"
#import "SPBalanceAccountViewController.h"

@interface SPAddressManagerViewController()

@property BOOL isPad;

-(void)receiveRefreshAddressList;
@end


@implementation SPAddressManagerViewController
@synthesize consigneeId=_consigneeId;
@synthesize isEdit;
@synthesize addressListDelegate;
@synthesize isPad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPAddressManagerPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"收货地址列表";
    
    UIImage *l_image=[UIImage imageNamed:@"背景.jpg"];
    if (iPad) {
        l_image=[UIImage imageNamed:@"背景_iPad.jpg"]; 
    }else{
        l_image=[UIImage imageNamed:@"背景.jpg"];
    }
    _tableView.backgroundColor = [UIColor colorWithPatternImage:l_image];

    _tableView.showsVerticalScrollIndicator = NO;
    [self setRightBarButton:@"新 建" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(buildAddressList:)];
    
    listAction=[[SPAddressListAction alloc] init];
    listAction.m_delegate_addresslist=self;
    [listAction requestAddressListData];
    [self showHUD];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRefreshAddressList) name:kNotifyRefreshAddressListKey object:nil];
    
}


-(void)receiveRefreshAddressList{
    [listAction requestAddressListData];
    [self showHUD];
}

-(NSDictionary*)onRequestAddressListDataAction{
    
    return nil;
}
-(void)onResponseAddressListDataSuccess:(NSArray*)l_array_address{
    [self.entryArray removeAllObjects];
    [self.entryArray addObjectsFromArray:l_array_address];
    [_tableView reloadData];
    [self hideHUD];
}
-(void)onResponseAddressListDataFail{
    [self hideHUD];
 
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}
-(void)buildAddressList:(id)sender{
    [Go2PageUtility go2BuildAddressListViewControllerFrom:self isModify:NO addressListData:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.entryArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    SPAddressListCell  *cell = (SPAddressListCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = nil;
        if (self.isPad) {
            array=[[NSBundle mainBundle] loadNibNamed:@"SPAddressListPadCell" owner:self  options:nil];
        }else{
            array=[[NSBundle mainBundle] loadNibNamed:@"SPAddressListCell" owner:self  options:nil];
        }
        cell=[array objectAtIndex:0];
        if (isEdit) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    SPAddressListData *list=[self.entryArray objectAtIndex:indexPath.row];
    if ([list.mIsDefault isEqualToString:@"True"]) {
        cell.defaultmessagelabel.hidden = NO;
    }else{
        cell.defaultmessagelabel.hidden = YES;
    }
    cell.nameLabel.text=list.mConsignee;
//    NSLog(@"mAddress------------- %@",list.mAddressInfo);
    cell.addreLabel.text=list.mAddressInfo;
    cell.zipCodeLabel.text=list.mZipCode;
    cell.telLabel.text=list.mMobile;
    
    return cell;
    
    
    
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//
//        NSInteger row=indexPath.row;
//
//         SPAddressListData *list=[self.entryArray objectAtIndex:indexPath.row];
//
//        self.consigneeId =list.mConsigneeID;
//
//        NSArray *array=[NSArray arrayWithObjects:@"确定",nil];
//
//        NSString *tips=@"删除收货地址？";
//        [UIAlertView showAlertViewWithTitle:@"" message:tips cancelButtonTitle:@"取消"  otherButtonTitles:array handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            if (buttonIndex==1) {
//
//                [self.entryArray  removeObjectAtIndex:row];
//
//                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//                deleAction=[[SPAddressDeleteAction alloc] init];
//                deleAction.m_delegate_addressDele=self;
//                [deleAction requestAddressDele];
//            }
//        }];
//
//    }
//
//
//}
-(NSDictionary*)onRequestAddressDeleAction{
    
    NSMutableDictionary *requestDic=[NSMutableDictionary  dictionary];
    [requestDic setObject:self.consigneeId forKey:@"ConsigneeId"];
    return requestDic;
}
-(void)onResponseAddressDeleSuccess{
    
}
-(void)onResponseAddressDeleFail{
    
}

//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return  @"删除";
//}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        return UITableViewCellEditingStyleDelete;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPAddressListData *list=[self.entryArray objectAtIndex:indexPath.row];
    if (self.isPad) {
        return [SPAddressListCell heightForContent:list.mAddressInfo];
    }else{
        DLog(@"list.mAddressInfo:%@", list.mAddressInfo);
        return [SPAddressListCell heightForContent:list.mAddressInfo];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPAddressListData *list=[self.entryArray objectAtIndex:indexPath.row];
    if (indexPath.section==0&&isEdit) {
        [Go2PageUtility go2BuildAddressListViewControllerFrom:self isModify:YES addressListData:list];
        
    }else{
        
        if (addressListDelegate&&[(UIViewController*)addressListDelegate respondsToSelector:@selector(passAddressListData:)]) {
            [addressListDelegate passAddressListData:list];
        }
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
