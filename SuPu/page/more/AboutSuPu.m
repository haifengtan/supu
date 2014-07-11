//
//  AboutSuPu.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "AboutSuPu.h"
#import "RequestHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "SPStatusUtility.h"
#import "SPConfig.h"
#import "SPActionUtility.h"
@interface AboutSuPu ()

@property (retain, nonatomic) UITextView *supumessageview;
@property (retain, nonatomic) UIButton *telephonebtn;
@property BOOL isPad;

@property (retain, nonatomic) UIWebView *webView;
@end

@implementation AboutSuPu
@synthesize supumessageview;
@synthesize telephonebtn;
@synthesize isPad;
@synthesize webView;
- (void)dealloc
{
    [supumessageview release];
    [webView release];
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
    self.title = @"关于我们";
    self.UMStr = @"关于我们";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
        self.view.frameHeight = [SPStatusUtility getScreenHeight]-20 - kNavHeight - kTabbarHeight;
    UIScrollView *uisc = nil;
    first = 0;
    if (self.isPad) {
        uisc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, self.view.bounds.size.height-30)];
        uisc.contentSize = CGSizeMake(768, 860);
    }else{
        uisc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, [SPStatusUtility getScreenHeight]-20 - kNavHeight - kTabbarHeight )];
        uisc.contentSize = CGSizeMake(320, [SPStatusUtility getScreenHeight]- 30);
    }
    uisc.scrollEnabled = NO;
    [self.view addSubview:uisc];

    //内存警告3-------------------------------
    [uisc release];
    uisc.backgroundColor = [UIColor clearColor];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    [uisc addSubview:backgroundview];
    [backgroundview release];
    
    webView = [[UIWebView alloc] init];
    [uisc addSubview:webView];
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.layer.cornerRadius = 10;
    webView.layer.masksToBounds = YES;
    webView.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
    webView.layer.borderWidth = 1;

 
    
    telephonebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *telephonebtnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"400电话按钮" ofType:@"png"]];
//    [telephonebtn setBackgroundColor:[UIColor clearColor]];
    [telephonebtn setBackgroundImage:telephonebtnimage forState:UIControlStateNormal];
    [telephonebtn addTarget:self action:@selector(tele:) forControlEvents:UIControlEventTouchUpInside];
    [uisc addSubview:telephonebtn];
//    [telephonebtn release];
    
    [self aboutSuPuSelect];
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
#pragma mark  uiwebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    first ++;
    if (first !=1) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }

    return  YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
   
}
#pragma mark 查询列表的方法
- (void)aboutSuPuSelect
{
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_GETABOUTUS methodName:(NSString *)SP_METHOD_GETABOUTUS memberid:@""];
    rh.havememberid = FALSE;
    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:nil succ:@selector(aboutSuPuSelectSucc:) fail:@selector(aboutSuPuSelectFail:) responsedelegate:self];
    [rh release];
}

- (void)aboutSuPuSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    NSString *errorcode = [dict objectForKey:@"ErrorCode"];
    if ([errorcode isEqualToString:@"0"]) {
        NSString *supumessage = [dict objectForKey:@"Data"];
        
        if (self.isPad) {
 
            [webView loadHTMLString:supumessage baseURL:nil];
            webView.frame = CGRectMake(44, 40, 680, 690);
 
            telephonebtn.frame = CGRectMake(234,770, 300, 50);
        }else{
 
            [webView loadHTMLString:supumessage baseURL:nil];
            webView.frame = CGRectMake(10, 20, 300,  self.view.frameHeight - 80);
 
            telephonebtn.frame = CGRectMake(80, webView.frameY + webView.frameHeight +  25, 150, 25);
 
        }
    }
    
}

- (void)aboutSuPuSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
}

#pragma mark 打电话
- (void)tele:(id)sender
{
    [SPStatusUtility makeCall:CCS_400PHONE_NUMBER];
}

@end
