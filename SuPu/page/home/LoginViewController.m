//
//  LoginViewController.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-28.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestHelper.h"
#import "RegisterViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "CheckHelper.h"
#import "Member.h"
#import "SPAppDelegate.h"
#import "NSString+Category.h"
#import "UIDevice+IdentifierAddition.h"

@interface LoginViewController ()

@property (retain, nonatomic) UITextField *usernamefield;
@property (retain, nonatomic) UITextField *passwordfield;
@property BOOL isPad;

@end

@implementation LoginViewController
@synthesize usernamefield;
@synthesize passwordfield;
@synthesize LoginSuccessBlock = LoginSuccessBlock_;
@synthesize isPad;

- (void)dealloc
{
    OUOSafeRelease(LoginSuccessBlock_);
    [usernamefield release];
    [passwordfield release];
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
    self.title = @"用户登录";
    self.UMStr= @"用户登录";
    
    __block typeof(self) bself = self;
    //根据LoginView出现的位置是商城首页还是在会员中心，来决定返回按钮的功能
    if (KAppDelegate.loginModelViewMotherViewName!= nil && ([KAppDelegate.loginModelViewMotherViewName isEqualToString:@"SPPersonal"]||[KAppDelegate.loginModelViewMotherViewName isEqualToString:@"SPShoppingCart"])) {
        [self setLeftBarButtonWithTitle:@"返回" handler:^(id sender) {
            [Go2PageUtility dismissModalViewController];
            [KAppDelegate.m_tabBarCtrl selectTab:0];
        }];
    }
    if (KAppDelegate.loginModelViewMotherViewName!= nil && ([KAppDelegate.loginModelViewMotherViewName isEqualToString:@"SPHome"]||[KAppDelegate.loginModelViewMotherViewName isEqualToString:@"SPProductDetail"])) {
        [self setLeftBarButtonWithTitle:@"返回" handler:^(id sender) {
            [Go2PageUtility dismissModalViewController];
        }];
    }
    
    [self setRightBarButtonWithTitle:@"注册" handler:^(id sender) {
        [bself toRegisterPage:nil];
    }];
    
    TPKeyboardAvoidingTableView *loginview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    loginview.delegate = self;
    loginview.dataSource = self;
    loginview.scrollEnabled = NO;
    [self.view addSubview:loginview];
    [loginview release];
    
    UIButton *loginbtn = nil;
    if (self.isPad) {
        loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(184, 240, 400, 72)];
        [loginbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    }else{
        loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 110, 200, 36)];
        [loginbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    UIImage *btnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"登录按钮" ofType:@"png"]];
    [loginbtn setBackgroundImage:btnimage forState:UIControlStateNormal];
    [loginbtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    [loginbtn release];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 90;
    }else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellidentify = @"loginviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            UILabel *usernamelabel = nil;
            if (self.isPad) {
                usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 30, 110, 30)];
                [usernamelabel setFont:[UIFont boldSystemFontOfSize:24]];
                usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(146, 0, 510, 90)];
                [usernamefield setFont:[UIFont systemFontOfSize:24]];
            }else{
                usernamelabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 55, 15)];
                [usernamelabel setFont:[UIFont boldSystemFontOfSize:13]];
                usernamefield = [[UITextField alloc] initWithFrame:CGRectMake(73, 0, 255, 45)];
                [usernamefield setFont:[UIFont systemFontOfSize:13]];
            }
            usernamelabel.text = @"用户名：";
            usernamelabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:usernamelabel];
            [usernamelabel release];
            
            usernamefield.placeholder = @"请输入您的用户名";
            usernamefield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            usernamefield.delegate = self;
            usernamefield.returnKeyType = UIReturnKeyDone;
            usernamefield.autocapitalizationType = NO;
            [cell.contentView addSubview:usernamefield];
        }
        if (indexPath.row == 1) {
            UILabel *passwordlabel = nil;
            if(self.isPad){
                passwordlabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 30, 110, 30)];
                [passwordlabel setFont:[UIFont boldSystemFontOfSize:24]];
                passwordfield = [[UITextField alloc] initWithFrame:CGRectMake(146, 0, 510, 90)];
                [passwordfield setFont:[UIFont systemFontOfSize:24]];
            }else{
                passwordlabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 55, 15)];
                [passwordlabel setFont:[UIFont boldSystemFontOfSize:13]];
                passwordfield = [[UITextField alloc] initWithFrame:CGRectMake(73, 0, 255, 45)];
                [passwordfield setFont:[UIFont systemFontOfSize:13]];
            }
            
            passwordlabel.text = @"密码：";
            passwordlabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:passwordlabel];
            [passwordlabel release];
            
            passwordfield.placeholder = @"请输入您的密码";
            passwordfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            passwordfield.secureTextEntry = YES;
            passwordfield.delegate = self;
            passwordfield.returnKeyType = UIReturnKeyDone;
            passwordfield.autocapitalizationType = NO;
            [cell.contentView addSubview:passwordfield];
        }
    }
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)toRegisterPage:(id)sender
{
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    rvc.registerSuccessBlock = LoginSuccessBlock_;
    [self.navigationController pushViewController:rvc animated:YES];
    [rvc release];
}

//这里我为了实验，用的是我自己写的请求的ASIHTTPREQUEST，今后想修正的请修正。
- (void)login:(id)sender
{
    [self.view endEditing:YES];
    if (![CheckHelper helperTextFieldCheckNull:self.usernamefield fieldtitle:@"用户名"]) return;
    if (![CheckHelper helperTextFieldCheckNull:self.usernamefield fieldtitle:@"密码"]) return;
    
    NSString *username = [CCSStringUtility stripWhiteSpace:self.usernamefield.text];
    NSString *password = [CCSStringUtility stripWhiteSpace:self.passwordfield.text];
    NSMutableDictionary *logindict = [[NSMutableDictionary alloc] init];
 
 
    [logindict setValue:username  forKey:@"Account"];
    
    if ([SPStatusUtility isUserLogin]) {//假如登陆过
        if ([strOrEmpty([SPDataInterface commonParam:CCS_KEY_DEVICETOKEN]) isEqualToString:@""]) {
            NSString *l_str_token = [[NSUserDefaults standardUserDefaults] objectForKey:(NSString*)CCS_KEY_DEVICETOKEN];
            [logindict setValue:strOrEmpty(l_str_token) forKey:@"devicetoken"];
        }else{
            [logindict setValue:strOrEmpty([SPDataInterface commonParam:CCS_KEY_DEVICETOKEN])     forKey:@"devicetoken"];
        }
    }
 
    [logindict setValue:password forKey:@"Password"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_LOGIN methodName:(NSString *)SP_METHOD_LOGIN memberid:@""];
    
    if (logindict!=nil) {
        NSLog(@"URL:%@\nPostParams: %@",SP_URL_LOGIN,logindict);
    }
    
    rh.havememberid = FALSE;
    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:logindict succ:@selector(loginSucc:) fail:@selector(loginFail:) responsedelegate:self];
    [logindict release];
    [rh release];
    
}
#pragma mark  SPDeviceActionDelegate
-(NSDictionary *)onRequestDeviceAction{
    
    return [[[NSDictionary alloc]initWithObjectsAndKeys:[[UIDevice currentDevice] uniqueDeviceIdentifier] ,@"DeviceToken",nil] autorelease];
}

-(void)onResponseDeviceDataSuccess:(SPDeviceObject *)device_object{
    //用时再取
}

-(void)onResponseDeviceDataFail{

}



- (void)loginSucc:(ASIFormDataRequest *)request
{
    
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *message = [dict objectForKey:@"Message"];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
 
    if ([errorcode isEqualToString:@"0"]) {
           [self hideHUDWithCompletionMessage:message];
        
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
        
        if (LoginSuccessBlock_) {
            LoginSuccessBlock_();
        }
    }else{
        [self hideHUDWithFailedMessage:message];
    }
    
//    SPDeviceAction *device = [[[SPDeviceAction alloc] init] autorelease];
//    device.m_delegate_orderList = self;
//    [device requestPersonalInfomationData];
}

- (void)loginFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

@end


