//
//  SPProductLargeImageViewController.m
//  SuPu
//
//  Created by cc on 12-11-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPProductLargeImageViewController.h"
#import "UIImageView+WebCache.h"
#import "SPProductDetailData.h"
#import "CustomPageControl.h"
@interface SPProductLargeImageViewController ()

@property (retain, nonatomic) CustomPageControl *pageControl;
@end

@implementation SPProductLargeImageViewController
@synthesize imageurl;
@synthesize imageurlArray;
@synthesize tapIndex;

@synthesize pageControl;
@synthesize imageScrollView;
- (void)dealloc
{
    [imageurl release];
    [imageurlArray release];
    [pageControl release];
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
    [super viewDidLoad];
    self.title = @"商品大图";
    self.UMStr = @"商品大图";
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    float width;
    float height;
    if (iPad) {
        
        width = 768;
        height = 1024-20-99-40;
 
    }else{
        width = 320;
        height = [SPStatusUtility getScreenHeight] - 20 - kNavHeight - kTabbarHeight;
    }
    //内存警告4
    self.imageScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)] autorelease];
    self.imageScrollView.backgroundColor = [UIColor whiteColor];
    self.imageScrollView.delegate =self;
    self.imageScrollView.tag = 888;
    self.imageScrollView.contentOffset = CGPointMake(width*tapIndex,0.0);
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.scrollEnabled = YES;
    int number = self.imageurlArray.count;
    self.imageScrollView .contentSize = CGSizeMake(width*number, height);
    for (int i=0;i<number;i++) {
//        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//        [doubleTap setNumberOfTapsRequired:2];
        
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(width, height);
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
        [s setZoomScale:1.0];
        
                
        SPProductGoodsImage *goodsImage = [self.imageurlArray objectAtIndex:i];
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URLImagePath(goodsImage.mImgFile)]];
        
//        float offx = ((width - image.size.width)/2)>0?(width - image.size.width)/2:0;
//        float offy = ((height - image.size.height)/2)>0?(height - image.size.height)/2:0;
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width,height)];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        if (iPad) {
            [imageview setImageWithURL:URLImagePath(goodsImage.mImgFile) placeholderImage:[UIImage imageNamed:@"768-1024.png"]];
        }else{
            [imageview setImageWithURL:URLImagePath(goodsImage.mImgFile) placeholderImage:[UIImage imageNamed:@"320-370.png"]];
        }
        
        [s addSubview:imageview];
//        [imageview addGestureRecognizer:doubleTap];
        [self.imageScrollView addSubview:s];
        [s release];
        [imageview release];
        
    }
    if (iPad) {
         pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, 0, 768, 40)];
    }else
         pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    pageControl.hidesForSinglePage = YES;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.userInteractionEnabled = NO;
    pageControl.numberOfPages = number; //总页码
    pageControl.currentPage = tapIndex;    //当前页码
    pageControl.otherColour = [UIColor colorWithRed:0.44 green:0.43 blue:0.44 alpha:1.00];//其他点的颜色
    pageControl.currentColor = [UIColor redColor];  //当前点的颜色
    [self.view addSubview: self.imageScrollView ];
    [self.view  addSubview:pageControl];
    [imageScrollView release];
    [pageControl release];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 
#pragma mark UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
 
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    if (scrollView.tag == 888) {
        int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        pageControl.currentPage = index;
    }
    
//    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
//    pageControl.currentPage = index;
    
    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
}

-(void)scale:(UIScrollView *)scorll{
    float newScale = [scorll zoomScale];
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:scorll withCenter:self.view.center];
    [scorll zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
@end
