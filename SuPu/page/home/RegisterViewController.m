//
//  RegisterViewController.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "RegisterViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RequestHelper.h"
#import "CheckHelper.h"
#import "UIPickerTitleView.h"
#import "Member.h"
#import "SPActionUtility.h"
@interface RegisterViewController ()

@property (retain, nonatomic) NSString *beardate;
@property (retain, nonatomic) UILabel *bearlable;
@property (retain, nonatomic) UITextField *usernamefield;
@property (retain, nonatomic) UITextField *passwordfield;
@property (retain, nonatomic) UITextField *verifypasswordfield;
@property (retain, nonatomic) UITextField *referrerfield;
@property (retain, nonatomic) UITextField *emailfield;
@property (retain, nonatomic) UIPickerTitleView *ptv;
@property BOOL isPad;

@end

@implementation RegisterViewController
@synthesize beardate;
@synthesize bearlable;
@synthesize usernamefield;
@synthesize passwordfield;
@synthesize verifypasswordfield;
@synthesize referrerfield;
@synthesize emailfield;
@synthesize isPad;
@synthesize ptv;
@synthesize registerSuccessBlock;

- (void)dealloc
{
    [beardate release];
    [bearlable release];
    [usernamefield release];
    [passwordfield release];
    [verifypasswordfield release];
    [referrerfield release];
    [emailfield release];
    [registerSuccessBlock release];
    [ptv release];
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
    self.title = @"用户注册";
    self.UMStr =@"用户注册";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    TPKeyboardAvoidingTableView *registerview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    registerview.delegate = self;
    registerview.dataSource = self;
    [self.view addSubview:registerview];
    [registerview release];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        return 1;
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 90;
    }else{
        return 45;
    }
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isPad) {
        if (section == 0) {
            return 30;
        }else{
            return 1;
        }
    }else{
        if (section == 0) {
            return 15;
        }else{
            return 1;
        }
    }
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isPad) {
        if (section == 0) {
            return 50;
        }else {
            return 370;
        }
    }else{
        if (section == 0) {
            return 25;
        }else {
            return 185;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else {
        UIView *section2view = nil;
        UIButton *registerbtn = nil;
        if (self.isPad) {
            section2view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 60)] autorelease];
            registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(184, 20, 400, 70)];
            [registerbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:26]];
        }else{
            section2view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
            registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 200, 35)];
        }
        [registerbtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerbtn addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *registerimage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"登录按钮" ofType:@"png"]];
        [registerbtn setBackgroundImage:registerimage forState:UIControlStateNormal];
        [registerimage release];
        [section2view addSubview:registerbtn];
        [registerbtn release];
        return section2view;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellindentify = @"reigstercell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellindentify] autorelease];
        cell.selectionStyle = UITableViewCellStyleDefault;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UILabel *tiplabel = nil;
                if (self.isPad) {
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 130, 30)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:24]];
                    usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(170, 0, 510, 90)];
                    [usernamefield setFont:[UIFont systemFontOfSize:24]];
                }else{
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 65, 15)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:13]];
                    usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 255, 45)];
                    [usernamefield setFont:[UIFont systemFontOfSize:13]];
                }
                tiplabel.backgroundColor = [UIColor clearColor];
                tiplabel.text = @"用户名：";
                [cell.contentView addSubview:tiplabel];
                [tiplabel release];
                
                usernamefield.placeholder = @"请输入用户名";
                usernamefield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                usernamefield.delegate = self;
                usernamefield.returnKeyType = UIReturnKeyDone;
                usernamefield.autocapitalizationType = NO;
                [cell.contentView addSubview:usernamefield];
            }
            if (indexPath.row == 1) {
                UILabel *tiplabel = nil;
                if (self.isPad) {
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 130, 30)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:24]];
                    passwordfield = [[UITextField alloc] initWithFrame:CGRectMake(170, 0, 510, 90)];
                    [passwordfield setFont:[UIFont systemFontOfSize:24]];
                }else{
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 65, 15)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:13]];
                    passwordfield = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 255, 45)];
                    [passwordfield setFont:[UIFont systemFontOfSize:13]];
                }
                tiplabel.backgroundColor = [UIColor clearColor];
                tiplabel.text = @"密码：";
                [cell.contentView addSubview:tiplabel];
                [tiplabel release];

                passwordfield.placeholder = @"请输入密码";
                passwordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                passwordfield.secureTextEntry = YES;
                passwordfield.delegate = self;
                passwordfield.returnKeyType = UIReturnKeyDone;
                passwordfield.autocapitalizationType = NO;
                [cell.contentView addSubview:passwordfield];
            }
            if (indexPath.row == 2) {
                UILabel *tiplabel = nil;
                if (self.isPad) {
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 130, 30)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:24]];
                    verifypasswordfield = [[UITextField alloc] initWithFrame:CGRectMake(170, 0, 510, 90)];
                    [verifypasswordfield setFont:[UIFont systemFontOfSize:24]];
                }else{
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 65, 15)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:13]];
                    verifypasswordfield = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 255, 45)];
                    [verifypasswordfield setFont:[UIFont systemFontOfSize:13]];
                }
                
                tiplabel.backgroundColor = [UIColor clearColor];
                tiplabel.text = @"确认密码：";
                [cell.contentView addSubview:tiplabel];
                [tiplabel release];

                verifypasswordfield.placeholder = @"请确认密码";
                verifypasswordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                verifypasswordfield.secureTextEntry = YES;
                verifypasswordfield.delegate = self;
                verifypasswordfield.returnKeyType = UIReturnKeyDone;
                verifypasswordfield.autocapitalizationType = NO;
                [cell.contentView addSubview:verifypasswordfield];
            }
            if (indexPath.row == 3) {
                UILabel *tiplabel =  nil;
                if (self.isPad) {
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 130, 30)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:24]];
                    referrerfield = [[UITextField alloc] initWithFrame:CGRectMake(170, 0, 510, 90)];
                    [referrerfield setFont:[UIFont systemFontOfSize:24]];
                }else{
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 65, 15)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:13]];
                    referrerfield = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 255, 45)];
                    [referrerfield setFont:[UIFont systemFontOfSize:13]];
                }
                
                tiplabel.backgroundColor = [UIColor clearColor];
                tiplabel.text = @"推荐人：";
                [cell.contentView addSubview:tiplabel];
                [tiplabel release];
                
                referrerfield.placeholder = @"请输入推荐人";
                referrerfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                referrerfield.delegate = self;
                referrerfield.returnKeyType = UIReturnKeyDone;
                referrerfield.autocapitalizationType = NO;
                [cell.contentView addSubview:referrerfield];
            }
            if (indexPath.row == 4) {
                UILabel *tiplabel = nil;
                if (self.isPad) {
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 130, 30)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:24]];
                    emailfield = [[UITextField alloc] initWithFrame:CGRectMake(170, 0, 510, 90)];
                    [emailfield setFont:[UIFont systemFontOfSize:24]];
                }else{
                    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 65, 15)];
                    [tiplabel setFont:[UIFont boldSystemFontOfSize:13]];
                    emailfield = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, 255, 45)];
                    [emailfield setFont:[UIFont systemFontOfSize:13]];
                }
                
                tiplabel.backgroundColor = [UIColor clearColor];
                tiplabel.text = @"邮箱：";
                [cell.contentView addSubview:tiplabel];
                [tiplabel release];
                
                emailfield.placeholder = @"请输入邮箱";
                emailfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                emailfield.delegate = self;
                emailfield.returnKeyType = UIReturnKeyDone;
                emailfield.autocapitalizationType = NO;
                [cell.contentView addSubview:emailfield];
            }
        }
        if (indexPath.section == 1 &&indexPath.row == 0) {
            if (indexPath.row == 0) {
                if (self.isPad) {
                    bearlable = [[UILabel alloc] initWithFrame:CGRectMake(84, 30, 600, 30)];
                    [bearlable setFont:[UIFont boldSystemFontOfSize:24]];
                }else{
                    bearlable = [[UILabel alloc] initWithFrame:cell.bounds];
                    [bearlable setFont:[UIFont boldSystemFontOfSize:13]];
                }
                bearlable.text = @"请选择宝宝生日";
                bearlable.textAlignment = UITextAlignmentCenter;
                bearlable.backgroundColor = [UIColor clearColor];
                [cell addSubview:bearlable];
                cell.selectionStyle = UITableViewCellStyleDefault;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (self.ptv == nil) {
            if(self.isPad){
                ptv = [[UIPickerTitleView alloc] initWithFrame:CGRectMake(0, 960-100-207, 768, 207)];
            }else{
                ptv = [[UIPickerTitleView alloc] initWithFrame:CGRectMake(0, 280, 320, 200)];
            }
            UIDatePicker *datepicker = [[UIDatePicker alloc] init];
            datepicker.datePickerMode = UIDatePickerModeDate;
            datepicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:365*24*60*60*30];
            ptv.pickerview = (UIPickerView *)datepicker;
            [datepicker release];
            ptv.delegate = self;
            ptv.pickviewtitle = @"宝宝生日";
            [ptv showInView:self.view];
        }
    }
}

#pragma mark 点pickerview按钮上的按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIPickerTitleView *titleview = (UIPickerTitleView *)actionSheet;
    if(buttonIndex == 1) {
        NSDate *pickerbeardate = [(UIDatePicker *)titleview.pickerview date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *datestr = [formatter stringFromDate:pickerbeardate];
        [formatter release];
        NSString *beardatestr = [NSString  stringWithFormat:@"宝宝生日：%@",datestr];
        self.bearlable.text = beardatestr;
        self.beardate = datestr;
    }else{
        self.bearlable.text = @"请选择宝宝生日";
        self.beardate = @"";
    }
    self.ptv = nil;
}

#pragma mark 注册的方法
- (void)registerAccount:(id)sender
{
    [self.view endEditing:YES];
    if (![CheckHelper helperTextFieldCheckNull:self.usernamefield fieldtitle:@"用户名"]) return;
    if (![CheckHelper helperTextFieldCheckWithRegex:self.usernamefield regex:@".{4,20}" wrongmessage:@"用户名应该由4-20位字符，可由中英文、数字及“_”、“-”组成"]) {
        return;
    }
    if (![CheckHelper helperTextFieldCheckPassword:self.passwordfield verifypasswordtextfield:self.verifypasswordfield]) return;
    if (![CheckHelper helperTextFieldCheckWithRegex:self.passwordfield regex:@"^[A-Za-z0-9_-]{6,16}$" wrongmessage:@"密码应该由6-16位字符，可由英文、数字及“_”、“-”组成"]) {
        return;
    }
//    if (![CheckHelper helperTextFieldCheckNull:self.referrerfield fieldtitle:@"推荐人"]) return;
    if (![CheckHelper helperTextFieldCheckNull:self.emailfield fieldtitle:@"邮箱"]) return;
    if (![CheckHelper helperTextFieldCheckWithRegex:self.emailfield regex:@"^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$" wrongmessage:@"邮箱格式错误"]) {
        return;
    }
//    if (![CheckHelper helperTextFieldCheckEmail:self.emailfield]) return;
    
    NSMutableDictionary *regiserdict = [[NSMutableDictionary alloc] init];
    [regiserdict setValue:self.usernamefield.text forKey:@"Account"];
    [regiserdict setValue:self.passwordfield.text forKey:@"Password"];
    [regiserdict setValue:self.emailfield.text forKey:@"Email"];
    [regiserdict setValue:self.referrerfield.text forKey:@"Recommend"];
    [regiserdict setValue:self.beardate forKey:@"BabyBirthday"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_REGISTER methodName:(NSString *)SP_METHOD_REGISTER memberid:@""];
    rh.havememberid = FALSE;
      if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:regiserdict succ:@selector(registerAccountSucc:) fail:@selector(registerAccountFail:) responsedelegate:self];
    [regiserdict release];
    [rh release];
}

- (void)registerAccountSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
 
    NSString *message = [dict objectForKey:@"Message"];
    
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    
    [UIAlertView showAlertViewWithTitle:@"提示" message:message cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alert, NSInteger buttonIndex) {
        if (buttonIndex == 0) {
        
            if ([errorcode isEqualToString:@"0"]) {
                  if ([SPActionUtility isNetworkReachable])
                [self showHUD];
                NSString *username = self.usernamefield.text;
                NSString *password = self.passwordfield.text;
                NSMutableDictionary *logindict = [[NSMutableDictionary alloc] init];
                [logindict setValue:username forKey:@"Account"];
                [logindict setValue:password forKey:@"Password"];
                if ([strOrEmpty([SPDataInterface commonParam:CCS_KEY_DEVICETOKEN]) isEqualToString:@""]) {
                    NSString *l_str_token = [[NSUserDefaults standardUserDefaults] objectForKey:(NSString*)CCS_KEY_DEVICETOKEN];
                    [logindict setValue:strOrEmpty(l_str_token) forKey:@"devicetoken"];
                }else{
                    [logindict setValue:strOrEmpty([SPDataInterface commonParam:CCS_KEY_DEVICETOKEN])     forKey:@"devicetoken"];
                }
                RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_LOGIN methodName:(NSString *)SP_METHOD_LOGIN memberid:@""];
                rh.havememberid = FALSE;
                [rh RequestUrl:logindict succ:@selector(loginSucc:) fail:@selector(loginFail:) responsedelegate:self];
                [logindict release];
                [rh release];
            }

        }
    }];
   }

- (void)registerAccountFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

- (void)loginSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
     
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    if ([errorcode isEqualToString:@"0"]) {
 
        NSDictionary *infoDict = [[dict objectForKey:@"Data"] objectForKey:@"Member"];
   
        Member *memberInfo = [[Member alloc] init];
        
        memberInfo.mmemberId = [infoDict objectForKey:@"MemberId"];
        memberInfo.mlevel = [infoDict objectForKey:@"Level"];
        memberInfo.mprice = [infoDict objectForKey:@"Price"];
        memberInfo.mimageUrl = [infoDict objectForKey:@"ImageUrl"];
        memberInfo.mscores = [infoDict objectForKey:@"Scores"];
        memberInfo.maccount = [infoDict objectForKey:@"Account"];
        
        [SPDataInterface setCommonParam:SP_KEY_MEMBERID value:memberInfo.mmemberId];
        
        
        [memberInfo save];
        [memberInfo release];

         
        [Go2PageUtility dismissModalViewController];
        
        if (registerSuccessBlock) {
            registerSuccessBlock();
        }
    }
}

- (void)loginFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

@end
