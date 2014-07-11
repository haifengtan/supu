//
//  UIPickerTitleView.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-30.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "UIPickerTitleView.h"

@interface UIPickerTitleView ()

@property (retain, nonatomic) UIView *titleview;
@property (retain, nonatomic) UILabel *titlelabel;

@end

@implementation UIPickerTitleView
@synthesize titleview;
@synthesize titlelabel;
@synthesize pickerview = _pickerview;
@synthesize pickviewtitle = _pickviewtitle;
@synthesize delegate;

- (void)dealloc
{
    [titleview release];
    [titlelabel release];
    [_pickerview release];
    [_pickviewtitle release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化头部的视图
        titleview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        [self addSubview:titleview];
        
        //设置背景图片
        UIImageView *backgroundimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        UIImage *backgroundimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_023@2x" ofType:@"png"]];
        backgroundimageview.image = backgroundimage;
        [titleview addSubview:backgroundimageview];
        [backgroundimageview release];
        
        //给头部视图加上中间显示文字的title
        titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, frame.size.width, 21)];
        titlelabel.backgroundColor = [UIColor clearColor];
        [titlelabel setFont:[UIFont boldSystemFontOfSize:14]];
        titlelabel.textColor = [UIColor whiteColor];
        titlelabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:titlelabel];
        
        //给头部视图加上回退按钮
        UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 42, 42)];
        UIImage *btnimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_021@2x" ofType:@"png"]];
        [backbtn setBackgroundImage:btnimage forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [titleview addSubview:backbtn];
        [backbtn release];
        
        //给头部视图加上确定按钮
        UIButton *okbtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-52, 0, 42, 42)];
        UIImage *okimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_020.press@2x" ofType:@"png"]];
        [okbtn setBackgroundImage:okimage forState:UIControlStateNormal];
        [okbtn addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [titleview addSubview:okbtn];
        [okbtn release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)ok:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
}

- (void)setPickviewtitle:(NSString *)pickviewtitle
{
    [pickviewtitle retain];
    [_pickviewtitle release];
    _pickviewtitle = pickviewtitle;
    self.titlelabel.text = _pickviewtitle;
}

- (void)setPickerview:(UIPickerView *)pickerview
{
    [pickerview retain];
    [_pickerview release];
    _pickerview = pickerview;
    _pickerview.frame = CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44);
    [self addSubview:_pickerview];
}

@end
