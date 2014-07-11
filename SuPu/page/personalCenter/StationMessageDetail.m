//
//  StationMessageDetail.m
//  SuPu
//
//  Created by cc on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "StationMessageDetail.h"
#import <QuartzCore/QuartzCore.h>

@interface StationMessageDetail ()

@property BOOL isPad;

@end

@implementation StationMessageDetail
@synthesize messagecontent;
@synthesize isPad;

- (void)dealloc
{
    [messagecontent release];
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
    self.title = @"消息详情";
    self.UMStr = @"消息详情";
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *messageview = nil;
    if (self.isPad) {
        messageview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 860)];
    }else{
        messageview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frameHeight - kNavHeight - kTabbarHeight)];
    }
 
    messageview.layer.masksToBounds = YES;
 
    messageview.delegate = self;
    messageview.backgroundColor = [UIColor whiteColor];
    [messageview loadHTMLString:self.messagecontent baseURL:nil];
    [self.view addSubview:messageview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[[request URL] retain];
    NSString *requestschemestr= [requestURL scheme];
    if ((navigationType == UIWebViewNavigationTypeLinkClicked)&&
        ([requestschemestr isEqualToString:@"mailto"]||
         [requestschemestr isEqualToString:@"https"]||
         [requestschemestr isEqualToString:@"http"]))
    {
        return ![[UIApplication sharedApplication] openURL:[requestURL autorelease]];
    }
    [requestURL release];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
