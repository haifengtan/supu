//
//  ConfigSuPu.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "ConfigSuPu.h"
#import "DCRoundSwitch.h"
#import "SDWebImageManager.h"
#import "OAuthInfo.h"
@interface ConfigSuPu ()

@property (retain, nonatomic) UITableView *configtableview;
@property (retain, nonatomic) NSString *showpicture;
@property (retain, nonatomic) NSString *pushmessage;
@property BOOL isPad;

@end

@implementation ConfigSuPu
@synthesize configtableview;
@synthesize showpicture;
@synthesize pushmessage;
@synthesize isPad;

- (void)dealloc
{
    [configtableview release];
    [showpicture release];
    [pushmessage release];
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
    self.title = @"设置";
    self.UMStr = @"设置";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    if (self.isPad) {
        configtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 860) style:UITableViewStyleGrouped];
    }else{
        configtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [SPStatusUtility getScreenHeight] - kNavHeight - kTabbarHeight - 20) style:UITableViewStyleGrouped];
    }
    configtableview.delegate = self;
    configtableview.dataSource = self;
    configtableview.scrollEnabled = NO;
    [self.view addSubview:configtableview];
    

    self.showpicture = [SPStatusUtility getObjectForKey:kShowPicture];
    self.pushmessage = [SPStatusUtility getObjectForKey:KPUSHMESSAGE];
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

#pragma mark 配置源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 84;
    }else{
        return 42;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"configtableviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.isPad) {
            cell.textLabel.frame = CGRectMake(40, 26, 300, 32);
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:26]];
        }else{
            cell.textLabel.frame = CGRectMake(20, 13, 100, 16);
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:13]];
        }
        cell.textLabel.textAlignment = UITextAlignmentLeft;
        [cell.textLabel sizeToFit];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"图片缓存";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image= [UIImage imageNamed:@"登录按钮.png"];
        if (self.isPad) {
            button.frame = CGRectMake (0, 0,154,54);
            [button.titleLabel setFont:[UIFont systemFontOfSize:26]];
        }else{
            button.frame = CGRectMake (0, 0,77,27);
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        }
        [button setBackgroundImage:image forState:UIControlStateNormal ];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:@"清 空" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clearImageCaches:event:) forControlEvents:UIControlEventTouchUpInside ];
        cell.accessoryView = button;
    }else if(indexPath.row ==1){
        cell.textLabel.text = @"列表图片显示";
        DCRoundSwitch *showpictureswitch = [[DCRoundSwitch alloc] init];//自定义的switch类
      
        if ([strOrEmpty(self.showpicture) isEqualToString:@""]) {
            
            showpictureswitch.on = YES;
 
           
        }else if ([self.showpicture isEqualToString:@"ON"]) {
            showpictureswitch.on = YES;
        }else{
            showpictureswitch.on = NO;
        }
        [showpictureswitch addTarget:self action:@selector(showPictureChangeAction:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = showpictureswitch;
        [showpictureswitch release];
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"推送通知";
        DCRoundSwitch *pushmessgeswitch = [[DCRoundSwitch alloc] init];
        
        if ([strOrEmpty(self.pushmessage) isEqualToString:@""]) {
            
            pushmessgeswitch.on = YES;
             
        }else if ([self.pushmessage isEqualToString:@"ON"]) {
            pushmessgeswitch.on = YES;
        }else{
            pushmessgeswitch.on = NO;
        }
        
 
        cell.accessoryView = pushmessgeswitch;
        [pushmessgeswitch addTarget:self action:@selector(pushmessagechange:) forControlEvents:UIControlEventValueChanged];
        [pushmessgeswitch release];
    }
    return cell;
}

- (void)showPictureChangeAction:(id)sender
{
    
    DCRoundSwitch *swith = (DCRoundSwitch *)sender;
    BOOL isOpen = swith.isOn;
    
    if (isOpen)
    {
        [SPStatusUtility  setObject:@"ON" forKey:kShowPicture];
    
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }
    else
    {
        [SPStatusUtility setObject:@"OFF" forKey:kShowPicture];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
}

- (void)pushmessagechange:(id)sender
{
    DCRoundSwitch *ds = (DCRoundSwitch *)sender;
    BOOL isSet = ds.isOn;
 
    if (isSet)
    {
        [SPStatusUtility setObject:@"ON" forKey:KPUSHMESSAGE];
    }
    else
    {
        [SPStatusUtility setObject:@"OFF" forKey:KPUSHMESSAGE];
    }
 
}

- (void)clearImageCaches:(id)sender event:(id)event
{
    //在这里写上清楚缓存的操作
  
    [OAuthInfo logout];
    [SPStatusUtility clearAllImgCache];
//    logout
//    [SPStatusUtility showAlert:nil message:@"您确定要清空缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        
    }else{
        //在这里写上清楚缓存的操作
        [SPStatusUtility clearAllImgCache];
    }
}
@end
