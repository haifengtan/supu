//
//  SuggestionToSuPu.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SuggestionToSuPu.h"
#import <QuartzCore/QuartzCore.h>
#import "UIPlaceHolderTextView.h"
#import "SPStatusUtility.h"
#import "CheckHelper.h"
#import "RequestHelper.h"

@interface SuggestionToSuPu ()

@property (retain, nonatomic) UIButton *telephonebtn;
@property (retain, nonatomic) UIButton *submitbtn;
@property (retain, nonatomic) UIPlaceHolderTextView *suggestview;
@property BOOL isPad;

@end

@implementation SuggestionToSuPu
@synthesize telephonebtn;
@synthesize submitbtn;
@synthesize suggestview;
@synthesize isPad;

- (void)dealloc
{
    [telephonebtn release];
    [submitbtn release];
    [suggestview release];
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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"意见反馈";
    self.UMStr = @"意见反馈";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    UIButton *closekeyborderbtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    closekeyborderbtn.backgroundColor = [UIColor clearColor];
    [closekeyborderbtn addTarget:self action:@selector(closeKeyBoard:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:closekeyborderbtn];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:backgroundview];
    [backgroundview release];
    
    UILabel *titlemessage = nil;
    if (self.isPad) {
        titlemessage = [[UILabel alloc] initWithFrame:CGRectMake(104, 70, 560, 80)];
        titlemessage.font = [UIFont boldSystemFontOfSize:28];
        suggestview = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(44, 160, 680, 300)];
        suggestview.placeholderfont = [UIFont systemFontOfSize:24];
      
        submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(284, 490, 200, 50)];
        [submitbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
        telephonebtn = [[UIButton alloc] initWithFrame:CGRectMake(234, 640, 300, 50)];
    }else{
        titlemessage = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 280, 40)];
        titlemessage.font = [UIFont boldSystemFontOfSize:14];
        suggestview = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(10, titlemessage.frameHeight + titlemessage.frameY + 10, 300, [SPStatusUtility getScreenHeight] - 20 - kNavHeight - kTabbarHeight - titlemessage.frameHeight - titlemessage.frameY - 150)];
        suggestview.placeholderfont = [UIFont systemFontOfSize:12];
        submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(110, suggestview.frameY + suggestview.frameHeight + 20, 100, 25)];
        [submitbtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        telephonebtn = [[UIButton alloc] initWithFrame:CGRectMake(82, submitbtn.frameY + submitbtn.frameHeight + 10, 150, 25)];
    }

    titlemessage.backgroundColor = [UIColor clearColor];
    titlemessage.numberOfLines = 0;
    titlemessage.lineBreakMode = UILineBreakModeWordWrap;
    titlemessage.text = @"  精彩源于体验，改善源于分享。我们还年轻，期待倾听您的声音";
    [self.view addSubview:titlemessage];
    [titlemessage release];
    
    suggestview.layer.cornerRadius = 10;//调节圆角的大小，数值越大，圆角的拐弯越大
    suggestview.layer.masksToBounds = YES;
    suggestview.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
    suggestview.layer.borderWidth = 1;
    suggestview.placeholder = @"请填写你的意见";
    suggestview.font = [UIFont systemFontOfSize:18.0];
    suggestview.placeholderColor = [UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00];
    [self.view addSubview:suggestview];
    
    UIImage *btnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"登录按钮" ofType:@"png"]];
    [submitbtn setBackgroundImage:btnimage forState:UIControlStateNormal];
    [submitbtn setTitle:@"提  交" forState:UIControlStateNormal];
    [submitbtn addTarget:self action:@selector(suggest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];
    
    UIImage *telephonebtnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"400电话按钮" ofType:@"png"]];
    [telephonebtn setBackgroundImage:telephonebtnimage forState:UIControlStateNormal];
    [telephonebtn addTarget:self action:@selector(tele:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telephonebtn];
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

- (void)closeKeyBoard:(id)sender
{
    [suggestview resignFirstResponder]; 
}

#pragma mark 打电话
- (void)tele:(id)sender
{
    [SPStatusUtility makeCall:CCS_400PHONE_NUMBER];
}

#pragma mark 提交建议
- (void)suggest:(id)sender
{
    [self.view endEditing:YES];
    if (![CheckHelper helperTextViewCheckNull:self.suggestview viewtitle:@"建议"]) return;
    
    NSMutableDictionary *suggestdict = [[NSMutableDictionary alloc] init];
    [suggestdict setValue:self.suggestview.text forKey:@"content"];
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_POSTFEEDBACK methodName:(NSString *)SP_METHOD_POSTFEEDBACK memberid:nil];
    rh.havememberid = FALSE;
    [self showHUD];
    [rh RequestUrl:suggestdict succ:@selector(suggestSucc:) fail:@selector(suggestFail:) responsedelegate:self];
    [suggestdict release];
    [rh release];
}

- (void)suggestSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *message = [dict objectForKey:@"Message"];
//    [UIViewHealper helperBasicUIAlertView:@"提示" message:message];
    self.suggestview.text = nil;
    
    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)suggestFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

@end
