//
//  PersonalMessageView.m
//  SuPu
//
//  Created by 鑫 金 on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "PersonalMessageView.h"

@interface PersonalMessageView ()

@property BOOL isPad;

@end

@implementation PersonalMessageView
@synthesize member;
@synthesize isPad;

- (void)dealloc
{
    [member release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame memberInfo:(Member *)memberinfo
{
    self.isPad = iPad;
    self = [super initWithFrame:frame];
    if (self) {
        self.member = memberinfo;
        NSString *username = self.member.maccount;
        
        int userlevel = self.member.mlevel.intValue;
        
        UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height-1)];
        backgroundview.image = [UIImage imageNamed:@"背景.png"];
        [self addSubview:backgroundview];
        [backgroundview release];
        
        UIImageView *personalpicture= nil;
        UILabel *usernamelable = nil;
        UILabel *usernamemessagelabel = nil;
        UIImageView *imageview = nil;
        UILabel *scorelable = nil;
        UILabel *scoremessagelable = nil;
        UILabel *moneylable = nil;
        UILabel *moneymessagelable = nil;
        if (self.isPad) {
            personalpicture = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, 100, 100)];
            personalpicture.contentMode = UIViewContentModeScaleAspectFit;
            usernamelable = [[UILabel alloc] initWithFrame:CGRectMake(175, 15, 100, 30)];
            usernamelable.font = [UIFont boldSystemFontOfSize:24];
            CGSize usernamesize = [username sizeWithFont:[UIFont boldSystemFontOfSize:24]];
            usernamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 15, usernamesize.width, 30)];
            usernamemessagelabel.font = [UIFont boldSystemFontOfSize:24];
            imageview = [[UIImageView alloc] initWithFrame:CGRectMake(275+usernamesize.width+6, 18, 24, 24)];
            scorelable = [[UILabel alloc] initWithFrame:CGRectMake(175, 50, 80, 30)];
            scorelable.font = [UIFont boldSystemFontOfSize:24];
            scoremessagelable = [[UILabel alloc] initWithFrame:CGRectMake(260, 50, 300, 30)];
            scoremessagelable.font = [UIFont boldSystemFontOfSize:24];
            moneylable = [[UILabel alloc] initWithFrame:CGRectMake(175, 85, 180, 30)];
            moneylable.font = [UIFont boldSystemFontOfSize:24];
            moneymessagelable = [[UILabel alloc] initWithFrame:CGRectMake(360, 85, 250, 30)];
            moneymessagelable.font = [UIFont boldSystemFontOfSize:24];
        }else{
            personalpicture = [[UIImageView alloc] initWithFrame:CGRectMake(16, 7, 50, 50)];
            personalpicture.contentMode = UIViewContentModeScaleAspectFit;
            usernamelable = [[UILabel alloc] initWithFrame:CGRectMake(82, 7, 48, 16)];
            usernamelable.font = [UIFont boldSystemFontOfSize:12];
            CGSize usernamesize = [username sizeWithFont:[UIFont boldSystemFontOfSize:12]];
            usernamemessagelabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 7, usernamesize.width, 16)];
            usernamemessagelabel.font = [UIFont boldSystemFontOfSize:12];
            imageview = [[UIImageView alloc] initWithFrame:CGRectMake(130+usernamesize.width+3, 9, 12, 12)];
            scorelable = [[UILabel alloc] initWithFrame:CGRectMake(82, 25, 40, 16)];
            scorelable.font = [UIFont boldSystemFontOfSize:12];
            scoremessagelable = [[UILabel alloc] initWithFrame:CGRectMake(125, 25, 200, 16)];
            scoremessagelable.font = [UIFont boldSystemFontOfSize:12];
            moneylable = [[UILabel alloc] initWithFrame:CGRectMake(82, 42, 85, 16)];
            moneylable.font = [UIFont boldSystemFontOfSize:12];
            moneymessagelable = [[UILabel alloc] initWithFrame:CGRectMake(167, 42, 150, 16)];
            moneymessagelable.font = [UIFont boldSystemFontOfSize:12];
        }
        //会员头像

        [personalpicture  imageViewLayer];
        [personalpicture setImageWithURL:URLImagePath(member.mimageUrl) placeholderImage:[UIImage imageNamed:@"handsomeboy.png"]];

        [self addSubview:personalpicture];
        [personalpicture release];
        
        usernamelable.text = @"用户名：";
        usernamelable.backgroundColor = [UIColor clearColor];
     
        [self addSubview:usernamelable];
        [usernamelable release];
        
        usernamemessagelabel.text = username;
        usernamemessagelabel.backgroundColor = [UIColor clearColor];
        [self addSubview:usernamemessagelabel];
        [usernamemessagelabel release];
        
        
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"level-%d.gif",userlevel]];
        [self addSubview:imageview];
        [imageview release];
        
        scorelable.text = @"积分:";
        scorelable.backgroundColor = [UIColor clearColor];
        [self addSubview:scorelable];
        [scorelable release];
        
        scoremessagelable.text = self.member.mscores;
        scoremessagelable.backgroundColor = [UIColor clearColor];
        [self addSubview:scoremessagelable];
        [scoremessagelable release];
        
        moneylable.text = @"现金账户余额：";
        moneylable.backgroundColor = [UIColor clearColor];
        [self addSubview:moneylable];
        [moneylable release];
        
        moneymessagelable.text = self.member.mprice;
        moneymessagelable.backgroundColor = [UIColor clearColor];
        [self addSubview:moneymessagelable];
        [moneymessagelable release];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self setNeedsDisplay];
    }
    return self;
}
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 0.75, 0.75, 0.76 , 1.00);//设置颜色
    CGContextSetLineWidth(context, 1);//宽度
    
    if(self.isPad){
        CGContextMoveToPoint(context, 0, 130);//设置起点
        CGContextAddLineToPoint(context, 768, 130);//设置下一个点
    }else{
        CGContextMoveToPoint(context, 0, 65);//设置起点
        CGContextAddLineToPoint(context, 320, 65);//设置下一个点
    }
	CGContextStrokePath(context);//画
}

@end
