//
//  SPClassifyGoodsDescrption.m
//  SuPu
//
//  Created by cc on 12-11-8.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPClassifyGoodsDescrption.h"
#import <QuartzCore/QuartzCore.h>

@interface SPClassifyGoodsDescrption ()

@property (retain, nonatomic) UIWebView *descriptionwebview;
@property BOOL isPad;

@end

@implementation SPClassifyGoodsDescrption
@synthesize goodssn;
@synthesize descriptionwebview;
@synthesize isPad;

- (void)dealloc
{
    [goodssn release];
    [descriptionwebview release];
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
    
    self.title = @"商品描述";
    self.UMStr = @"商品描述";
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    if (isPad) {
        descriptionwebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 854+10)];
    }else{
        descriptionwebview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [SPStatusUtility getScreenHeight] - kTabbarHeight - kNavHeight - 20)];
    }
//    descriptionwebview.layer.cornerRadius = 10;
//    descriptionwebview.layer.masksToBounds = YES;
//    descriptionwebview.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
//    descriptionwebview.layer.borderWidth = 1;
    descriptionwebview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景_iPad.jpg"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景_iPad.jpg"]];
    [self.view addSubview:descriptionwebview];
    
    SPClassifyGoodsDescriprionAction *gdaction = [[SPClassifyGoodsDescriprionAction alloc] init];
    gdaction.delegate = self;
    [self showHUD];
    [gdaction requestData];
    [gdaction release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 请求数据
- (NSDictionary *)createGoodsDescriptionASIRequestPara
{
    return [NSDictionary dictionaryWithObjectsAndKeys:goodssn,@"GoodsSN", nil];
}

- (void)responseGoodsDescriptionDataToViewSuccess:(NSDictionary *)result
{
    [descriptionwebview loadHTMLString:[[result objectForKey:@"Data"] objectForKey:@"Note"] baseURL:nil];
    [self hideHUD];
}

- (void)responseGoodsDescriptionDataToViewFail
{
    [self hideHUD];
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];

    
}

@end
