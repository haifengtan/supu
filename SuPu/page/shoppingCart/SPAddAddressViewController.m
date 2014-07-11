//
//  SPAddAddressViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPAddAddressViewController.h"
#import "SPAddressCell.h"
#import "CCSStringUtility.h"
#import "sqlService.h"
#import "SPAddressListData.h"
#import "CCSStringUtility.h"
#define kAreaName @"areaName"
#define kAreaCode @"areaCode"
#define kSerializeStr(a,b,c)   [NSString stringWithFormat:@"%@ %@ %@",a,b,c];

@interface SPAddAddressViewController ()
@property (retain, nonatomic) NSString *lastselect_row0;
@property (retain, nonatomic) NSString *lastselect_row1;
@property BOOL isPad;

@property (nonatomic,retain) NSString *previousPron;
@property (nonatomic,retain) NSString *previousCity;
@property (nonatomic,retain) NSString *previousArea;


@property (nonatomic,retain) NSString *zip;
@property (nonatomic,retain) NSString *name;
@end

@implementation SPAddAddressViewController
@synthesize isDefault=_isDefault;
@synthesize tableView=_tableView;
@synthesize proviceArray,cityArray,regionArray;
@synthesize footerView=_footerView;
@synthesize isModify;
@synthesize listData=_listData;
@synthesize setDefaultAddressBtn=_setDefaultAddressBtn;
@synthesize deleAddressBtn=_deleAddressBtn;
@synthesize proviceStr= _proviceStr;
@synthesize cityStr=_cityStr;
@synthesize areaStr=_areaStr;
@synthesize lastselect_row0 = _lastselect_row0;//pickerview的最后一次选择(省)
@synthesize lastselect_row1 = _lastselect_row1;//pickerview的最后一次选择(市)
@synthesize isPad;
@synthesize name,zip;
@synthesize previousPron,previousCity,previousArea;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPAddAddressPadViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.tableView.dataSource = nil;
    self.tableView.delegate  = nil;
}
#pragma mark
#pragma mark ------------------onRequestAddressAddAction-----------------------------
-(NSDictionary*)onRequestAddressAddAction{
    NSMutableDictionary *requsetDic=[NSMutableDictionary dictionary];
    
//    NSString *consigneeStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",1)];
//    consigneeStr=consigneeStr?consigneeStr:_listData.mConsignee;
//    [requsetDic setObject:consigneeStr forKey:@"Consignee"];
//    
//    if (consigneeStr.length>8) {
//        [self showAlertView:@"收件人名称过长"];
//        return nil;
//    }
     [requsetDic setObject:self.name forKey:@"Consignee"];
    [requsetDic setObject:self.areaStr forKey:@"AreaID"];
    [requsetDic setObject:self.cityStr     forKey:@"CityID"];
    [requsetDic setObject:self.proviceStr forKey:@"ProvinceID"];
    
    
    
    NSString *addressStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",3)];
    addressStr=addressStr?addressStr:_listData.mAddress;
    [requsetDic setObject:addressStr forKey:@"Address"];
    
     NSString *zipCodeStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",4)];
   
    zipCodeStr=(zipCodeStr?zipCodeStr:_listData.mZipCode);
    
    if (zipCodeStr!=nil && ![zipCodeStr isEqualToString:@""])
    {
        [requsetDic setObject:zipCodeStr forKey:@"ZipCode"];
    }

    
    
    NSString *telStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",6)];
    telStr=telStr?telStr:_listData.mTel;
    if (telStr!=nil && ![telStr isEqualToString:@""]) {
        [requsetDic setObject:telStr forKey:@"Tel"];
    }
    
    NSString *mobileStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",5)];
    if (isModify) {
        if (mobileStr==nil) {
            [requsetDic setObject:_listData.mMobile forKey:@"Mobile"];
        }else{
            [requsetDic setObject:mobileStr forKey:@"Mobile"];
        }
    }else{
        if (mobileStr==nil) {
            
            [requsetDic setObject:@"" forKey:@"Mobile"];
        }else{
            [requsetDic setObject:mobileStr forKey:@"Mobile"];
        }
        
    }
    
    [requsetDic setObject:self.isDefault forKey:@"isDefault"];
    
    if (isModify) {
        [requsetDic setObject:_listData.mConsigneeID forKey:@"ConsigneeId"];
    }
    
    return requsetDic;
}
-(void)onResponseAddressAddSuccess{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyRefreshAddressListKey object:nil];
    
    if (isModify) {
        [self hideHUDWithCompletionMessage:@"地址修改成功" finishedHandler:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self hideHUDWithCompletionMessage:@"地址添加成功" finishedHandler:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
}
-(void)onResponseAddressAddFail{
    [self hideHUD];
    
}
-(void)buildComplete:(id)sender{
    
    [self.view endEditing:NO];
    
    NSString *consigneeStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",1)];
    consigneeStr=consigneeStr?consigneeStr:_listData.mConsignee;
    if (!consigneeStr) {
        [self showAlertView:@"收件人不能为空"];
        return;
    }
    
    if (consigneeStr.length>30) {
        [self showAlertView:@"收件人名称过长"];
        return;
    }
    self.name = consigneeStr;
    
    NSString *addressStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",3)];
    addressStr=addressStr?addressStr:_listData.mAddress;
    if (!addressStr) {
        [self showAlertView:@"地址不能为空"];
        return;
    }
 
    NSString *codeStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",4)];
    codeStr=(codeStr?codeStr:_listData.mZipCode);
    NSLog(@"zip code ---------------- %@",codeStr);
    if (![strOrEmpty(codeStr) isEqualToString:@""]) {
        if ([strOrEmpty(codeStr) length]!=6) {
            [self showAlertView:@"邮编格式不合法"];
            return;
        }
    }
    
    
    NSString *PhoneStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",5)];
    PhoneStr=(PhoneStr?PhoneStr:_listData.mMobile);
    NSString *telStr=[contentDic objectForKey:OUO_STRING_FORMAT(@"%d",6)];
    telStr=(telStr?telStr:_listData.mTel);
    if ((PhoneStr == nil||[PhoneStr isEqualToString:@""])&&(telStr == nil||[telStr isEqualToString:@""])) {
        [self showAlertView:@"至少填写一种联系方式"];
        return;
    }
    
    if (PhoneStr!=nil && ![PhoneStr isEqualToString:@""]&&![CCSStringUtility isMobileNum:PhoneStr]) {
        [self showAlertView:@"手机号码不正确"];
        return;
    }
    if (telStr!=nil && ![telStr isEqualToString:@""]&&![CCSStringUtility isPhoneNum:telStr]) {
        [self showAlertView:@"固话号码不正确"];
        return;
    }
    
    
    addAction=[[SPAddressAddOrUpdateAction alloc] init];
    addAction.m_delegate_addressAdd=self;
    [addAction requestAddressAdd];
    [self showHUD];
}
-(IBAction)setDefaultAddressAction:(id)sender{
    if ([_listData.mIsDefault isEqualToString:@"True"]) {
        self.isDefault = @"false";
    }else{
        self.isDefault=@"True";
        [self buildComplete:nil];
        
    }
}
-(IBAction)deleAddressAction:(id)sender{
    NSArray *array=[NSArray arrayWithObjects:@"确定",nil];
    
    NSString *tips=@"删除收货地址？";
    [UIAlertView showAlertViewWithTitle:@"" message:tips cancelButtonTitle:@"取消"  otherButtonTitles:array handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            deleAction=[[SPAddressDeleteAction alloc] init];
            deleAction.m_delegate_addressDele=self;
            [deleAction requestAddressDele];
        }
    }];
    
}
-(void)showAlertView:(NSString *)message{
    UIAlertView *al=[[UIAlertView alloc] initWithTitle:nil message:message  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [al show];
    [al release];
}
#pragma mark ----------------------------viewDidLoad------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
     
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.jpg"]];
    
    if (isModify) {
        self.title=@"收货地址";
        [self setRightBarButton:@"修 改" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(buildComplete:)];
    }else{
        self.title=@"新建收货地址";
        [self setRightBarButton:@"完 成" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(buildComplete:)];
    }
    
    self.isDefault=@"False";
    
    
    if (isModify)
        self.tableView.tableFooterView=_footerView;
    
    if ([_listData.mIsDefault isEqualToString:@"True"]) {
        [_setDefaultAddressBtn setTitle:@"已是默认地址" forState:UIControlStateNormal];
    }else{
        [_setDefaultAddressBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    }
    
    
    
    contentDic=[[NSMutableDictionary alloc] initWithCapacity:7];
    if (self.isPad) {
        CGRect frame=CGRectMake(0, 960-100, 768, 180);
        cityPicker = [[UIPickerView alloc] initWithFrame:frame];
    }else{
        NSLog(@"self.height ------- %f",self.view.frameHeight);
        CGRect frame=CGRectMake(0, self.view.frameHeight - 86, 320, 216);
        cityPicker = [[UIPickerView alloc] initWithFrame:frame];
    }
    cityPicker.dataSource = self;
    cityPicker.delegate = self;
    cityPicker.showsSelectionIndicator = YES;      // 这个弄成YES, picker中间就会有个条, 被选中的样子
    cityPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:cityPicker];
    [cityPicker release];
    
    service = [[sqlService alloc]init];
    
    self.proviceArray = [service getCityListByProvinceCode:@"000000"];
    
    if (_listData) {
        
        int m = 0;
        int n = 0;
        int k = 0;
        
        if (self.proviceArray.count == 0) {
            m = 0;
            n = 0;
            k = 0;
        }else{
            for (int i = 0 ; i < [self.proviceArray count];i++) {
                
                if ([[[self.proviceArray objectAtIndex:i] objectForKey:kAreaCode] isEqualToString:_listData.mProvinceID]) {
                    m = i;
                    break;
                }
                
            }
            
             self.cityArray = [service getCityListByProvinceCode:[[proviceArray objectAtIndex:m] objectForKey:kAreaCode]];
            if (self.cityArray.count == 0) {
                m = 0;
                n = 0;
                k = 0;
                self.cityArray = [service getCityListByProvinceCode:[[proviceArray objectAtIndex:0] objectForKey:kAreaCode]];
                self.regionArray = [service getCityListByProvinceCode:[[self.cityArray objectAtIndex:0] objectForKey:kAreaCode]];
                
            }else {
                for (int i = 0 ; i < self.cityArray.count;i++) {
                    if ([[[self.cityArray objectAtIndex:i] objectForKey:kAreaCode] isEqualToString:_listData.mCityId]) {
                        n = i;
                        break;
                    }
                    
                }
                
                self.regionArray = [service getCityListByProvinceCode:[[self.cityArray objectAtIndex:n] objectForKey:kAreaCode]];
                
                if (self.regionArray == 0) {
                    m = 0;
                    n = 0;
                    k = 0;
                    self.cityArray = [service getCityListByProvinceCode:[[proviceArray objectAtIndex:0] objectForKey:kAreaCode]];
                    self.regionArray = [service getCityListByProvinceCode:[[self.cityArray objectAtIndex:0] objectForKey:kAreaCode]];
                    
                }else {
                    for (int i = 0 ; i < [ self.regionArray  count];i++) {
                        
                        if ([[[ self.regionArray objectAtIndex:i] objectForKey:kAreaCode] isEqualToString:_listData.mAreaId]) {
                            k = i;
                            break;
                        }
                        
                    }
                }
                
               

            
            }
            
            
        }
        
        self.proviceStr = [[proviceArray objectAtIndex:m] objectForKey:kAreaCode];
        self.cityStr    = [[cityArray objectAtIndex:n]    objectForKey:kAreaCode];
        self.areaStr  = [[regionArray objectAtIndex:k]  objectForKey:kAreaCode];
        
        [cityPicker selectRow:m inComponent:0 animated:YES];
        [cityPicker selectRow:n inComponent:1 animated:YES];
        [cityPicker selectRow:k inComponent:2 animated:YES];
        
        self.lastselect_row0=[NSString stringWithFormat:@"%d",m];
        self.lastselect_row1=[NSString stringWithFormat:@"%d",n];
    }else{
        //的到所有的省份自治区 放到数据库中
        
        
        
        self.cityArray = [service getCityListByProvinceCode:[[proviceArray objectAtIndex:0] objectForKey:kAreaCode]];
        
        self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
        
        self.proviceStr = [[proviceArray objectAtIndex:0] objectForKey:kAreaCode];
        self.cityStr    = [[cityArray objectAtIndex:0]    objectForKey:kAreaCode];
        self.areaStr  = [[regionArray objectAtIndex:0]  objectForKey:kAreaCode];
        self.lastselect_row0 = @"0";
        
    }
    
    
    [_tableView reloadData];
    
}

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    
    NSString *str = @"";
    
    if (component == 0) {
        return [[proviceArray objectAtIndex:row] objectForKey:kAreaName];
    }
    if (component == 1) {
        if ([cityArray count]>0)
            return [[cityArray objectAtIndex:row]objectForKey:kAreaName];
    }
    if (component == 2) {
        
        if ([regionArray count]>0)
            return  [[regionArray objectAtIndex:row] objectForKey:kAreaName];
    }
    return str;
}
#pragma mark ---------------------didSelectRow------------inComponent-----------------
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_listData) {
         
        if (component == 0) {
            
            self.proviceStr = [[self.proviceArray objectAtIndex:row] objectForKey:kAreaCode];
            self.cityArray = [service getCityListByProvinceCode:[[self.proviceArray objectAtIndex:row] objectForKey:kAreaCode]];
            if (self.cityArray.count == 0) {
                NSString *message = [NSString stringWithFormat:@"对不起，服务尚未覆盖%@地区",[[proviceArray objectAtIndex:row] objectForKey:kAreaName]];
                [UIViewHealper helperBasicUIAlertView:@"错误" message:message];
 
                [cityPicker selectRow:[self.lastselect_row0 intValue] inComponent:0 animated:YES];
                
                self.cityArray = [service getCityListByProvinceCode:[[self.proviceArray objectAtIndex:[self.lastselect_row0 intValue]] objectForKey:kAreaCode]];
                
                [cityPicker reloadComponent:1];
                self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
                [cityPicker reloadComponent:2];
                
                self.cityStr = [[self.cityArray objectAtIndex:0] objectForKey:kAreaCode];
                
                
                [cityPicker selectRow:0 inComponent:1 animated:YES];
                
                if ([cityArray count]>1) {
                    [cityPicker selectRow:0 inComponent:2 animated:YES];
                }
                
                if ([regionArray count]>0) {
                    self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
                    
                }
                else{
                    self.areaStr = @"";
                }
//                [self.tableView reloadData];
                return;
            }
            
            [cityPicker reloadComponent:1];
             self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
            [cityPicker reloadComponent:2];
      
            self.cityStr = [[self.cityArray objectAtIndex:0] objectForKey:kAreaCode];
            
            
            [cityPicker selectRow:0 inComponent:1 animated:YES];
            
            if ([cityArray count]>1) {
                [cityPicker selectRow:0 inComponent:2 animated:YES];
            }
            
            if ([regionArray count]>0) {
                self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
                
            }
            else{
                self.areaStr = @"";
            }
            self.lastselect_row0 = [NSString stringWithFormat:@"%d",row];
        }
        else if (component == 1) {
            
            if (self.cityArray.count == 0) {
                return;
            }
            self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:row] objectForKey:kAreaCode]];
            
            if (self.regionArray.count == 0) {
                NSString *message = [NSString stringWithFormat:@"对不起，服务尚未覆盖%@地区",[[cityArray objectAtIndex:row] objectForKey:kAreaName]];
                [UIViewHealper helperBasicUIAlertView:@"错误" message:message];
                [cityPicker selectRow:self.lastselect_row1.intValue inComponent:2 animated:YES];
                self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:[self.lastselect_row1 intValue]] objectForKey:kAreaCode]];
                [cityPicker reloadComponent:2];
                self.cityStr = [[cityArray objectAtIndex:row] objectForKey:kAreaCode];
                
                if ([cityArray count]>1) {
                    [cityPicker selectRow:0 inComponent:2 animated:YES];
                }
                if ([regionArray count]>0) {
                    self.areaStr= [[regionArray objectAtIndex:0] objectForKey:kAreaCode];
                    
                }
                //                [self.tableView reloadData];
                return;
            }
            self.proviceStr = self.proviceArray[[pickerView selectedRowInComponent:0]][kAreaCode];
            
            [cityPicker reloadComponent:2];
            self.cityStr = [[cityArray objectAtIndex:row] objectForKey:kAreaCode];
            if ([cityArray count]>1) {
                [cityPicker selectRow:0 inComponent:2 animated:YES];
            }
            if ([regionArray count]>0) {
                self.areaStr= [[regionArray objectAtIndex:0] objectForKey:kAreaCode];
                
            }
            self.lastselect_row1 = [NSString stringWithFormat:@"%d",row];
        }else{
            self.proviceStr = self.proviceArray[[pickerView selectedRowInComponent:0]][kAreaCode];
            
            self.cityStr = self.cityArray[[pickerView selectedRowInComponent:1]][kAreaCode];
            
            if ([regionArray count]>0) {
                self.areaStr = [[regionArray objectAtIndex:row] objectForKey:kAreaCode];
            }
            
            //第三栏可能没有数据
            
        }
        
    }else {
         
        if (component == 0) {
            self.cityArray = [service getCityListByProvinceCode:[[proviceArray objectAtIndex:row] objectForKey:kAreaCode]];
            if ( self.cityArray.count == 0) {
                NSString *message = [NSString stringWithFormat:@"对不起，服务尚未覆盖%@地区",[[proviceArray objectAtIndex:row] objectForKey:kAreaName]];
                [UIViewHealper helperBasicUIAlertView:@"错误" message:message];
                [cityPicker selectRow:self.lastselect_row0.intValue inComponent:0 animated:YES];
                
                self.cityArray = [service getCityListByProvinceCode:[[self.proviceArray objectAtIndex:[self.lastselect_row0 intValue]] objectForKey:kAreaCode]];
                
                [cityPicker reloadComponent:1];
                self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
                [cityPicker reloadComponent:2];
                
                self.cityStr = [[self.cityArray objectAtIndex:0] objectForKey:kAreaCode];
                
                
                [cityPicker selectRow:0 inComponent:1 animated:YES];
                
                if ([cityArray count]>1) {
                    [cityPicker selectRow:0 inComponent:2 animated:YES];
                }
                
                if ([regionArray count]>0) {
                    self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
                    
                }
                else{
                    self.areaStr = @"";
                }
//                [self.tableView reloadData];
                return;
            }
            
            [cityPicker reloadComponent:1];
            self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
            [cityPicker reloadComponent:2];
            
            self.proviceStr = [[proviceArray objectAtIndex:row] objectForKey:kAreaCode];
            self.cityStr = [[cityArray objectAtIndex:0] objectForKey:kAreaCode];
            
            [cityPicker selectRow:0 inComponent:1 animated:YES];
            if ([cityArray count]>1) {
                [cityPicker selectRow:0 inComponent:2 animated:YES];
            }
            if ([regionArray count]>0) {
                self.areaStr = [[regionArray objectAtIndex:0] objectForKey:kAreaCode];
                
            }
            else{
                self.areaStr = @"";
            }
            self.lastselect_row0 = [NSString stringWithFormat:@"%d",row];
        }
        else if (component == 1) {
            NSMutableArray *regiontemparr = [service getCityListByProvinceCode:[[cityArray objectAtIndex:row] objectForKey:kAreaCode]];
            if (regiontemparr.count == 0) {
                NSString *message = [NSString stringWithFormat:@"对不起，服务尚未覆盖%@地区",[[cityArray objectAtIndex:row] objectForKey:kAreaName]];
                [UIViewHealper helperBasicUIAlertView:@"错误" message:message];
                [cityPicker selectRow:self.lastselect_row1.intValue inComponent:1 animated:YES];
                self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:[self.lastselect_row1 intValue]] objectForKey:kAreaCode]];
                [cityPicker reloadComponent:2];
                self.cityStr = [[cityArray objectAtIndex:row] objectForKey:kAreaCode];
                
                if ([cityArray count]>1) {
                    [cityPicker selectRow:0 inComponent:2 animated:YES];
                }
                if ([regionArray count]>0) {
                    self.areaStr= [[regionArray objectAtIndex:0] objectForKey:kAreaCode];
                    
                }
                
                [self.tableView reloadData];
                return;
            }
            self.regionArray = regiontemparr;
            [cityPicker reloadComponent:2];
            self.cityStr = [[cityArray objectAtIndex:row] objectForKey:kAreaCode];
            
            if ([cityArray count]>1) {
                [cityPicker selectRow:0 inComponent:2 animated:YES];
            }
            if ([regionArray count]>0) {
                self.areaStr= [[regionArray objectAtIndex:0] objectForKey:kAreaCode];
                
            }
            self.lastselect_row1 = [NSString stringWithFormat:@"%d",row];
        }
        else{
            if ([regionArray count]>0) {
                self.areaStr = [[regionArray objectAtIndex:row] objectForKey:kAreaCode];
            }
            
            //第三栏可能没有数据
            
        }
        
    }
    
//修复Bug----编辑地址时，滑动市的同时滑动区，则可以选择不属于所选市的区域
    //判断城市是否在当前省内
    self.cityArray = [service getCityListByProvinceCode:self.proviceStr];
    NSMutableArray *tempArray = [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
    for (NSDictionary *dict in self.cityArray) {
        NSString *areaCode = [dict objectForKey:@"areaCode"];
        [tempArray addObject:areaCode];
    }
    
    if ([tempArray containsObject:self.cityStr]) {
        [self.tableView reloadData];
        
        self.regionArray = [service getCityListByProvinceCode:self.cityStr];
        
        NSMutableArray *l_areaArr=[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in self.regionArray) {
            NSString *areaCode = [dict objectForKey:@"areaCode"];
            [l_areaArr addObject:areaCode];
        }
        if ([l_areaArr containsObject:self.areaStr]) {
            
            [self.tableView reloadData];
        }else{
            
            
            [cityPicker selectRow:self.lastselect_row1.intValue inComponent:1 animated:YES];
            self.cityStr = [[self.cityArray objectAtIndex:[self.lastselect_row1 intValue]] objectForKey:kAreaCode];
            
            self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:self.lastselect_row1.intValue] objectForKey:kAreaCode]];
            [cityPicker reloadComponent:2];
            if ([regionArray count]>0) {
                
                [cityPicker selectRow:0 inComponent:2 animated:YES];
                self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
            }else{
                self.areaStr = @"";
            }
        }
        
        NSArray *l_arr_row=[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]];
        [self.tableView reloadRowsAtIndexPaths:l_arr_row withRowAnimation:UITableViewRowAnimationNone];
        
        return;
    }else{
        [cityPicker selectRow:self.lastselect_row0.intValue inComponent:0 animated:YES];
        self.proviceStr = [[self.proviceArray objectAtIndex:[self.lastselect_row0 intValue]] objectForKey:kAreaCode];
        
        self.cityArray = [service getCityListByProvinceCode:[[self.proviceArray objectAtIndex:[self.lastselect_row0 intValue]] objectForKey:kAreaCode]];
        [cityPicker reloadComponent:1];
        [cityPicker selectRow:0 inComponent:1 animated:YES];
        self.cityStr = [[self.cityArray objectAtIndex:0] objectForKey:kAreaCode];
        
        self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:0] objectForKey:kAreaCode]];
        [cityPicker reloadComponent:2];
        if ([regionArray count]>0) {
            [cityPicker selectRow:0 inComponent:2 animated:YES];
            self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
        }else{
            self.areaStr = @"";
        }
        
    }
    
    self.regionArray = [service getCityListByProvinceCode:self.cityStr];
    
    NSMutableArray *l_areaArr=[NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in self.regionArray) {
        NSString *areaCode = [dict objectForKey:@"areaCode"];
        [l_areaArr addObject:areaCode];
    }
    if ([l_areaArr containsObject:self.areaStr]) {
        
        [self.tableView reloadData];
    }else{
        
        
        [cityPicker selectRow:self.lastselect_row1.intValue inComponent:1 animated:YES];
        self.cityStr = [[self.cityArray objectAtIndex:[self.lastselect_row1 intValue]] objectForKey:kAreaCode];
        
        self.regionArray = [service getCityListByProvinceCode:[[cityArray objectAtIndex:self.lastselect_row1.intValue] objectForKey:kAreaCode]];
        [cityPicker reloadComponent:2];
        if ([regionArray count]>0) {
            [cityPicker selectRow:0 inComponent:2 animated:YES];
            self.areaStr = [[self.regionArray objectAtIndex:0] objectForKey:kAreaCode];
        }else{
            self.areaStr = @"";
        }
    }
    NSArray *l_arr_row=[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]];
    [self.tableView reloadRowsAtIndexPaths:l_arr_row withRowAnimation:UITableViewRowAnimationNone];

}
#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [proviceArray count];
    }
    if (component == 1) {
        return [cityArray count];
    }
    if (component == 2) {
        return [regionArray count];
    }
    return 0;
}


-(void)onResponseBuildAddressDataSuccess:(NSArray *)l_data_cityList{
    
    
    
}
-(void)onResponseBuildAddressDataFail{
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  6;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
#pragma mark -
#pragma mark - tableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger  section=indexPath.section;
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
    SPAddressCell  *cell = (SPAddressCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = nil;
        if (self.isPad) {
            array=[[NSBundle mainBundle] loadNibNamed:@"SPAddressPadCell" owner:self  options:nil];
        }else{
            array=[[NSBundle mainBundle] loadNibNamed:@"SPAddressCell" owner:self  options:nil];
        }
        cell=[array objectAtIndex:0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (section == 2) {
            UITextView *addressdetailview = nil;
            if (self.isPad) {
                addressdetailview = [[UITextView alloc] initWithFrame:CGRectMake(16, 66, 648, 160)];
                [addressdetailview setFont:[UIFont systemFontOfSize:18]];
            }else{
                addressdetailview = [[UITextView alloc] initWithFrame:CGRectMake(8, 33, 280, 80)];
                [addressdetailview setFont:[UIFont systemFontOfSize:18]];
            }
            addressdetailview.backgroundColor = [UIColor clearColor];
            addressdetailview.tag = section+1;
            addressdetailview.delegate = self;
            [cell.contentView addSubview:addressdetailview];
            [addressdetailview release];
            cell.contentField.hidden = YES;
        }
    }
    cell.contentField.delegate=self;
    cell.contentField.tag=section+1;
    
    
    switch (section) {
        case 0:{
            cell.titleLabel.text = @"收件人：";
            break;
        }
        case 1:{
            cell.titleLabel.text = @"所在区域：";
            
            break;
        }
        case 2:{
            if (self.isPad) {
                cell.titleLabel.frame = CGRectMake(38, 20, 600, 42);
            }else{
                cell.titleLabel.frame = CGRectMake(19, 11, 280, 21);
            }
        
            cell.titleLabel.text = @"请填写详细地址（100个字符）：";
            break;
        }
        case 3:{
            cell.needsublabel.hidden = YES;
            cell.titleLabel.text = @"邮编：";
            cell.contentField.keyboardType=UIKeyboardTypeNumberPad;
            break;
        }
        case 4:{
            cell.needsublabel.hidden = YES;
            cell.titleLabel.text = @"手机号：";
            cell.contentField.keyboardType=UIKeyboardTypeNumberPad;
            break;
        }
        case 5:{
            cell.titleLabel.text = @"固话号：";
            cell.contentField.keyboardType=UIKeyboardTypeNumberPad;
            cell.needsublabel.hidden = YES;
            break;
        }
        default:
            break;
    }
    if (isModify) {//如果是修改状态
        if (section == 0 && _listData.mConsignee){
            
            cell.contentField.text=_listData.mConsignee;
        }else if (section == 1) {
            
            if (buttonStatus) {
                
                cell.contentField.text=[self serializeDetailsAddressName:self.proviceStr :self.cityStr : self.areaStr];
            }else{
                cell.contentField.text=  [self serializeDetailsAddressName:_listData.mProvinceID :_listData.mCityId :_listData.mAreaId];
            }
            cell.cityButton.hidden=NO;
            [cell.cityButton addTarget:self action:@selector(showCityPicker:) forControlEvents:UIControlEventTouchUpInside];
        }else if(section == 2 && _listData.mAddress){
            ((UITextView *)[[cell.contentView subviews] objectAtIndex:4]).text = _listData.mAddress;
        }else if (section == 3 && _listData.mZipCode) {
            cell.contentField.text=_listData.mZipCode;
        }else if(section == 4 && _listData.mMobile){
            cell.contentField.text=_listData.mMobile;
        }else if (section == 5 && _listData.mTel){
            cell.contentField.text=_listData.mTel;
        }
    }else{//新增页面
        if (section==1) {
            cell.contentField.text=[self serializeDetailsAddressName:_proviceStr :_cityStr : _areaStr];
            cell.cityButton.hidden=NO;
            [cell.cityButton addTarget:self action:@selector(showCityPicker:) forControlEvents:UIControlEventTouchUpInside];
        }else if(section ==2){
            ((UITextView *)[[cell.contentView subviews] objectAtIndex:4]).text = [contentDic objectForKey:OUO_STRING_FORMAT(@"%d", section+1)];
        }else{
            cell.contentField.text= [contentDic objectForKey:OUO_STRING_FORMAT(@"%d", section+1)];
        }
    }
    return cell;
    
}
-(NSString *)serializeDetailsAddressName:(NSString *)str1 :(NSString *)str2 :(NSString *)str3 {
    
    NSString *province =  [service getCityName:str1];
    NSString *city     =  [service getCityName:str2];
    NSString *area     =  [service getCityName:str3];
    
    return kSerializeStr(province,city,area);;
}

#pragma mark textfield的代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [contentDic setObject:textField.text forKey:OUO_STRING_FORMAT(@"%d", textField.tag)];
}

#pragma mark textview的代理
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [contentDic setObject:textView.text forKey:OUO_STRING_FORMAT(@"%d", textView.tag)];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>100) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 100)];
        return;
    }
}

//弹出picker
-(void)showCityPicker:(id)sender{
    
    buttonStatus=YES;
    UIControl *l_control= nil;
    if (self.isPad) {
        l_control=[[UIControl alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)];
    }else{
        l_control=[[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    }
    [l_control setBackgroundColor:[UIColor clearColor]];
    
    [l_control addTarget:self action:@selector(hiddenKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:l_control aboveSubview:_tableView];
    [l_control release];
    
    UITextField *textFieldSection1=(UITextField *)[self.view viewWithTag:1];
    [textFieldSection1 resignFirstResponder];
    
    
    CGRect rect=cityPicker.frame;
    if (self.isPad) {
        rect.origin.y=960-100-180;
    }else{
        rect.origin.y=self.view.frameHeight-306 + kNavHeight + kTabbarHeight;
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        cityPicker.frame=rect;
    }];
    UITextField *textField=(UITextField *)[self.view viewWithTag:2];
    if (!isModify) {
        textField.text=[self serializeDetailsAddressName:_proviceStr :_cityStr : _areaStr];
    }else{
        
        
    }
    
}
-(NSDictionary*)onRequestAddressDeleAction{
    
    NSMutableDictionary *requestDic=[NSMutableDictionary  dictionary];
    [requestDic setObject:_listData.mConsigneeID forKey:@"ConsigneeId"];
    return requestDic;
}
-(void)onResponseAddressDeleSuccess{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyRefreshAddressListKey object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onResponseAddressDeleFail{
    
}
-(void)hiddenKeyBoard:(id)sender{
    
    UIControl *l_control=(UIControl *)sender;
    [l_control removeFromSuperview];
    [self hideCityPicker];
}
-(void)hideCityPicker{
    CGRect rect=cityPicker.frame;
    if (self.isPad) {
        rect.origin.y=960-100;
    }else{
        rect.origin.y=self.view.frameHeight - 86 + kNavHeight  + kTabbarHeight;
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        cityPicker.frame=rect;
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isPad) {
        if(indexPath.section==2) return 240;
        return 90;
    }else{
        if(indexPath.section==2) return 120;
        return 45;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 4;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload{
    [super viewDidUnload];
    self.tableView=nil;
//    self.regionArray=nil;
//    self.cityArray=nil;
//    self.proviceArray=nil;
    self.footerView=nil;
    self.deleAddressBtn=nil;
    self.setDefaultAddressBtn=nil;
//    self.lastselect_row0 = nil;
//    self.lastselect_row1 = nil;
//    self.zip = nil;
//    self.name = nil;
}
-(void)dealloc{
    [_footerView release];
    [_deleAddressBtn release];
    [_setDefaultAddressBtn release];
    [_listData release];
    [service release];
    [proviceArray release];
    [cityArray release];
    [_tableView release];
    [regionArray release];
    [addAction release];
    [_cityStr release];
    [_proviceStr release];
    [_areaStr release];
    [_lastselect_row0 release];
    [_lastselect_row1 release];
    [zip release];
    [name release];
    [super dealloc];
}

@end
