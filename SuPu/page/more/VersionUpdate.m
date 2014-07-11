//
//  VersionUpdate.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-29.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "VersionUpdate.h"
#import "RequestHelper.h"
#import "UIViewHealper.h"
#import "SVPullToRefresh.h"
#import "SPActionUtility.h"
@interface VersionUpdate ()

@property (retain, nonatomic) UILabel *nowversionlabel;
@property (retain, nonatomic) UILabel *newversionlabel;
@property (retain, nonatomic) UIButton *updatebtn;


@property (retain, nonatomic) NSString *mandatoryUpdate;//强制
@property (retain, nonatomic) NSString *updateUrl;
@property BOOL isPad;

@end

@implementation VersionUpdate
@synthesize nowversionlabel;
@synthesize newversionlabel;
@synthesize updatebtn;
@synthesize isPad;
@synthesize mandatoryUpdate;
@synthesize updateUrl;
- (void)dealloc
{
    [nowversionlabel release];
    [newversionlabel release];
    [updatebtn release];
    [mandatoryUpdate release];
    [updateUrl release];
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
    self.title = @"检查更新";
    self.UMStr = @"检查更新";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:backgroundview];
    [backgroundview release];
    
    UIImageView *logoview= nil;
    if (self.isPad) {
        logoview = [[UIImageView alloc] initWithFrame:CGRectMake(234, 120, 300, 100)];
        nowversionlabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 300, 520, 34)];
        [nowversionlabel setFont:[UIFont boldSystemFontOfSize:28]];
        newversionlabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 340, 520, 34)];
        [newversionlabel setFont:[UIFont boldSystemFontOfSize:28]];
        updatebtn = [[UIButton alloc] initWithFrame:CGRectMake(284, 500, 200, 50)];
        [updatebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:32]];
    }else{
        logoview = [[UIImageView alloc] initWithFrame:CGRectMake(85, 60, 150, 50)];
        nowversionlabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 260, 17)];
        [nowversionlabel setFont:[UIFont boldSystemFontOfSize:14]];
        newversionlabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 260, 17)];
        [newversionlabel setFont:[UIFont boldSystemFontOfSize:14]];
        updatebtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 250, 100, 25)];
        [updatebtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    logoview.image = [UIImage imageNamed:@"普速logo.png"];
    [self.view addSubview:logoview];
    [logoview release];
    
    nowversionlabel.textAlignment = UITextAlignmentCenter;
    nowversionlabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nowversionlabel];
    
    newversionlabel.textAlignment = UITextAlignmentCenter;
    newversionlabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:newversionlabel];
    
    UIImage *btnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"登录按钮" ofType:@"png"]];
    [updatebtn setBackgroundImage:btnimage forState:UIControlStateNormal];
    [updatebtn setTitle:@"更  新" forState:UIControlStateNormal];
    [updatebtn addTarget:self action:@selector(updateversion:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updatebtn];
    
    [self versionSelect];
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

#pragma mark 查询最新版本
- (void)versionSelect
{
    RequestHelper *rh = [[RequestHelper alloc] initWithUrl:(NSString *)SP_URL_UPDATE methodName:(NSString *)SP_METHOD_UPDATE memberid:nil];
    rh.havememberid = FALSE;
    if ([SPActionUtility isNetworkReachable])
    [self showHUD];
    [rh RequestUrl:nil succ:@selector(versionSelectSucc:) fail:@selector(versionSelectFail:) responsedelegate:self];
    [rh release];
}

- (void)versionSelectSucc:(ASIFormDataRequest *)request
{
    [self hideHUD];
    
    NSMutableDictionary *dict = [request.responseString objectFromJSONString];
    if ([[dict objectForKey:@"ErrorCode"] isEqual:@"1"]) {//需要更新
        NSString *VersionNo = [[dict objectForKey:@"Data"] objectForKey:@"VersionNo"];
        NSString *VersionInfo = [[dict objectForKey:@"Data"] objectForKey:@"VersionInfo"];
        NSString *message = [dict objectForKey:@"Message"];
        NSString *forceupdate = [[dict objectForKey:@"Data"] objectForKey:@"ForceUpdate"];
        self.updateUrl = [[dict objectForKey:@"Data"] objectForKey:@"DownloadUrl"];
        self.mandatoryUpdate = forceupdate;
        if (forceupdate!= nil && [forceupdate isEqualToString:@"True"]) {
            //强制升级
			UIAlertView* _alertView = [[UIAlertView alloc] initWithTitle:@"版本更新内容" message:message delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
			_alertView.tag = 444;
            [_alertView show];
            [_alertView release];
        }else{
            //非强制升级
			UIAlertView* _alertView = [[UIAlertView alloc] initWithTitle:@"版本更新内容" message:message delegate:self cancelButtonTitle:@"暂不升级" otherButtonTitles:@"更新", nil];
			_alertView.tag = 888;
            [_alertView show];
            [_alertView release];
        }
        NSString *curVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
 
        self.nowversionlabel.text = [NSString stringWithFormat:@"当前版本:速普商城%@%@",VersionInfo,curVer];;
        self.newversionlabel.text = [NSString stringWithFormat:@"最新版本:速普商城%@%@",VersionInfo,VersionNo];
    }else{
        self.nowversionlabel.text = @"已是最新版本";
        updatebtn.hidden =YES;
    }
}

- (void)versionSelectFail:(ASIFormDataRequest *)request
{
    [self hideHUD];
    [UIViewHealper helperBasicASIFailUIAlertView];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     DLog(@"--------button index ------- %d",buttonIndex);
    if (alertView.tag == 444) {
        //强制更新
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
    }
    if (alertView.tag == 888 ) {
        
        DLog(@"--------button index ------- %d",buttonIndex);
        if (buttonIndex == 0) {
            return ;
        }
        else if (buttonIndex == 1){
                    //自愿更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
        }


    }
}

#pragma mark 手动更新版本
- (void)updateversion:(id)sender
{
    if (self.mandatoryUpdate!= nil && [self.mandatoryUpdate isEqualToString:@"True"]) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
    }else{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
    }
}

@end
