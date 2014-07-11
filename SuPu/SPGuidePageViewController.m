//
//  SPGuidePageViewController.m
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import "SPGuidePageViewController.h"
#import "SPGuidePageObject.h"
#import "CustomPageControl.h"
#import "RequestHelper.h"
#define kShowGuiPageTime 0.5

@interface SPGuidePageViewController ()
@property (nonatomic,retain) SPGuidePageAction *guidePageAction;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) CustomPageControl *pageControl;
@property int totalPage;

@property (nonatomic,retain) NSString *downloadUrl;

-(void)removeGuideImageData;
@end

@implementation SPGuidePageViewController
@synthesize guidePageAction;
@synthesize scrollView;
@synthesize pageControl;
@synthesize totalPage;
@synthesize m_delegate;
@synthesize downloadUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark 查询最新版本
- (void)versionSelect
{
    versionUpdateAction = [[SPVersionUpdateAction alloc] init];
    versionUpdateAction.m_delegate_version = self;
    [versionUpdateAction requestVersionUpdate];
    
}
-(NSDictionary*)onRequestVersionUpdateAction{
    return nil;
}
-(void)onResponseVersionUpdateSuccess:(NSDictionary *)dict{
    
    DLog(@"dict------版本更新---- %@",dict);
    
    NSString *erorstring =  [dict objectForKey:@"ErrorCode"];
    if ([erorstring isEqualToString:@"1"]) {//需要更新
        
        NSString *message         = [dict objectForKey:@"Message"];
        NSDictionary *result_dict = [dict objectForKey:@"Data"];
        NSString *forceupdate     = [result_dict objectForKey:@"ForceUpdate"];
        self.downloadUrl          = [result_dict objectForKey:@"DownloadUrl"];
        
        if (forceupdate!= nil && [forceupdate isEqualToString:@"True"]) {
            //强制升级
			UIAlertView* _alertView = [[UIAlertView alloc] initWithTitle:@"版本更新内容" message:message delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
			_alertView.tag = 1000;
            [_alertView show];
            [_alertView release];
        }else{
            //非强制升级
			UIAlertView* _alertView = [[UIAlertView alloc] initWithTitle:@"版本更新内容" message:message delegate:self cancelButtonTitle:@"暂不升级" otherButtonTitles:@"更新", nil];
			_alertView.tag = 1001;
            [_alertView show];
            [_alertView release];
        }
    }
    
    [self downloadData];
    
}
-(void)onResponseVersionUpdateFail{
    if ([(UIViewController*)m_delegate respondsToSelector:@selector(guideComplete)]) {
        [(UIViewController *)m_delegate performSelector:@selector(guideComplete) withObject:nil afterDelay:kShowGuiPageTime];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    if (alertView.tag == 1000) {
        //强制更新
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downloadUrl]];
        exit(0);
    }
    if (alertView.tag == 1001 ) {
        if (buttonIndex == 0)
        {
            return;
        }
        else if (buttonIndex == 1)
        {
            //自愿更新
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downloadUrl]];

            exit(0);
        }
        

    }
 
}


#pragma mark  =====SPGuidePageActionDelegate
-(NSDictionary *)onRequestGuidePageAction{
    
    return  nil;
}
-(void)onResponseGuidePageDataSuccess:(SPPage *)device_object{
    NSMutableArray *temp = device_object.m_pageArray;
    
    
    if ([(UIViewController*)m_delegate respondsToSelector:@selector(guideComplete)]) {
        [(UIViewController *)m_delegate performSelector:@selector(guideComplete) withObject:nil afterDelay:kShowGuiPageTime];
    }
    if ([temp count]>0) {//有引导页
        SPGuidePageObject *guide = (SPGuidePageObject *)[temp objectAtIndex:0];
        if (guide.m_PicUrl) {
            [self performSelector:@selector(wirteImageToDocument:) withObject:guide.m_PicUrl];
 
        }
   
    }else{//没有引导页
        [self removeGuideImageData];
    }
    
    
    
}
-(void)onResponseGuidePageDataFail{
    if ([(UIViewController*)m_delegate respondsToSelector:@selector(guideComplete)]) {
        [(UIViewController *)m_delegate performSelector:@selector(guideComplete) withObject:nil afterDelay:kShowGuiPageTime];
    }
}


-(BOOL)outTime:(NSString *)etime beginTime:(NSString *)beTime{
    double entime = [etime doubleValue];
    double bTime  = [beTime doubleValue];
    
    NSDate *datenow = [NSDate date];
    double ctime = [datenow timeIntervalSince1970];
    
    if (ctime>entime||ctime<bTime) {
        return NO;
    }else{
        return YES;
    }
}

-(void)createScrollImage:(NSMutableArray *)dataArray{
    float width = 0.0f;
    float height = 0.0f;
    if (iPad) {
        width = 768;
        height = 1004;
    }else{
        width = 320;
        height =self.view.frameHeight;
        
    }
    
    NSLog(@"--------------height--------%f",height);
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)] autorelease];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentOffset = CGPointMake(0.0,0.0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView .contentSize = CGSizeMake(width*totalPage, height);
    int i = 0;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0+width*i, 0, width, height)];
    
    if ([self fileExists]) {
        [imageview setImage:[UIImage imageWithContentsOfFile:[self imagePath]]];
    }
         
    [self.scrollView addSubview:imageview];
    [imageview  release];
    
    [self.view addSubview:self.scrollView];
    
    
    
}


-(BOOL)fileExists{
    NSFileManager *file = [NSFileManager defaultManager];
    return [file fileExistsAtPath:[self imagePath]];
}

-(NSString *)imagePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"default-guide.png"];
    return filePath;
}

-(void)wirteImageToDocument:(NSString *)urlString{
    NSString *imagePath = [self imagePath];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    [data writeToFile:imagePath atomically:YES];
}

-(void)removeGuideImageData{
    if ([self fileExists]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self imagePath] error:nil];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = fabs(self.scrollView.contentOffset.x) / self.scrollView.frame.size.width;
    pageControl.currentPage = index;
    if (totalPage-1 == index) {
        if ([(UIViewController*)m_delegate respondsToSelector:@selector(guideComplete)]) {
            [(UIViewController *)m_delegate performSelector:@selector(guideComplete) withObject:nil afterDelay:kShowGuiPageTime];
        }
    }
}


-(void)downloadData{
    guidePageAction = [[SPGuidePageAction alloc] init];
    guidePageAction.m_delegate_orderList = self;
    [guidePageAction requestGuidePageData];
    
    [self createScrollImage:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bg = nil;
    
    if (iPad) {
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)];
        [bg setImage:[UIImage imageNamed:@"Default-Portrait~ipad.png"]];
    }else{
     
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 320, self.view.frameHeight + 20)];
        if (isOS5()) {
            [bg setImage:[UIImage imageNamed:@"Default-568h.png"]];
        }else{
            [bg setImage:[UIImage imageNamed:@"Default.png"]];            
        }

        
    }
    
    [self.view addSubview:bg];
    [bg release];
    
    [self versionSelect];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload{
    self.guidePageAction = nil;
    self.pageControl = nil;
    self.scrollView = nil;
    
    [super viewDidUnload];
}
-(void)dealloc{
    [guidePageAction release];
    [pageControl release];
    [scrollView release];
    [downloadUrl release];
    [super dealloc];
}
@end
