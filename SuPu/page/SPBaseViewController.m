//
//  SPBaseViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "Member.h"
#import "OUOMacros.h"

@implementation SPBaseViewController
@synthesize entryArray=_entryArray;
@synthesize emptyView = _emptyView;
@synthesize m_str_noresultText;
@synthesize UMStr;

@synthesize emptyMessage = _emptyMessage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
#endif
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    self.entryArray=array;
    [array release];
    
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮" target:self action:nil];
        }
    }
    
         
}


-(UIView *)emptyView{
    if (_emptyView==nil) {
        _emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        _emptyView.backgroundColor = [UIColor whiteColor];
  
        UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frameWidth, 40)];
        msgLabel.center = self.view.center;
        msgLabel.text = [strOrEmpty(self.m_str_noresultText) isEqualToString:@""]?@"数据为空":self.m_str_noresultText;

        msgLabel.textAlignment = UITextAlignmentCenter;
        msgLabel.backgroundColor = [UIColor clearColor];
        msgLabel.textColor = [UIColor lightGrayColor];
        if (iPad) {
            msgLabel.font = OUO_FONT(18);
        }else{
            msgLabel.font = OUO_FONT(16);
        }
        
        [_emptyView addSubview:msgLabel];
        [msgLabel release];
         
    }
    return _emptyView;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)setLeftBarButton:(NSString *)title backgroundimagename:(NSString *)backgroundimagename target:(id)target action:(SEL)action
{
    CGSize titlesize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setExclusiveTouch:YES];
    backbutton.frame = CGRectMake(0, 0, titlesize.width+20, 30);
    [backbutton setBackgroundImage:[UIImage imageNamed:backgroundimagename] forState:UIControlStateNormal];
    [backbutton setBackgroundImage:[UIImage imageNamed:OUO_STRING_FORMAT(@"%@-按下", backgroundimagename)] forState:UIControlStateHighlighted];
    [backbutton setTitle:title forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backbutton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    if (action == nil) {
        [backbutton addTarget:target action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [backbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *backbtnitem = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    self.navigationItem.leftBarButtonItem = backbtnitem;
    [backbtnitem release];
}

- (void)popView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRightBarButton:(NSString *)title backgroundimagename:(NSString *)backgroundimagename target:(id)target action:(SEL)action
{
    CGSize titlesize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setExclusiveTouch:YES];
    rightbutton.frame = CGRectMake(0,0,titlesize.width+20,30);
    [rightbutton setBackgroundImage:[UIImage imageNamed:backgroundimagename] forState:UIControlStateNormal];
    [rightbutton setTitle:title forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightbutton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [rightbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbtnitem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightbtnitem;
    [rightbtnitem release];
}

- (void)setLeftBarButtonWithTitle:(NSString *)title handler:(void(^)(id sender))handler {
    CGSize titlesize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,titlesize.width+20,30);
    UIImage *bgImageNormal = [OUO_IMAGE(@"顶部登录按钮") stretchableImageWithLeftCapWidth:4. topCapHeight:0.];
    UIImage *bgImagePressed = [OUO_IMAGE(@"顶部登录按钮-0按下") stretchableImageWithLeftCapWidth:4. topCapHeight:0.];
    [button setBackgroundImage:bgImageNormal forState:UIControlStateNormal];
    [button setBackgroundImage:bgImagePressed forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [button addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = buttonItem;
    [buttonItem release];
}

- (void)setRightBarButtonWithTitle:(NSString *)title handler:(void(^)(id sender))handler {
    CGSize titlesize = [title sizeWithFont:[UIFont systemFontOfSize:13]];
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0,0,titlesize.width+20,30);
    UIImage *bgImageNormal = [OUO_IMAGE(@"顶部登录按钮") stretchableImageWithLeftCapWidth:4. topCapHeight:0.];
    UIImage *bgImagePressed = [OUO_IMAGE(@"顶部登录按钮-0按下") stretchableImageWithLeftCapWidth:4. topCapHeight:0.];
    [rightbutton setBackgroundImage:bgImageNormal forState:UIControlStateNormal];
    [rightbutton setBackgroundImage:bgImagePressed forState:UIControlStateHighlighted];
    [rightbutton setTitle:title forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightbutton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [rightbutton addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbtnitem = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightbtnitem;
    [rightbtnitem release];
}

- (NSString *)getMemberId:(NSString *)key
{ 
    return [SPDataInterface commonParam:SP_KEY_MEMBERID];
}

- (void)setTitle:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 27)];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = title;
    titlelabel.textAlignment = UITextAlignmentCenter;
    [titlelabel setFont:[UIFont boldSystemFontOfSize:18]];
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 27)];
    [view addSubview:titlelabel];
    [titlelabel release];
    self.navigationItem.titleView = view;
    [view release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     
    if (![strOrEmpty(self.UMStr) isEqualToString:@""]) {
        [MobClick beginLogPageView:self.UMStr];
    }
    
}

///////////////////////////////////友盟统计/////////////////////////////////////////

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (![strOrEmpty(self.UMStr) isEqualToString:@""]) {
        [MobClick endLogPageView:self.UMStr];
    }
}

-(void)dealloc{
    [_entryArray release];
    [super dealloc];
}
@end
